//
//  TextCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 11.08.2022.
//

import UIKit

final class TextCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "TextCell"
    
    private let questionTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        questionTextLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ text: String) {
        questionTextLabel.text = text
//        contentView.layoutIfNeeded()
    }
    
    private func setupViews() {
        contentView.addSubview(questionTextLabel)
    }
    
    private func setupConstraints() {
        questionTextLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView).inset(20)
        }
    }
}
