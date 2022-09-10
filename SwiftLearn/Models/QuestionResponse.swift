//
//  JSON.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import Foundation

// MARK: - QuestionsResponse
struct QuestionResponse: Codable {
    let count: Int
    let items: [Question]
}

// MARK: - Item
struct Question: Codable {
    let id: Int
    let text: String
    let code: String?
    let type: String
    let image, topic: [String]
    let answers: [Answer]
}

// MARK: - Answer
struct Answer: Codable {
    let id: Int
    let status: Bool
    let text: String
}


