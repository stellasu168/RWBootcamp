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
        MediaPostsHandler.shared.getPosts()
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
        let createPostAlert = UIAlertController(title: "Create a post", message: "What's up? :]", preferredStyle: .alert)
        
        createPostAlert.addTextField { (userNameField) in
            userNameField.placeholder = "Username"
            userNameField.autocapitalizationType = .words
        }
        
        createPostAlert.addTextField { (bodyTextfield) in
            bodyTextfield.placeholder = "Create your post here"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let postAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            let username = createPostAlert.textFields![0]
            let post = createPostAlert.textFields![1]
            
            let textPost = TextPost.init(textBody: post.text!, userName: username.text!, timestamp: Date())
            
            MediaPostsHandler.shared.addTextPost(textPost: textPost)
            self.tableview.reloadData()
        }
        
        createPostAlert.addAction(postAction)
        createPostAlert.addAction(cancelAction)
        
        present(createPostAlert, animated: true, completion: nil)
        
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(MediaPostsHandler.shared.mediaPosts.count)
        return MediaPostsHandler.shared.mediaPosts.count
        
    }
    
    // Get call everytime a tableview needs a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mediaPost = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostListItemCell", for: indexPath) as! CustomTableViewCell

        cell.usernameLabel.text = mediaPost.userName
        cell.timeStampLabel.text = mediaPost.timestamp.toString()
        cell.postLabel.text = mediaPost.textBody

        return cell
    }
}

extension Date {
    func toString(withFormat format: String = "d MMM, HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
