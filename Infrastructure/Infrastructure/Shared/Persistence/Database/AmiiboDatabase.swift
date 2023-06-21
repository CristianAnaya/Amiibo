//
//  AmiiboDatabase.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import CoreData

public class AmiiboDatabase {
    
    private let modelName: String
    private let isTestMode: Bool
    private let frameworkBundleID = "com.ceiba.Infrastructure"
    
    public init(modelName: String, isTestMode: Bool = false) {
        self.modelName = modelName
        self.isTestMode = isTestMode
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let frameworkBundle = Bundle(identifier: self.frameworkBundleID)
        let modelURL = frameworkBundle!.url(forResource: self.modelName, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        
        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: managedObjectModel!)
        if isTestMode {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy =  NSMergePolicy.mergeByPropertyObjectTrump
        }
        return container
    }()
    
    public lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    
    // MARK: - Core Data Stack
    func saveContext() throws {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                throw error
            }
        }
    }
    
}
