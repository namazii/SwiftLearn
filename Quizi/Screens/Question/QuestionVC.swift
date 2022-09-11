//
//  QuestionVC.swift
//  Quizi
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import UIKit

//MARK: - Enums
fileprivate enum SectionType: Int, CaseIterable {
    case question = 0
    case answers
    case button
}

fileprivate enum QuestionType: Int, CaseIterable {
    case text = 0
    case code
}

final class QuestionVC: UIViewController {
    
    //MARK: - Properties
    private let questionProvider = QuestionProvider.shared
    
    var topic: Topic?
    private var currentQuestion: Question?
    
    private var pressedButton = false
    private var didSelectedCell = false
    var indexRow = IndexPath()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.allowsMultipleSelection = true
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
        tableView.register(CodeCell.self, forCellReuseIdentifier: CodeCell.identifier)
        tableView.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.identifier)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .systemYellow
        progressView.setProgress(0, animated: false)
        
        return progressView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let topicText = topic?.text ?? ""
        questionProvider.fetchQuestions(topicText)
        
        currentQuestion = questionProvider.fetchNextQuestion()
        
        tableView.reloadData()
    }
    
    //MARK: - Private
    private func setupViews() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.titleView = progressView
        
        navigationItem.hidesBackButton = true
        
        view.addSubview(progressView)
        
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.pinEdgesToSuperView()
    }
    private func updateAnsweredQuestionsProgress() {
        let percentProgress = questionProvider.calculateAnsweredQuestions()
        progressView.setProgress(percentProgress, animated: true)
    }
}

//MARK: - UITableViewExtension
extension QuestionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sectionType = SectionType(rawValue: indexPath.section)
        
        switch sectionType {
        case .answers: indexRow = indexPath
        default:
            indexRow = []
            break
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sectionType = SectionType.init(rawValue: section) {
            
            switch sectionType {
            case .question: return 2
            case .answers: return currentQuestion?.answers.count ?? 0
            case .button: return 1
            }
        }
        return 0
    }
    
    //MARK: - HeightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let question = currentQuestion else { return 0 }
        
        if let sectionType = SectionType.init(rawValue: indexPath.section) {
            
            switch sectionType {
            case .question:
                
                if let questionType = QuestionType.init(rawValue: indexPath.row) {
                    switch questionType {
                    case .text:
                        return question.text.isEmpty ? 0 : UITableView.automaticDimension
                    case .code:
                        return (question.code?.isEmpty ?? false) ? 0 : UITableView.automaticDimension
                    }
                }
                
            case .answers:
                return UITableView.automaticDimension
            case .button:
                return 100
            }
        }
        return 0
    }
    
    //MARK: - CellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let question = currentQuestion else { return UITableViewCell() }
        
        if let sectionType = SectionType.init(rawValue: indexPath.section) {
            
            switch sectionType {
                
            case .question:
                if let questionType = QuestionType.init(rawValue: indexPath.row) {
                    
                    if question.type == "single" {
                        tableView.allowsMultipleSelection  = false
                    } else {
                        tableView.allowsMultipleSelection  = true
                    }
                    
                    switch questionType {
                    case .text:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath) as? TextCell else { return UITableViewCell() }
                        
                        cell.configure(question.text)
                        cell.isUserInteractionEnabled = false
                        
                        return cell
                    case .code:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: CodeCell.identifier, for: indexPath) as? CodeCell else { return UITableViewCell() }
                        
                        cell.configure(question.code ?? "")
                        cell.isUserInteractionEnabled = false
                        
                        return cell
                    }
                }
                
            case .answers:
                
                let answer = question.answers[indexPath.row]
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.identifier, for: indexPath) as? AnswerCell else { return UITableViewCell() }
                
                if pressedButton {
                    cell.configure(answer.text, answer.status, bool: true)
                } else {
                    cell.configure(answer.text, answer.status, bool: false)
                }
                cell.selectionStyle = .none
                cell.isSelected = false
                return cell
                
            case .button:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else { return UITableViewCell() }
                
                cell.selectionStyle = .none
                cell.output = self
                return cell
            }
        }
        return UITableViewCell()
    }
}

//MARK: - ButtonCellOutput
extension QuestionVC: ButtonCellOutput {
    
    func checkAnswerAction(state: ButtonState) {
        
        if indexRow.isEmpty { return }
        
        switch state {
            
        case .checkAnswer:
            pressedButton = true
            
            guard let answered = currentQuestion?.answers[indexRow.row] else { return }
            guard let currentQuestion = currentQuestion else { return }
            if answered.status == true {
                questionProvider.questionTrue.append(currentQuestion)
                
            } else {
                questionProvider.questionFalse.append(currentQuestion)
            }
            tableView.reloadData()
            tableView.selectRow(at: indexRow, animated: false, scrollPosition: .none)
            tableView.allowsSelection = false
            
        case .nextAnswer:
            updateAnsweredQuestionsProgress()
            pressedButton = false
            currentQuestion = questionProvider.fetchNextQuestion()
            tableView.reloadData()
            tableView.allowsSelection = true
            indexRow = []
            
            if currentQuestion == nil {
                let vc = ResultVC()
                vc.topic = topic?.text
                vc.questionProvider = questionProvider
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
