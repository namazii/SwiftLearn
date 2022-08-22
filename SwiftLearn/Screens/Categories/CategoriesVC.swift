//
//  CategoriesVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 21.08.2022.
//

import UIKit

class CategoriesVC: UIViewController {
    
    lazy var collectionView: UICollectionView = {
       let collection = UICollectionView()
        
        collection.delegate = self
        collection.dataSource = self
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    //MARK: - PrivateMethods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
    }

}
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
