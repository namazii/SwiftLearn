//
//  JSON.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import Foundation

struct QuestionsJSON: Codable {
    let id: Int
    let text: String
    let code: String
    let type: String
    let answers: [AnswerJSON]
}

struct AnswerJSON: Codable {
    let id: Int
    let status: Bool
    let text: String
}