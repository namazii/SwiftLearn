//
//  AnswerCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 11.08.2022.
//

import UIKit
import SnapKit

class AnswerCell: UITableViewCell {

    static let identifier = "AnswerCell"
    
    
    private var answerStatus: Bool?  {
        didSet {
//            print(answerStatus)
        }
    }
    private var answerType = ""
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var checkMark: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    //MARK: - Lifecycle
//    override func prepareForReuse() {
//        answerLabel.text = nil
//        checkMark.image = nil
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //prepareForReuse()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        contentView.animateViewPress(checkMark)
//        contentView.animateViewPress(answerLabel)
        if (selected) {
            contentView.animateViewPress(self)
            checkMark.image = UIImage(named: "checkOn")
        } else {
            contentView.animateViewPress(checkMark)
            checkMark.image = UIImage(named: "checkOff")
        }
    }
    
    //MARK: - Public
    //Text - текст ответа, statuc - внутренний статус то что вопрос правильных/неправильно, bool - то что нажата кнопка проверить/следующей
    func configure(_ text: String, _ status: Bool, bool: Bool) {
        
        answerLabel.text = text
        
        answerStatus = status
        
        if bool == true {
            
            if status == true {
                backgroundColor = .systemGreen
            } else {
                backgroundColor = .systemRed
            }
            
        } else {
            backgroundColor = .systemBackground
        }
//        checkMark.image = UIImage(named: "checkOff")
    }
    
//    func paintCell() {
////        print("PAINT CELL")
////        guard let status = answerStatus else { return }
////        print(answerStatus)
////        print(status)
//        if answerStatus {
//            print("2\(status) !status")
//            self.backgroundColor = .green
//        } else {
//            self.backgroundColor = .red
//        }
//    }
    
    private func setupViews() {
        contentView.addSubview(answerLabel)
        contentView.addSubview(checkMark)
    }
    
    private func setupConstraints() {
        
        checkMark.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(contentView).inset(20)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(20)
            make.left.equalTo(checkMark.snp.right).inset(-20)
            make.right.lessThanOrEqualTo(contentView)
            
        }
        
        
    }

}
