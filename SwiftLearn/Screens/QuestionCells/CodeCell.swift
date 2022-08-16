//
//  CodeCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 11.08.2022.
//

import UIKit
import SnapKit

class CodeCell: UITableViewCell {

    static let identifier = "CodeCell"
    
    lazy var codeLabel: UILabel = {
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
        prepareForReuse()
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
            make.left.right.top.equalTo(contentView).inset(20)
        }
    }

}
