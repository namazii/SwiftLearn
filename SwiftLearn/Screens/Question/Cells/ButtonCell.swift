//
//  ButtonCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 11.08.2022.
//

import UIKit

enum ButtonState {
    case checkAnswer
    case nextAnswer
}

protocol ButtonCellOutput: AnyObject {
    func checkAnswerAction(state: ButtonState)
}

protocol ButtonCellInput: AnyObject {
    //func configure(_ text: String)
}

class ButtonCell: UITableViewCell, ButtonCellInput {

    var buttonState: ButtonState = .checkAnswer

    static let identifier = "ButtonCell"
    
    var output: ButtonCellOutput?

    lazy var answerButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Проверить", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(checkAnswerAction), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
//    func configure(_ text: String) {
//        //answerButton.setTitle("Проверить", for: .normal)
//    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(answerButton)
    }
    
    private func setupConstraints() {
        
        answerButton.snp.makeConstraints { make in
            make.left.top.right.equalTo(contentView).inset(20)
            make.height.equalTo(contentView.snp.height).inset(20)
        }
    }

//    private func isEnabled(_ bool: Bool) {
//        answerButton.isEnabled = bool
//    }
    
    //MARK: - Actions
    @objc func checkAnswerAction(_ sender: UIButton) {
        print("press")
        
        if (output as! QuestionVC).indexRow.isEmpty { return }
        
        self.animateViewPress(sender)
        
        if buttonState == .checkAnswer {
          
            answerButton.setTitle("Следующий", for: .normal)
            
            output?.checkAnswerAction(state: buttonState)
            buttonState = .nextAnswer
            return
        }
        
        if buttonState == .nextAnswer {
           
            answerButton.setTitle("Проверить", for: .normal)
            
            output?.checkAnswerAction(state: buttonState)
            buttonState = .checkAnswer
            return
        }
        
    
    }

}
