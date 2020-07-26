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
    private init(){}
    
    // URLSession - GET
    func getRandomCategory(completion: @escaping (Int?) -> Void ) {
        guard let url = URL(string: "http://www.jservice.io/api/random") else {
            fatalError("Error: cannot create jservice.io/api/random URL")
            return
        }
    
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if let data = data {
                print(data)
                do {
                    let decoder = JSONDecoder()
                    let jsonDict = try decoder.decode([Clue].self, from: data)
                    print(jsonDict)
                    print("json category id is \(jsonDict[0].category.id)")
//                  DispatchQueue.main.async{
//                      print(jsonDict)
//                  }
                    completion(jsonDict[0].category.id)
                } catch let error {
                    print("Decoding error: \(error)")
                }
            }
        })
        task.resume()
        
        
    }
    
    
    // Limit the number of clues to 4.
    // Return array of clues
    func getAllCluesInCategory(categoryId: Int, completion: @escaping ([Clue]) -> ()) {
//        guard let url = URL(string: "http://www.jservice.io/api/clues/?category=\(categoryId)") else {
//            fatalError("Error getting jservice URL")
//        }
        
          let cluesEndpoint: String = "http://www.jservice.io/api/clues/?category=\(categoryId)"
          guard let url = URL(string: cluesEndpoint) else {
            print("Error: Cannot create URL using - \(cluesEndpoint)")
            return
          }
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
              print("Got network data: \(data)")
              do {
                let json = try JSONDecoder().decode([Clue].self, from: data)
                          print("\(json)")
                print("\(json[0].category.id)")
                let options = Array(json.prefix(4))
                completion(options)

              } catch let error {
                print("Decoding error: \(error)")
              }
            }
          }
          task.resume()
        }

}
