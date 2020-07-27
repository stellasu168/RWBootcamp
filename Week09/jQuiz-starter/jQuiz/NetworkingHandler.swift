//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {
    static let sharedInstance = Networking()
    
    // URLSession - GET
    func getRandomCategory(completion: @escaping (Category) -> Void ) {
        guard let url = URL(string: "http://www.jservice.io/api/random") else {
            fatalError("Error: cannot create jservice.io/api/random URL")
        }
    
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonDict = try decoder.decode([Clue].self, from: data)
                    completion(jsonDict[0].category)
                } catch let error {
                    print("Decoding error: \(error)")
                }
            }
        })
        task.resume()
    }
    
    // Return array of clues
    func getAllCluesInCategory(_ category: Category, completion: @escaping ([Clue]) -> Void) {
        guard let url = URL(string: "http://www.jservice.io/api/clues/?category=\(category.id)") else {
            fatalError("Error: cannot create http://www.jservice.io/api/clues/?category=\(category.id)")
        }
        print("json category id is \(category.id)")
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let response = response {
                print(response.url ?? "url")
            }
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    let jsonDict = try JSONDecoder().decode([Clue].self, from: data)
                    print("\(jsonDict)")
                    completion(jsonDict)
                } catch let error {
                    print("Decoding error: \(error)")
                }
            }
        }
        task.resume()
    }
    
}
