//
//  CellModel.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 11.08.2022.
//

import Foundation

struct Question: Encodable {
    
    var id: String
    var text: String
    var code: String
    var type: String
    
}

struct Answer {
    
    var id: String
    var status: Bool
    var text: String
    
}
