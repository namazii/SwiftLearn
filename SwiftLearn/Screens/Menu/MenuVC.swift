//
//  MenuVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 21.08.2022.
//

import UIKit
import SnapKit
import FirebaseAuth

final class MenuVC: UIViewController {
    
    //MARK: - Properties
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "SwiftLearn"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.textColor = .systemYellow
        
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Играть", for: .normal)
        button.addTarget(self, action: #selector(buttonPressAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var historyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("История", for: .normal)
        button.addTarget(self, action: #selector(buttonPressAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Выход", for: .normal)
        button.addTarget(self, action: #selector(buttonPressAction), for: .touchUpInside)
        
        return button
    }()
    
    private let stackViewMain: UIStackView = {
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
        
        let deleteUserButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteUserAction))
        
        navigationItem.rightBarButtonItem = deleteUserButton
    }
    
    //MARK: - Private
    @objc private func deleteUserAction(_ sender: UIBarButtonItem) {
        deleteAlert()
    }
    
    private func deleteAlert() {
        let alert = UIAlertController(title: "Удаление аккаунта", message: "Вы хотите удалить свой аккаунт?", preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "ОК", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            let user = Auth.auth().currentUser
            user?.delete { error in
              if let _ = error {
                  self.showAlert(title: "Внимание", message: "Для безопасности войдите в акаунт повторно")
              } else {
                  self.showLogVC()
              }
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    private func setupViews() {
        navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        view.addSubview(stackViewMain)
        
        stackViewMain.addArrangedSubview(logoLabel)
        stackViewMain.addArrangedSubview(playButton)
        stackViewMain.addArrangedSubview(historyButton)
        stackViewMain.addArrangedSubview(exitButton)
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
        historyButton.snp.makeConstraints { make in
            make.width.equalTo(stackViewMain)
            make.height.lessThanOrEqualTo(50)
        }
        exitButton.snp.makeConstraints { make in
            make.width.equalTo(stackViewMain)
            make.height.lessThanOrEqualTo(50)
        }
        
        stackViewMain.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.height.greaterThanOrEqualTo(300)
            
        }
    }
    
    
    // MARK: - Navigation
    
    private func showCategoriesScreen() {
        let vc = CategoriesVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showHistoryVC() {
        let vc = HistoryVC()
        present(vc, animated: true)
    }
    private func showLogVC() {
        navigationController?.dismiss(animated: true)
    }
    
    // MARK: - Actions
    @objc private func buttonPressAction(_ sender: UIButton) {
        
        view.animateViewPress(sender)
        
        switch sender {
        case playButton:
            showCategoriesScreen()
        case historyButton:
            showHistoryVC()
        case exitButton:
            do {
                try Auth.auth().signOut()
                showLogVC()
            } catch {
                print(error.localizedDescription)
            }
        default: break
        }
    }
}
