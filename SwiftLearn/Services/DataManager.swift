//
//  DataManager.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 18.08.2022.
//

import Foundation

struct DataManager {
    
    static let shared = DataManager()
     
    private init() {}
    
    var questions: [QuestionsJSON] = []
    var wrongAnswers: [QuestionsJSON] = []
    var rightanswers: [QuestionsJSON] = []
    
//    struct QuestionsJSON: Codable {
//        let id: Int
//        let text: String
//        let code: String
//        let type: String
//        let answers: [AnswerJSON]
//    }
//
//    struct AnswerJSON: Codable {
//        let id: Int
//        let status: Bool
//        let text: String
//    }
}
