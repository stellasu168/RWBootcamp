/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*
* Modified by Stella Su
* Date: June 10, 2020
*/

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let game = BullsEyeGame()
    var guessingRGB = RGB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.newRound()
        updateView()
    }
  
    @IBAction func aSliderMoved(sender: UISlider) {
        
        switch sender {
        case redSlider:
            guessingRGB.r = Int(sender.value)
            redLabel.text = "R: \(guessingRGB.r)"
            
        case greenSlider:
            guessingRGB.g = Int(sender.value)
            greenLabel.text = "G: \(guessingRGB.g)"
            
        case blueSlider:
            guessingRGB.b = Int(sender.value)
            blueLabel.text = "R: \(guessingRGB.b)"
            
        default:
            break
        }
        
        guessLabel.backgroundColor = UIColor(rgbStruct: guessingRGB)
        
    }
  
  // When 'hit me' button is pressed
    @IBAction func showAlert(sender: AnyObject) {
        
        game.calculateRoundResult(for: guessingRGB, against: game.targetValue)
        
        // Can caulcuate the message here since it's a UI thing
        
        
        // Show the alert message
        let alert = UIAlertController(title: game.alertMessage,
                                      message: "You scored \(game.roundScore) points",
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            
            // Reset the slider to the middle
            self.resetSliders()
            self.game.newRound()
            self.updateView()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
  
    func resetSliders(){
        redSlider.value = 128
        greenSlider.value = 128
        blueSlider.value = 128
    }
    
    @IBAction func startOver(sender: AnyObject) {
        game.startOver()
        updateView()
  }
  
    func updateView() {
        guessingRGB = RGB()
        
        targetLabel.backgroundColor = UIColor(rgbStruct: game.targetValue)
        guessLabel.backgroundColor = UIColor(rgbStruct: guessingRGB)
        
        redLabel.text = String(Int(redSlider.value))
        greenLabel.text = String(Int(greenSlider.value))
        blueLabel.text = String(Int(blueSlider.value))
        
        roundLabel.text = "Round: \(game.roundNumber)"
        scoreLabel.text = "Score: \(game.totalScore)"
    }
  
}

