//
//  SauceAmountModel+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Stella Su on 7/20/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SauceAmountModel)
public class SauceAmountModel: NSManagedObject {
  var sauceAmount: SauceAmount {
    get {
      guard let sauceAmountString = self.amount,
        let amount = SauceAmount(rawValue: sauceAmountString) else {
          return .none
      }

      return amount
    }

    set {
      self.amount = newValue.rawValue
    }
  }
}
