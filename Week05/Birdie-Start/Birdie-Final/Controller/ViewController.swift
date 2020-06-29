//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
      
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        //tableview.estimatedRowHeight = 100.0
        //tableview.rowHeight = UITableView.automaticDimension
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    //set the delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {

        // Make a UIAlert pop up that asks for the user's username and the text of the post
        
        // You can add the new text post with MediaPostsHandler.shared.addTextPost.
        
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(MediaPostsHandler.shared.mediaPosts.count)
        return 3
        
    }
    
    // Get call everytime a tableview needs a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // reload
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostListItemCell", for: indexPath)
        
        return cell
    }
}



