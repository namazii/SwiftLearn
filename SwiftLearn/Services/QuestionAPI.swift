//
//  modelQuestion.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import Foundation

class QuestionsAPI {
    
    //static let shared = QuestionsAPI()
    //private init() {}
    
    func fetchQuestions(name: String) -> [Question] {
        guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json") else { return [] }
        
        do {
            guard let json = try String(contentsOfFile: bundlePath).data(using: .utf8) else { return [] }
            let response = try JSONDecoder().decode(QuestionResponse.self, from: json)
            let questions = response.items
            return questions
            
        } catch {
            print(error)
        }
        return []
    }

    
//    func readLocalFile(forName name: String) -> Data? {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
//               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                print(jsonData)
//                return jsonData
//            }
//        } catch {
//            print(error)
//        }
//
//        return nil
//    }
//
//    func mapping(json: Data) -> QuestionsJSON? {
//        do {
//            let decodedData = try JSONDecoder().decode(QuestionsJSON.self, from: json)
//            print(decodedData)
//            return decodedData
//        } catch {
//            print("decode error")
//            return nil
//        }
//    }
//    func readLocalFile(forName name: String) -> Data? {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
//               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                return jsonData
//            }
//        } catch {
//            print(error)
//        }
//
//        return nil
//    }
//
//    func pars(jsonData: Data) -> [QuestionsJSON]? {
//        do {
//            let decodedData = try JSONDecoder().decode(QuestionsJSON.self, from: jsonData)
//            print(decodedData.text)
//            return [decodedData]
//        } catch {
//            print("decode error")
//            return nil
//        }
//    }

}

