//
//  CategoryCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 22.08.2022.
//

import UIKit
import SnapKit
import SkeletonView

final class CategoryCell: UICollectionViewCell {
    
    //MARK: - Private Properties
    static let reuseID = "CategoryCell"
    
    private let categoryImage: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        
        
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
    
    private let stackViewMain: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        
        return stackView
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        setSkeleton()
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
    private func setSkeleton() {
        self.isSkeletonable = true
        contentView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        categoryImage.isSkeletonable = true
    }
    
    private func setupViews() {
        contentView.addSubview(stackViewMain)
        stackViewMain.addArrangedSubview(nameLabel)
        stackViewMain.addArrangedSubview(categoryImage)
    }
    
    private func setupConstraints() {
        stackViewMain.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(contentView).multipliedBy(0.2)
        }
        
        categoryImage.snp.makeConstraints { make in
            make.width.equalTo(categoryImage.snp.height)
        }
    }
}
