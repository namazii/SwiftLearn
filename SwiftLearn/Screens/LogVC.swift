//
//  LogVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.09.2022.
//

import UIKit
import SnapKit
import FirebaseAuth

final class LogVC: UIViewController {
    
    //MARK: - Properties
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
        textField.layer.borderColor = Resources.Colors.border.cgColor
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
        textField.layer.borderColor = Resources.Colors.border.cgColor
        textField.layer.cornerRadius = 3
        
        return textField
    }()
    
    private lazy var logButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Вход", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var regButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Регистрация", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(regButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackViewMain: UIStackView = {
       let stackView = UIStackView()
        
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        return stackView
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
        addTap()
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.showMenuVC()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: - Private
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        logButton.titleLabel?.font = UIFont(name: "Futura", size: view.frame.height / 40)
        regButton.titleLabel?.font = UIFont(name: "Futura", size: view.frame.height / 40)
        
        view.addSubview(logoLabel)
        view.addSubview(stackViewMain)
        view.addSubview(logButton)
        view.addSubview(regButton)
        
        stackViewMain.addArrangedSubview(emailTextField)
        stackViewMain.addArrangedSubview(passwordTextField)
    }
    
    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    @objc private func logButtonAction(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            showAlert(title: "Данные не корректны", message: "Пожалуйста, введите email и пароль")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error != nil {
                self?.showAlert(title: "Ошибка входа", message: "Проверьте корректность введенных данных")
            }
            if user != nil {
                return
            }
        }
    }
    
    @objc private func regButtonAction(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            showAlert(title: "Данные не корректны", message: "Пожалуйста, введите email и пароль")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            if error != nil {
                self?.showAlert(title: "Ошибка регистрации", message: "Длина пароля должна быть от 6 символов\n Проверьте корректность email\n Возможно данный пользователь уже существует")
            }
        }
    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    private func showMenuVC() {
        let vc = MenuVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Constraints
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
        
        logButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(stackViewMain.snp.bottom).offset(20)
            make.width.equalTo(stackViewMain.snp.width)
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(0.5)
        }
        
        regButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(logButton.snp.bottom).offset(20)
            make.width.equalTo(stackViewMain.snp.width)
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(0.5)
        }
    }
}
