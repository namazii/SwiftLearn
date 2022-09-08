//
//  ResultVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 30.08.2022.
//

import UIKit
import SnapKit
import Lottie

final class ResultVC: UIViewController {
    
    //MARK: - Properties
    var questionProvider = QuestionProvider.shared
    
    private let animation = Animation.named("celebrate")
    
    private lazy var animationView: AnimationView = {
        let view = AnimationView(animation: animation)
        view.loopMode = LottieLoopMode.loop
        return view
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Результат\n 23/50\n 48%"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Меню", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(getBackAction), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
        setupViews()
        setConstraints()
    }
    
    //MARK: - Private
    private func setupText() {
        let questionsTrue = questionProvider.questionTrue.count
        let questionsFalse = questionProvider.questionFalse.count
        let summ = questionsTrue + questionsFalse
        let procent = Double(questionsTrue) / Double(summ) * 100
        resultLabel.text = "Ваш результат:\n \(questionsTrue)/\(summ)\n \(Int(procent))% "
    }
    
    private func setupViews() {
        animationView.play()
        
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
        view.addSubview(resultLabel)
        view.addSubview(animationView)
        view.addSubview(menuButton)
    }
    //MARK: - Action
    @objc private func getBackAction(_ sender: UIButton) {
        view.animateViewPress(sender)
        
        questionProvider.questionFalse = []
        questionProvider.questionTrue = []
        
        navigation()
    }
    
    //MARK: - Navigation
    private func navigation() {
        navigationController?.popToRootViewController(animated: true)
    }
    //MARK: - Constraints
    private func setConstraints() {
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalTo(animationView.snp.top).offset(-20)
        }
        
        menuButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
        }
        
        animationView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.left.right.equalTo(view).inset(40)
        }
    }
}
