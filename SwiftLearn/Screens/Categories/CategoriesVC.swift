//
//  CategoriesVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 21.08.2022.
//

import UIKit

struct Topic: Hashable {
    
    var text = ""
    var image = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(image)
    }
}

final class CategoriesVC: UIViewController {
    
    var questionsAPI = QuestionsAPI()
    
    var questions: [Question] = []
    var topicsSet: Set<Topic> = []
    
    lazy var topics: [Topic] = []
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        fetchQuestions()
        fetchTopics()
    }
    
    //MARK: - Private
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    //MARK: - Requests
    private func fetchQuestions() {
        questions = questionsAPI.fetchQuestions(name: "questions")
    }
    
    private func fetchTopics() {
        for question in questions {

            let array = question.topic
            let dictionary = zip(array, question.image)
            if array.count > 1 {
                for (item, itemImage) in dictionary {
                    let topic = Topic(text: item, image: itemImage)
                    topicsSet.insert(topic)
                    continue
                }
            }
            let topic = Topic(text: question.topic.first ?? "", image: question.image.first ?? "")
            topicsSet.insert(topic)
        }

        topics = Array(topicsSet)
        collectionView.reloadData()
    }
    
    //MARK: - Actions
    
    private func chooseCategorieAction(_ indexPath: IndexPath) {
        let topic = topics[indexPath.row]
        showQuestionScreen(topic)
    }
    
    //MARK: - Navigation
    private func showQuestionScreen(_ topic: Topic) {
        let questionsVC = QuestionVC()
        questionsVC.topic = topic
        navigationController?.pushViewController(questionsVC, animated: true)
    }
}

//MARK: - UICollectionViewExtension
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return topics.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }

        let topic = topics[indexPath.row]
        cell.configure(topic)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       chooseCategorieAction(indexPath)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
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
