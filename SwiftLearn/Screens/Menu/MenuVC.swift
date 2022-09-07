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
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "SwiftLearn"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.textColor = .systemYellow
        
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Играть", for: .normal)
        button.addTarget(self, action: #selector(buttonPressAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var historyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("История", for: .normal)
        button.addTarget(self, action: #selector(buttonPressAction), for: .touchUpInside)
        
        return button
    }()

    lazy var exitButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Выход", for: .normal)
        button.addTarget(self, action: #selector(buttonPressAction), for: .touchUpInside)
        
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
    
    //MARK: - Private
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
//            make.left.right.equalTo(view).inset(40)
//            make.top.bottom.equalTo(view).inset(300)
            make.width.height.greaterThanOrEqualTo(300)

        }
    }
    
   
    // MARK: - Navigation
    
    private func showCategoriesScreen() {
        let vc = CategoriesVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showResultScreen() {
        let vc = ResultVC()
        self.navigationController?.pushViewController(vc, animated: true)
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
            print("История")
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
