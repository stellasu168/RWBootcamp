//
//  ViewController.swift
//  ComparisonShopper
//
//  Created by Jay Strawn on 6/15/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Left
    @IBOutlet weak var titleLabelLeft: UILabel!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var priceLabelLeft: UILabel!
    @IBOutlet weak var roomLabelLeft: UILabel!

    // Right
    @IBOutlet weak var titleLabelRight: UILabel!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var priceLabelRight: UILabel!
    @IBOutlet weak var roomLabelRight: UILabel!

    var house1: House?
    var house2: House?

    override func viewDidLoad() {
        super.viewDidLoad()
        house1 = House(address: nil, price: "$12,000", bedrooms: "3 bedrooms" )
        setUpLeftSideUI()
        setUpRightSideUI() 
    }

    func setUpLeftSideUI() {
        if (house1?.address) != nil {
            titleLabelLeft.text = house1?.price!
        } else {
            titleLabelLeft.text = "Address is nil"
        }
        
        if (house1?.price) != nil {
            priceLabelLeft.text = house1?.price!
        } else {
            priceLabelLeft.text = "Price is nil"
        }
        
        if (house1?.bedrooms) != nil {
            roomLabelLeft.text = house1?.bedrooms!
        } else {
            roomLabelLeft.text = "Bedrooms is nil"
        }
    }

    func setUpRightSideUI() {
        if house2 == nil {
            titleLabelRight.alpha = 0
            imageViewRight.alpha = 0
            priceLabelRight.alpha = 0
            roomLabelRight.alpha = 0
        } else {
            titleLabelRight.text! = house2!.address!
            priceLabelRight.text! = house2!.price!
            roomLabelRight.text! = house2!.bedrooms!
            titleLabelRight.alpha = 1
            imageViewRight.alpha = 1
            priceLabelRight.alpha = 1
            roomLabelRight.alpha = 1
        }
    }

    @IBAction func didPressAddRightHouseButton(_ sender: Any) {
        openAlertView()
    }

    func openAlertView() {
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "address"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "price"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "bedrooms"
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
            let house = House(address: alert.textFields![0].text, price: alert.textFields?[1].text, bedrooms: alert.textFields?[2].text)
            self.house2 = house
            //self.house2 = House(address: alert.textFields![0].text, price: alert.textFields?[1].text, bedrooms: alert.textFields?[2].text)
            self.setUpRightSideUI()
        }))

        self.present(alert, animated: true, completion: nil)
    }

}

struct House {
    var address: String?
    var price: String?
    var bedrooms: String?
    
    init(address: String?, price: String?, bedrooms: String?) {
        self.address = address
        self.price = price
        self.bedrooms = bedrooms
    }
}

