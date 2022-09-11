//
//  CodeCell.swift
//  Quizi
//
//  Created by Назар Ткаченко on 11.08.2022.
//

import UIKit

final class CodeCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "CodeCell"
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        codeLabel.text = nil
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
        codeLabel.text = text
    }
    
    private func setupViews() {
        contentView.addSubview(codeLabel)
    }
    
    private func setupConstraints() {
        codeLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView).inset(20)
        }
    }
}
