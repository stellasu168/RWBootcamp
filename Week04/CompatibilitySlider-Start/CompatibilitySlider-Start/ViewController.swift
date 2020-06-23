//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!

    var compatibilityItems = ["Cats", "Dogs", "Hiking", "Painting", "Traveling", "Reading", "Singing"]
    var currentItemIndex = 0

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }

    func resetGame(){
        currentItemIndex = 0
        questionLabel.text = "Person 1, how do you feel about..."
        currentPerson = person1
        compatibilityItemLabel.text = compatibilityItems[0].description
    }
    @IBAction func didPressNextItemButton(_ sender: Any) {
        // Save the user's score for the first item as a dictionary
        let currentItem = compatibilityItems[currentItemIndex]
        currentPerson?.items.updateValue(slider.value, forKey: currentItem)
        currentItemIndex += 1
        // Go to the next item in the array compatibilityItems
        if (currentPerson?.id == 2 && (currentItemIndex == compatibilityItems.count)) {
            
            let alert = UIAlertController(title: "Results", message: "You two are \(calculateCompatibility()) compatible.", preferredStyle: .alert)
            
            //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
               (_) in
                self.resetGame()
            }))
            
            // Show the alert view
            self.present(alert, animated: true, completion: nil)
            
            
        } else if currentItemIndex < compatibilityItems.count {
            compatibilityItemLabel.text = compatibilityItems[currentItemIndex].description
        } else {
            currentPerson = person2
            questionLabel.text = "Person 2, how do you feel about..."
            compatibilityItemLabel.text = compatibilityItems[0].description
            currentItemIndex = 0
        }
    }

    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []

        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)/5.0
            percentagesForAllItems.append(Double(difference))
        }

        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
        print(matchPercentage, "%")
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }

}

