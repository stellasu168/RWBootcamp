//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

//struct QuestionViewModel {
//  let categoryTitle: String
//  let question: String
//  let correctAnswer: String
//  let options: [String]
//  let points: String
//
//  init(clues: [Clue]) {
//    let firstClue = clues.first
//    categoryTitle = firstClue?.category.title ?? "Category"
//    question = firstClue?.question ?? "Question"
//    correctAnswer = firstClue?.answer ?? "Answer"
//    points = String(firstClue?.points ?? 10)
//    var opts = [String]()
//    for clue in clues {
//      opts.append(clue.answer)
//    }
//    options = opts.shuffled()
//  }
//}

class Networking {
    static let sharedInstance = Networking()
    //private init(){}
    
    // URLSession - GET
    func getRandomCategory(completion: @escaping (Category) -> Void ) {
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
                //print(data)
                do {
                    let decoder = JSONDecoder()
                    let jsonDict = try decoder.decode([Clue].self, from: data)
                    print("The questions is: \(jsonDict[0].question)")
                    print("json category id is \(jsonDict[0].category.id)")
//                  DispatchQueue.main.async{
//                      print(jsonDict)
//                  }
                    //completion(jsonDict[0].category.id)
                    completion(jsonDict[0].category)
                } catch let error {
                    print("Decoding error: \(error)")
                }
            }
        })
        task.resume()
        
        
    }
    
    
    // Limit the number of clues to 4.
    // Return array of clues
    func getAllCluesInCategory(_ category: Category, completion: @escaping ([Clue]) -> Void) {
        guard let url = URL(string: "http://www.jservice.io/api/clues/?category=\(category.id)") else {
            fatalError("Error: cannot create http://www.jservice.io/api/clues/?category=\(category.id)")
            return
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
                //print("Got network data: \(data)")
                do {
                    let jsonDict = try JSONDecoder().decode([Clue].self, from: data)
                    print("\(jsonDict)")
                    //print("\(jsonDict[0].category.id)")
                    // Passing back the first 4 clues
                    //let options = Array(jsonDict.prefix(4))
                    //completion(options)
                    completion(jsonDict)
                } catch let error {
                    print("Decoding error: \(error)")
                }
            }
        }
        task.resume()
    }
    
}
