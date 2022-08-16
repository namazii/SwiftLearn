//
//  QuestionVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import UIKit

enum SectionsCellType: Int, CaseIterable {
    
    case question
    case answers
    case buttonAnswer
}

enum QuestionCellType: Int, CaseIterable {
    
    case text
    case code
    case answer
    case button
}

struct ModelTest {
    var id = 1
    var text = "How cheto tam"
    var code = "var? = 6"
    var type = "Single"
//    var anwers = [Model1]()
}

//struct Model1 {
//    var id = 1
//    var status = false
//    var text = "False"
//}

//struct model2 {
//    var id = 2
//    var status = true
//    var text = "TRUE"
//}

class QuestionVC: UIViewController {
    
    //MARK: Properties
    
    var localQuestionsData: QuestionsJSON!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
        tableView.register(CodeCell.self, forCellReuseIdentifier: CodeCell.identifier)
        tableView.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.identifier)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadLocalJSON()
        
    }
    
    private func loadLocalJSON() {
        if let localData = DataManager.shared.readLocalFile(forName: "data") {
            let questions = DataManager.shared.pars(jsonData: localData)!
            localQuestionsData = questions
        }
    }
    
    //MARK: PrivateMethods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.pinEdgesToSuperView()
    }

}

//MARK: UITableViewExtension
extension QuestionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionsCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return QuestionCellType.allCases.count
//        let cellType = SectionsCellType(rawValue: section)
//
//        switch cellType {
//
//        case .question:
//            return 1
//        case .answers:
//            return 4
//        case .buttonAnswer:
//            return 1
//
//        default: return 0
//        }
        switch(section) {
        case 0:
            return 1
        case 1:
            return 4
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellType = QuestionCellType(rawValue: indexPath.row)
        
        switch cellType {
        case .text:
            return CGFloat(100)
        case .code:
            return CGFloat(100)
        case .answer:
            return CGFloat(100)
        case .button:
            return CGFloat(100)
            
        default: return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath) as? TextCell else { return UITableViewCell() }
            
        let cellType = QuestionCellType(rawValue: indexPath.row)
        
        switch cellType {
        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath) as? TextCell else { return UITableViewCell() }
            cell.configure(localQuestionsData.text)
            return cell
        case .code:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CodeCell.identifier, for: indexPath) as? CodeCell else { return UITableViewCell() }
            cell.configure(localQuestionsData.code)
            return cell
        case .answer:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.identifier, for: indexPath) as? AnswerCell else { return UITableViewCell() }
            cell.configure(localQuestionsData.answers.first!.text)
            return cell
        case .button:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else { return UITableViewCell() }
            cell.configure("ButtonPress")
            return cell
            
        default: return UITableViewCell()
        }
//        cell.configure("How chtoto tam")
//        return cell
    }
    
    
}
