//
//  JSON.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import Foundation

// MARK: - Questions
struct QuestionResponse: Codable {
    let count: Int
    let items: [Question]
}

// MARK: - Item
struct Question: Codable {
    let id: Int
    let text: String
    let code: String?
    let type: String //тип вопроса: single, multiline, edit
    let image: [String]
    let topic: [String] //тема или подтема: swift, optional
    let answers: [Answer]
}

// MARK: - Answer
struct Answer: Codable {
    let id: Int
    let status: Bool
    let text: String
}


