//
//  LogVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.09.2022.
//

import UIKit
import SnapKit

final class LogVC: UIViewController {
    
    private lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "SwiftLearn"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.textColor = .systemYellow
        
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
       let textField = UITextField()
        
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.layer.cornerRadius = 3
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        
        textField.placeholder = "Password"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.layer.cornerRadius = 3
        
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Регистрация/Вход", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private lazy var stackViewMain: UIStackView = {
       let stackView = UIStackView()
        
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        signUpButton.titleLabel?.font = UIFont(name: "Futura", size: view.frame.height / 40)
        
        view.addSubview(logoLabel)
        view.addSubview(stackViewMain)
        view.addSubview(signUpButton)
        
        stackViewMain.addArrangedSubview(emailTextField)
        stackViewMain.addArrangedSubview(passwordTextField)
    }
    
    private func setConstraints() {
        logoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackViewMain.snp.top).offset(-20)
            make.centerX.equalTo(view)
//            make.height.equalTo(view.snp.height).multipliedBy(0.5)
//            make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
        stackViewMain.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(view)
            make.height.equalTo(view.snp.height).multipliedBy(0.1)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(stackViewMain.snp.bottom).offset(20)
            make.width.equalTo(stackViewMain.snp.width)
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(0.5)
        }
    }
}
