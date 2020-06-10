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
*/

import Foundation

class BullsEyeGame {
    
    var totalScore: Int = 0
    var roundScore: Int = 0
    var roundNumber: Int = 0
    var alertMessage: String = ""
    var targetValue = RGB()
    
    func newRound() {
        roundNumber += 1
        targetValue.randomColor()
    }
    
    func startOver() {
        totalScore = 0
        roundNumber = 0
        roundScore = 0
        newRound()
    }

    // Change some stuff here later
    func calculateRoundResult(for guess: RGB, against target: RGB) {
        
       let difference = guess.difference(target: target) * 100
       roundScore = 100 - Int(difference)
       
       totalScore = totalScore + roundScore

       switch difference {
       case 0:
         roundScore += 100
         alertMessage = "Perfect!"
         
       case 0...1:
         roundScore += 50
         alertMessage = "You almost had it!"
         
       case 1..<5:
         alertMessage = "You almost had it!"
         
       case 5..<10:
         alertMessage = "Pretty good!"
         
       default:
         alertMessage = "Not even close..."
       }

     }
         
}
