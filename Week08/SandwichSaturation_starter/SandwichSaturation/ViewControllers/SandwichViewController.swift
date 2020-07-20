//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
    let searchController = UISearchController(searchResultsController: nil)
    var sandwiches = [SandwichData]()
    var filteredSandwiches = [SandwichData]()
    
    // Homework - from lecture Core data part 1
    // Homework - part 1 (Save the selected index into User Defaults)
    let defaults = UserDefaults.standard
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSandwiches()
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
        
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.delegate = self

    // Homework - part 1 (Save the selected index into User Defaults)
    searchController.searchBar.selectedScopeButtonIndex = defaults.integer(forKey: "selectedScope")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
    // Seeded with some sandwich data
  func loadSandwiches() {
//    let sandwichArray = [SandwichData(name: "Bagel Toast", sauceAmount: .none, imageName: "sandwich1"),
//                         SandwichData(name: "Bologna", sauceAmount: .none, imageName: "sandwich2"),
//                         SandwichData(name: "Breakfast Roll", sauceAmount: .none, imageName: "sandwich3"),
//                         SandwichData(name: "Club", sauceAmount: .none, imageName: "sandwich4"),
//                         SandwichData(name: "Sub", sauceAmount: .none, imageName: "sandwich5"),
//                         SandwichData(name: "Steak", sauceAmount: .tooMuch, imageName: "sandwich6"),
//                         SandwichData(name: "Dunno", sauceAmount: .tooMuch, imageName: "sandwich7"),
//                         SandwichData(name: "Torta", sauceAmount: .tooMuch, imageName: "sandwich8"),
//                         SandwichData(name: "Ham", sauceAmount: .tooMuch, imageName: "sandwich9"),
//                         SandwichData(name: "Lettuce", sauceAmount: .tooMuch, imageName: "sandwich10")]
//    sandwiches.append(contentsOf: sandwichArray)
    
    // Homework - part 2 (Loading Objects form JSON)
    let sandwichPath = Bundle.main.path(forResource: "sandwiches", ofType: "json")!
    let sandwichURL = URL(fileURLWithPath: sandwichPath)
    let data = try! Data(contentsOf: sandwichURL)
    
    let decoder = JSONDecoder()
    let sandwiches = try! decoder.decode([SandwichData].self, from: data)
    self.sandwiches.append(contentsOf: sandwiches)
  }

  func saveSandwich(_ sandwich: SandwichData) {
    sandwiches.append(sandwich)
    tableView.reloadData()
  }
    
  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String,
                                  sauceAmount: SauceAmount? = nil) {
    filteredSandwiches = sandwiches.filter { (sandwhich: SandwichData) -> Bool in
        let doesSauceAmountMatch = sauceAmount == .any || sandwhich.sauceAmount == sauceAmount
        
        if isSearchBarEmpty {
            return doesSauceAmountMatch
        } else {
            return doesSauceAmountMatch && sandwhich.name.lowercased()
                .contains(searchText.lowercased())
        }
    }
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ?
      filteredSandwiches[indexPath.row] :
      sandwiches[indexPath.row]

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.description

    return cell
  }
}

// MARK: - Helper Functions
// Homework - part 1 (Save the selected index into User Defaults)
func determineCurrentScopeSauceAmountIndex(for sauceAmount: SauceAmount?) -> Int {
  switch(sauceAmount) {
  case .any:
    return 0
  case .tooMuch:
    return 2
  default:
    return 1
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    
    // Homework - part 1 (Save the selected index into User Defaults)
    let sauceAmountRawValue = defaults.object(forKey: "SauceType") as? String ?? String()
    
    let sauceAmount: SauceAmount?
    if sauceAmountRawValue.isEmpty {
      sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    } else {
      sauceAmount = SauceAmount(rawValue: sauceAmountRawValue)
      searchBar.selectedScopeButtonIndex = determineCurrentScopeSauceAmountIndex(for: sauceAmount)
    }
    
    //    let sauceAmount = SauceAmount(rawValue:
    //    searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
   
    // Homework - part 1 (Save the selected index into User Defaults)
    defaults.set(sauceAmount?.rawValue, forKey: "SauceType")

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}


