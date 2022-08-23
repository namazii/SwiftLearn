//
//  JSON.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import Foundation

// MARK: - Questions
struct QuestionsJSON: Codable {
    let topicCount: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let text: String
    let code: String?
    let type, topic: String
    let answers: [AnswerJSON]
}

// MARK: - Answer
struct AnswerJSON: Codable {
    let id: Int
    let status: Bool
    let text: String
}
