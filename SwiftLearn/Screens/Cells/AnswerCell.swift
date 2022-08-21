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
    
    private var answerResult = false
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
    
    func configure(_ text: String, _ type: String) {
        answerLabel.text = text
        let
//        answerResult = result
//        checkMark.image = UIImage(named: "checkOff")
    }
    
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
