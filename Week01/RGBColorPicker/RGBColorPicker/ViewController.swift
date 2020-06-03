//
//  ViewController.swift
//  RGBColorPicker
//
//  Created by Stella Su on 5/31/20.
//  Copyright © 2020 Stella Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var setColorButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var redVal = Float()
    var greenVal = Float()
    var blueVal = Float()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0
        
    }
    
    @IBAction func redSliderMoved(_ slider: UISlider){
        print(slider.value)
        redSlider.value = slider.value
        var currentValue = Int()
        currentValue = Int(slider.value.rounded())
        redLabel.text = String(currentValue)
    }
    
    @IBAction func greenSliderMoved(_ slider: UISlider){
        print(slider.value)
        greenSlider.value = slider.value
        var currentValue = Int()
        currentValue = Int(slider.value.rounded())
        greenLabel.text = String(currentValue)
    }
    
    @IBAction func blueSliderMoved(_ slider: UISlider){
        print(slider.value)
        blueSlider.value = slider.value
        var currentValue = Int()
        currentValue = Int(slider.value.rounded())
        blueLabel.text = String(currentValue)
    }
    
    @IBAction func setColor(_ sender: Any) {
        
        let alert = UIAlertController(title: "Set Your Color", message: "Please enter the color", preferredStyle: .alert)

        // Add textFields in alert
        alert.addTextField(configurationHandler: nil)
        // Action is from left to right
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler:  {
            (_) in
            // Add some error checking here
            //print(alert.textFields![0].text)
            self.colorName.text = alert.textFields![0].text
            self.assignLabelsAndBackground()
        }))

        // Show the alert view
        self.present(alert, animated: true, completion: nil)
    
    }
    
    func assignLabelsAndBackground(){
                
        redVal = redSlider.value
        greenVal = greenSlider.value
        blueVal = blueSlider.value
    
        view.backgroundColor = UIColor(red: CGFloat(redVal), green: CGFloat(greenVal), blue: CGFloat(blueVal), alpha: 1.0)

    }
    
    @IBAction func reset(_ sender: Any) {
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0
        redLabel.text = String(0)
        greenLabel.text = String(0)
        blueLabel.text = String(0)
        colorName.text = "Color Name"
        view.backgroundColor = .white
    }
    
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
