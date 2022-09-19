//
//  StorageManager.swift
//  Quizi
//
//  Created by Назар Ткаченко on 09.09.2022.
//

import CoreData

// MARK: - Core Data stack
final class StorageManager {
    
    //MARK: - Properties
    static let shared = StorageManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Quizi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveData(_ result: String, category: String, date: String ) {
        let pullResult = PollResult(context: persistentContainer.viewContext)
        pullResult.result = result
        pullResult.category = category
        pullResult.date = date
        
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData() -> [PollResult] {
        let fetchRequest = PollResult.fetchRequest()
        var questionResults: [PollResult]?
        do {
            questionResults = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return questionResults ?? []
    }
}


