//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue {
    var id: Int
    var answer : String
    var question : String
    var value : Int
    var airdate: String
    var created_at: String
    var updated_at: String
    var category_id: Int
    var game_id : Int
    var invalid_count: Int
    var category : Category
}

struct Category {
    var id : Int
    var title : String
    var created_at : String
    var updated_at : String
    var clues_count : Int
}
