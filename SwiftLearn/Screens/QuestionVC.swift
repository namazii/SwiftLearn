//
//  QuestionVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import UIKit

/*
 Sections {
 question {
 text
 code
 }
 answers: [answers]
 
 button
 }
 
 */

enum SectionType: Int, CaseIterable {
    case question = 0
    case answers
    case button
}

enum QuestionType: Int, CaseIterable {
    case text = 0
    case code
}

final class QuestionVC: UIViewController {
    
    //MARK: - Properties
    var question: QuestionsJSON!
    var questions: [QuestionsJSON] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.allowsMultipleSelection = true
        
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
        tableView.register(CodeCell.self, forCellReuseIdentifier: CodeCell.identifier)
        tableView.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.identifier)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        fetchQuestions()
        tableView.reloadData()
        
    }
    
    private func fetchQuestions() {
        if let questionsData = NetworkManager.shared.readLocalFile(forName: "data") {
            let questions = NetworkManager.shared.pars(jsonData: questionsData)!
            question = questions
        }
    }
    
    //MARK: - PrivateMethods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.pinEdgesToSuperView()
    }
    
}

//MARK: - UITableViewExtension
extension QuestionVC: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return 1
        
        if let sectionType = SectionType.init(rawValue: section) {
            
            switch sectionType {
            case .question: return 2
            case .answers: return question.answers.count
            case .button: return 1
            }
        }
        return 0
    }
    
    //MARK: - HeightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let sectionType = SectionType.init(rawValue: indexPath.section) {
            
            switch sectionType {
                
            case .question:
                
                if let questionType = QuestionType.init(rawValue: indexPath.row) {
                    
                    switch questionType {
                    case .text:
                        return question.text.isEmpty ? 0 : UITableView.automaticDimension
                        
                    case .code:
                        return question.code.isEmpty ? 0 : UITableView.automaticDimension
                    }
                }
                
            case .answers:
                print(UITableView.automaticDimension)
                return UITableView.automaticDimension
            case .button:
                return 100
            }
        }
        return 0
    }
    
    //MARK: - CellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let sectionType = SectionType.init(rawValue: indexPath.section) {
            
            switch sectionType {
                
            case .question:
                if let questionType = QuestionType.init(rawValue: indexPath.row) {
                    let questionMultipleSelection = question.type
                    if questionMultipleSelection == "single" {
                        tableView.allowsMultipleSelection  = false
                    } else {
                        tableView.allowsMultipleSelection  = true
                    }
                    
                    switch questionType {
                    case .text:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath) as? TextCell else { return UITableViewCell() }
                        cell.configure(question.text)
                        cell.selectionStyle = .none
                        return cell
                    case .code:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: CodeCell.identifier, for: indexPath) as? CodeCell else { return UITableViewCell() }
                        cell.configure(question.code)
                        cell.selectionStyle = .none
                        return cell
                    }
                }
                
            case .answers:
                
                let answer = question.answers[indexPath.row]
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.identifier, for: indexPath) as? AnswerCell else { return UITableViewCell() }
                cell.configure(answer.text)
                cell.selectionStyle = .none
                return cell
                
            case .button:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else { return UITableViewCell() }
                cell.configure("ButtonPress")
                cell.selectionStyle = .none
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}
