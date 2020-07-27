//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!

    var clues: [Clue] = []
    var correctAnswerClue: Clue?
    var points: Int = 0
    var answers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        //getClues()
        
        self.clueLabel.text = ""
        self.categoryLabel.text = ""
        self.scoreLabel.text = "\(self.points)"

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }

        SoundManager.shared.playSound()
        
        populateQuestions()
        
    }

//    func getClues(){
//        Networking.sharedInstance.getRandomCategory(completion: { (categoryId) in
//            guard let id = categoryId else { return }
//            Networking.sharedInstance.getAllCluesInCategory(categoryId: id) { (clues) in
//                self.clues = clues
//                //print("Clues = \(self.clues)")
//                //self.setUpView()
//            }
//        })
//    }
    
    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = answers[indexPath.row]
        cell.backgroundColor = view.backgroundColor
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if answers[indexPath.row] == correctAnswerClue?.answer {
            points += 100
            self.scoreLabel.text = "\(self.points)"
          }
          populateQuestions()
    }
    
}

extension ViewController {
  
  func populateQuestions() {
    Networking.sharedInstance.getRandomCategory { [weak self] category in
      Networking.sharedInstance.getAllCluesInCategory(category) { clues in
        DispatchQueue.main.async {
          guard let self = self else { return }
          
          let randomClues = clues.shuffled()
          self.correctAnswerClue = randomClues.first
          self.answers = Array(randomClues.prefix(4).map(\.answer)).shuffled()
          self.categoryLabel.text = category.title
          self.clueLabel.text = self.correctAnswerClue?.question ?? "N/A"
          self.tableView.reloadData()
        }
      }
    }
  }
  
}
