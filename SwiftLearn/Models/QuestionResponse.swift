//
//  JSON.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import Foundation
import Firebase

// MARK: - Questions
struct QuestionResponse: Codable {
    let count: Int
    let items: [Question]
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        count = snapshotValue["count"] as! Int
        items = snapshotValue["items"] as! [Question]
    }
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
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        id = snapshotValue["id"] as! Int
//        text = snapshotValue["text"] as! String
//        code = snapshotValue["code"] as? String
//        type = snapshotValue["type"] as! String
//        image = snapshotValue["image"] as! [String]
//        topic = snapshotValue["topic"] as! [String]
//        answers = snapshotValue["answers"] as! [Answer]
//    }
}

// MARK: - Answer
struct Answer: Codable {
    let id: Int
    let status: Bool
    let text: String
}


