//
//  CategoryCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 22.08.2022.
//

import UIKit
import SnapKit

//filepr enum Russify: String {
//    case swift = "Swift"
//    case theory = "Теория"
//    case optional = "Опционалы"
//}

class CategoryCell: UICollectionViewCell {
    
    static let reuseID = "CategoryCell"
    
    lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
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
        default:
            return
        }
//        nameLabel.text = model.text
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
        
        //questionTextLabel.pinEdgesToSuperView()
    }
}
