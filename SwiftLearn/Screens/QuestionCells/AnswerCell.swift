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
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var checkLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        answerLabel.text = nil
        checkLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareForReuse()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ text: String) {
        answerLabel.text = text
        checkLabel.text = "❐"
    }
    
    private func setupViews() {
        contentView.addSubview(answerLabel)
        contentView.addSubview(checkLabel)
    }
    
    private func setupConstraints() {
        
        answerLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(contentView).inset(20)
            make.right.lessThanOrEqualTo(checkLabel.snp.left)
            
        }
        
        checkLabel.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(contentView).inset(20)
        }
    }

}
