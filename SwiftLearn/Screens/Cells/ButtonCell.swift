//
//  ButtonCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 11.08.2022.
//

import UIKit

class ButtonCell: UITableViewCell {

    static let identifier = "ButtonCell"
    
    lazy var answerButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    @objc func buttonPress(_ sender: UIButton) {
        print("press")
        self.animateViewPress(sender)
        answerButton.setTitle("Следующий", for: .normal)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ text: String) {
        answerButton.setTitle("Проверить", for: .normal)
    }
    
    private func setupViews() {
        contentView.addSubview(answerButton)
    }
    
    private func setupConstraints() {
        
        answerButton.snp.makeConstraints { make in
            make.left.top.right.equalTo(contentView).inset(20)
            make.height.equalTo(contentView.snp.height).inset(20)
        }
        
    }

}
