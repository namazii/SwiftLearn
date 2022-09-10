//
//  HistoryVC.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 08.09.2022.
//

import UIKit

final class HistoryVC: UIViewController {
    
    private var questionResults: [PollResult] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 60
        
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchData()
    }
    
    private func fetchData() {
        questionResults = StorageManager.shared.fetchData()
    }
    
    //MARK: - Private
    private func setupViews() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.pinEdgesToSuperView()
    }
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell else { return UITableViewCell() }
        
        let result = questionResults.reversed()[indexPath.row]
        cell.configure(result)
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
