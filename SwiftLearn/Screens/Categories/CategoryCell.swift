//
//  CategoryCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 22.08.2022.
//

import UIKit
import SnapKit

final class CategoryCell: UICollectionViewCell {
    
    //MARK: - Private Properties
    static let reuseID = "CategoryCell"
    
    private let categoryImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public
    override var isSelected: Bool {
        didSet {
            animateViewPress(self)
        }
    }
    
    func configure(_ model: Topic) {
        switch model.text {
        case "swift": nameLabel.text = "Swift"
        case "optional": nameLabel.text = "Опционалы"
        case "theory": nameLabel.text = "Теория"
        case "uikit": nameLabel.text = "UIKit"
        case "patterns": nameLabel.text = "Паттерны"
        case "error": nameLabel.text = "Обработка ошибок"
        default:
            return
        }
        categoryImage.image = UIImage(named: model.image)
    }
    
    //MARK: - PrivateMethods
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryImage)
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(0)
            make.bottom.equalTo(categoryImage.snp.top).inset(-5)
        }
        
        categoryImage.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView).inset(20)
        }
    }
}
