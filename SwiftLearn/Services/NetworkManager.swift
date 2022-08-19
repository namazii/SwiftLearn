//
//  modelQuestion.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
     
    private init() {}
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }

    func pars(jsonData: Data) -> QuestionsJSON? {
        do {
            let decodedData = try JSONDecoder().decode(QuestionsJSON.self, from: jsonData)
            print(decodedData.text)
            return decodedData
        } catch {
            print("decode error")
            return nil
        }
    }

}

