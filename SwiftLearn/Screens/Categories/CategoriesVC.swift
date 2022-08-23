//
//  CategoriesVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 21.08.2022.
//

import UIKit

class CategoriesVC: UIViewController {
    
    private var questions: QuestionsJSON?
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
               collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
               collectionView.dataSource = self
               collectionView.delegate = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchQuestions()
        
    }
    
    //MARK: - PrivateMethods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
    }
    
    private func fetchQuestions() {
        if let questionsData = NetworkManager.shared.readLocalFile(forName: "data") {
            let questionsPars = NetworkManager.shared.pars(jsonData: questionsData)
            guard let question = questionsPars else { return }
            print("!!!!!\(question)!!")
            questions = question
        }
    }

}
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let question = questions else { return 0 }
        return question.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        guard let question = questions else { return UICollectionViewCell() }
        
        cell.backgroundColor = .lightGray
        cell.configure("swift", "swift")
        
        return cell
        
    }
}

extension CategoriesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let inset = 20 //
        let itemsInRow = 2 // |[]|[]|
        let insetsWidth = inset * (itemsInRow + 1)//ширина отступов всех
        let availableWith = collectionView.bounds.width - CGFloat(insetsWidth)
        let widthForItem = availableWith / CGFloat(itemsInRow)
        
        return CGSize(width: widthForItem, height: widthForItem) //размер ячейки
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) //отступы от секции
    }
}
