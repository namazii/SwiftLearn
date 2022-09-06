//
//  ResultVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 30.08.2022.
//

import UIKit
import SnapKit

class ResultVC: UIViewController {
    
    var questionProvider = QuestionProvider.shared
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Результат\n 23/50\n 48%"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
       return label
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Меню", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(getBack), for: .touchUpInside)
        
        return button
    }()
    
//    let stackViewMain: UIStackView = {
//      let stackView = UIStackView()
//      stackView.translatesAutoresizingMaskIntoConstraints = false
//      stackView.axis = .vertical
//      stackView.alignment = .fill
//      stackView.distribution = .fillEqually
//      stackView.spacing = 8
//
//      return stackView
//  }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
        setupViews()
        setConstraints()
    }
    
    //MARK: - Navigation
    @objc private func getBack(_ sender: UIButton) {
        print("ok")
        view.animateViewPress(sender)
        questionProvider.questionFalse = []
        questionProvider.questionTrue = []
        navigationController?.popToViewController(MenuVC(), animated: true)
    }
    
    private func setupText() {
        let questionsTrue = questionProvider.questionTrue.count
        print(questionsTrue)
        let questionsFalse = questionProvider.questionFalse.count
        print(questionsFalse)
        let summ = questionsTrue + questionsFalse
        let procent = Double(questionsTrue) / Double(summ) * 100
        print(procent)
        resultLabel.text = "Ваш результат:\n \(questionsTrue)/\(summ)\n \(Int(procent))% "
    }
    
    private func setupViews() {
        navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        view.addSubview(resultLabel)
        view.addSubview(menuButton)
//        stackViewMain.addArrangedSubview(resultLabel)
//        stackViewMain.addArrangedSubview(menuButton)
    }
    
    private func setConstraints() {
//        stackViewMain.snp.makeConstraints { make in
//            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
//            make.left.right.equalTo(view).inset(40)
//            make.height.equalTo(view.snp.height).multipliedBy(0.4)
//        }
        resultLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.left.right.equalTo(view).inset(40)
        }
        menuButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
        }


    }

}
