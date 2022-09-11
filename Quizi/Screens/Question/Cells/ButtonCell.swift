//
//  ButtonCell.swift
//  Quizi
//
//  Created by Назар Ткаченко on 11.08.2022.
//

import UIKit

//MARK: - Enum
enum ButtonState {
    case checkAnswer
    case nextAnswer
}

//MARK: - Protocols
protocol ButtonCellOutput: AnyObject {
    func checkAnswerAction(state: ButtonState)
}

protocol ButtonCellInput: AnyObject {
}

final class ButtonCell: UITableViewCell, ButtonCellInput {
    
    //MARK: - Properties
    private var buttonState: ButtonState = .checkAnswer
    
    static let identifier = "ButtonCell"
    
    var output: ButtonCellOutput?
    
    private lazy var answerButton: UIButton = {
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
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(answerButton)
    }
    
    private func setupConstraints() {
        answerButton.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(contentView).inset(10)
        }
    }
    
    //MARK: - Actions
    @objc func checkAnswerAction(_ sender: UIButton) {
        
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
