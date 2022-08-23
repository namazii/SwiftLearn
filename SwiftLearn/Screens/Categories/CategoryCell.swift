//
//  CategoryCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 22.08.2022.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
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
       
    func configure(_ name: String, _ image: String) {
        nameLabel.text = name
        categoryImage.image = UIImage(named: image)
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
