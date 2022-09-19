//
//  DataManager.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 18.08.2022.
//

import Foundation

//Бизнес-логика - выдавать вопросы
final class QuestionService {
    
    private var questionsAPI = QuestionsAPI()
    
    static let shared = QuestionService()
    
    var questions: [Question] = []
    
    var currentQuestion: Question?
    
    //MARK: - Requests
    func fetchQuestions(_ topic: String) {
        
        let allQuestions = questionsAPI.fetchQuestions(name: "questions")
        let filteredQuestions = allQuestions.filter { $0.topic.contains(topic) }
        questions = filteredQuestions
    }
    
    func fetchNextQuestion() -> Question? {
        
        let question = questions.first
        
        questions = Array(questions.dropFirst())
        
        return question
    }
}
