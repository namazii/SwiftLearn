//
//  MenuVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 21.08.2022.
//

import UIKit
import SnapKit

class MenuVC: UIViewController {
    
    //MARK: - Properties
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "SwiftLearn"
        
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Играть", for: .normal)
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        
        return button
    }()
    
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Категория", for: .normal)
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        
        return button
    }()

    lazy var historyButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("История", for: .normal)
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        
        return button
    }()
    
    lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    
    //MARK: - PrivateMethods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackViewMain)
        
        stackViewMain.addArrangedSubview(logoLabel)
        stackViewMain.addArrangedSubview(playButton)
        stackViewMain.addArrangedSubview(categoryButton)
        stackViewMain.addArrangedSubview(historyButton)
    }


    
    private func setupConstraints() {
        playButton.snp.makeConstraints { make in
            make.width.equalTo(stackViewMain)
            make.height.lessThanOrEqualTo(50)
        }
        logoLabel.snp.makeConstraints { make in
            make.width.equalTo(stackViewMain)
            make.height.lessThanOrEqualTo(50)
        }
        categoryButton.snp.makeConstraints { make in
            make.width.equalTo(stackViewMain)
            make.height.lessThanOrEqualTo(50)
        }
        historyButton.snp.makeConstraints { make in
            make.width.equalTo(stackViewMain)
            make.height.lessThanOrEqualTo(50)
        }
        
        stackViewMain.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
//            make.left.right.equalTo(view).inset(40)
//            make.top.bottom.equalTo(view).inset(300)
            make.width.height.greaterThanOrEqualTo(300)

        }
    }
    
    // MARK: - Navigation
    @objc private func buttonPress(_ sender: UIButton) {
        sender.animateViewPress(sender)
        switch sender {
        case playButton:
            print("play")
            let vc = QuestionVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case categoryButton:
            print("categori")
            let vc = CategoriesVC()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("history")
        }
    }
}
