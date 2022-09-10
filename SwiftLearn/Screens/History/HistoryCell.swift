//
//  HistoryCell.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 09.09.2022.
//

import UIKit
import SnapKit

final class HistoryCell: UITableViewCell {
    
    static let identifier = "HistoryCell"
    
    //MARK: - Private Properties
    private let resultView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    func configure(_ model: PollResult) {
        guard let result = Int(model.result ?? "Ошибка") else { return }
        if result < 60 {
            print(result)
            resultView.backgroundColor = .systemRed
        } else {
            resultView.backgroundColor = .systemGreen
        }
        resultLabel.text = "\(model.result ?? "Ошибка")%"
        let category = model.category
        let date = model.date
        infoLabel.text = "\(category ?? "Ошибка") \n Дата: \(date ?? "Ошибка")"
    }
    
    //MARK: - PrivateMethods
    private func setupViews() {
        contentView.addSubview(resultView)
        resultView.addSubview(resultLabel)
        contentView.addSubview(infoLabel)
        infoLabel.font = UIFont(name: "Futura", size: contentView.frame.height * 0.4)
    }
    
    private func setupConstraints() {
        resultView.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(contentView).inset(10)
            make.height.width.equalTo(80)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.center.equalTo(resultView.snp.center).inset(10)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(resultView.snp.right).offset(20)
            make.right.equalTo(contentView.snp.right).inset(20)
            make.top.bottom.equalTo(contentView).inset(10)
        }
    }
}
