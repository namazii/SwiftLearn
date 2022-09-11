//
//  DataManager.swift
//  Quizi
//
//  Created by Назар Ткаченко on 18.08.2022.
//

import Foundation

final class QuestionProvider {
    
    static let shared = QuestionProvider()
    
    var questionsResponse: [Question] = []
    private var questions: [Question] = []
    private var allQuestions: [Question] = []
    
    private var currentQuestion: Question?
    
    var questionTrue: [Question] = []
    var questionFalse: [Question] = []
    
    //MARK: - Requests
    func fetchQuestions(_ topic: String) {
        
        let allQuestions = questionsResponse
        
        let filteredQuestions = allQuestions.filter { $0.topic.contains(topic) }
        questions = filteredQuestions
        self.allQuestions = filteredQuestions
    }
    
    func fetchNextQuestion() -> Question? {
        
        let question = questions.first
        
        questions = Array(questions.dropFirst())
        
        return question
    }
    
    func calculateAnsweredQuestions() -> Float {
        let percent = Float(allQuestions.count) / 100
        let percentAnswered = Float(questions.count) / percent
        let percentResult = 1 - (percentAnswered / 100)
        print(percentResult)
        return percentResult
    }
}
