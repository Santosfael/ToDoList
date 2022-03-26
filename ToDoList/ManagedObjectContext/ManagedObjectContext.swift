//
//  ManagedObjectText.swift
//  ToDoList
//
//  Created by SP11793 on 26/03/22.
//

import Foundation
import UIKit
import CoreData


// MARK: - Typealias

typealias onCompletionHandler = (String) -> Void


// MARK: - Protocols

protocol managedSaveProtocol {
    func saveTask(task: Task, onCompletionHandler: onCompletionHandler)
}

protocol managedGetProtocol {
    func getTask() -> [Task]
}

protocol managedDeleteProtocol {
    func delteTask(id: String, onCompletionHandler: onCompletionHandler)
}

protocol managedUpdateProtocol {
    func updateTask(task: Task, onCompletionHandler: onCompletionHandler)
}


// MARK: - Class

class ManagedObjectContext: managedSaveProtocol, managedGetProtocol, managedDeleteProtocol, managedUpdateProtocol {
    
    // MARK: - Private Variables
    
    private let entity = "ToDoList"
    
    
    // MARK: - Public Variables
    
    static var shared: ManagedObjectContext = {
        let instance = ManagedObjectContext()
        return instance
    }()
    
    
    // MARK: - Public Methods
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveTask(task: Task, onCompletionHandler: (String) -> Void) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: entity, in: context) else { return }
        
        let transaction = NSManagedObject(entity: entity, insertInto: context)
        
        transaction.setValue(task.id, forKey: "id")
        transaction.setValue(task.name, forKey: "name")
        transaction.setValue(task.details, forKey: "details")
        transaction.setValue(task.done, forKey: "done")
        
        do {
            try context.save()
            
            onCompletionHandler("Save Success")
            
        } catch let error as NSError {
            print("Could not save \(error.localizedDescription)")
        }
        
    }
    
    func getTask() -> [Task] {
        var taskList: [Task] = []
        
        do {
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
            
            guard let tasks = try getContext().fetch(fetchRequest) as? [NSManagedObject] else { return taskList}
            
            for task in tasks {
                
                if  let id = task.value(forKey: "id") as? UUID,
                    let name = task.value(forKey: "name") as? String,
                    let details = task.value(forKey: "details") as? String,
                    let done =  task.value(forKey: "done") as? Bool{
                    
                    let task = Task(id: id, name: name, details: details, done: done)
                    taskList.append(task)
                }
            }
        
        } catch let error as NSError {
            print("Error in request: \(error.localizedDescription)")
        }
        
        return taskList
    }
    
    func delteTask(id: String, onCompletionHandler: (String) -> Void) {
        let context = getContext()
        
        let predicate = NSPredicate(format: "id == %@", "\(id)")
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchResults = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            if let entityDelete = fetchResults.first {
                context.delete(entityDelete)
            }
            
            try context.save()
            
            onCompletionHandler("Delete Success")
            
        } catch let error as NSError {
            print("Fetch Failed \(error.localizedDescription)")
        }
    }
    
    // Future implementations
    /*
    func deleteAllTasks() {
        let context = getContext()
        
        do {
            // Get a reference to a NSPersistentStoreCoordinator
            let storeContainer = context.persistentStoreCoordinator

            // Delete each existing persistent store
            for store in storeContainer!.persistentStores {
                try storeContainer!.destroyPersistentStore(
                    at: store.url!,
                    ofType: store.type,
                    options: nil
                )
            }

            // Re-create the persistent container
            let newContext = getContext()

            // Calling loadPersistentStores will re-create the
            // persistent stores
            newContext.loadPersistentStores {
                (store, error) in
                // Handle errors
            }
        } catch let error as NSError {
            print("Fetch Failed \(error.localizedDescription)")
        }
        
    }*/
    
    func updateTask(task: Task, onCompletionHandler: (String) -> Void) {
        let context = getContext()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(task.id)")

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {

                results![0].setValue(task.name, forKey: "name")
                results![0].setValue(task.details, forKey: "details")
                results![0].setValue(task.done, forKey: "done")
                
                try context.save()
                
                onCompletionHandler("Update Success")
                
            } else {
                onCompletionHandler("Update Failed Id Not Found")
            }
            
            
            
        } catch let error as NSError {
            print("Update Failed \(error.localizedDescription)")
        }
        
        
    }
    
    
}

// MARK: - Methods implementation example

// SAVE

//        let taskTest = Task(id: UUID(), name: "Arrumar o Quarto", details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting", done: false)
//
//        ManagedObjectContext.shared.saveTask(task: taskTest) { res in
//            print(res)
//        }

// GET

//        var taskList: [Task] = []
//
//        taskList = ManagedObjectContext.shared.getTask()
//
//        print(taskList)


// DELETE

//        ManagedObjectContext.shared.delteTask(id: "B2C169A6-D22B-4A40-87B2-832FD37A70CD") { res in
//            print(res)
//        }


// UPDATE

//        var taskList: Task
//
//        taskList = Task(id: UUID(uuidString: "1B2756AC-FAA8-4622-9249-087954FCE26A")!,
//                        name: "Arrumar Quarto", details: "Alterei novamente", done: false)
//
//        ManagedObjectContext.shared.updateTask(task: taskList) { res in
//            print(res)
//        }
