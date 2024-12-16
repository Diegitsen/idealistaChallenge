//
//  PersistenceManager.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import Foundation
import CoreData

public protocol UniquedObject {
    var id: String { get set }
}

class PersistenceManager {
    private init() {}
    static let shared = PersistenceManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "idealistaChallenge")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var mainContext = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    
    @MainActor
    func save() {
        if mainContext.hasChanges {
            do {
                try mainContext.performAndWait { try mainContext.save() }
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func synchronousSave() {
        if mainContext.hasChanges {
            do {
                try mainContext.performAndWait { try mainContext.save() }
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func rollback() {
        if mainContext.hasChanges {
            mainContext.rollback()
        }
    }
    
    @MainActor
    func delete<T: NSManagedObject>(_ obj: T) {
        mainContext.delete(obj)
    }
    
    func synchronousDelete<T: NSManagedObject>(_ obj: T) {
        mainContext.delete(obj)
    }
    
    @MainActor
    func deleteUnchangedObjects<T: NSManagedObject>(_ objectType: T.Type) {
        fetch(objectType).filter({ !$0.hasChanges }).forEach({ delete($0) })
    }
    
    // MARK: - Core Data Fetch methods
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            let fetchedObjects = try mainContext.performAndWait {
                try mainContext.fetch(fetchRequest) as? [T]
            }
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return[T]()
        }
    }
    
    @MainActor
    func fetchAsync<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let fetchedObjects = try mainContext.performAndWait {
                try mainContext.fetch(fetchRequest) as? [T]
            }
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return[T]()
        }
    }
    
    func fetchSingle<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil) -> T? {
        return fetch(entity, predicate: predicate).first
    }
    
    func fetchSingle<T: NSManagedObject>(_ objectType: T.Type, id: String) -> T? {
        let predicate = NSPredicate(format: "id == %@", String(id))
        return fetch(objectType, predicate: predicate).first
    }
    
    func fetchSingleOrCreate<T: NSManagedObject>(_ objectType: T.Type, id: String) -> T where T: UniquedObject {
        guard let obj = fetchSingle(objectType, id: id) else {
            let obj = create(objectType, id: id)
            return obj
        }
        return obj
    }
    
    func create<T: NSManagedObject>(_ objectType: T.Type, id: String) -> T where T: UniquedObject {
        var obj = T(context: mainContext)
        obj.id = id
        return obj
    }
    
}

extension NSManagedObjectContext {
    
    func performAndWait<T>(_ block: () throws -> T) rethrows -> T {
        return try _performAndWaitHelper(
            fn: performAndWait, execute: block, rescue: { throw $0 }
        )
    }
    
    private func _performAndWaitHelper<T>(fn: (() -> Void) -> Void, execute work: () throws -> T, rescue: ((Error) throws -> (T))) rethrows -> T {
        var result: T?
        var error: Error?
        withoutActuallyEscaping(work) { _work in
            fn {
                do {
                    result = try _work()
                } catch let e {
                    error = e
                }
            }
        }
        if let e = error {
            return try rescue(e)
        } else {
            return result!
        }
    }

}

extension NSManagedObject {
    
    var persistenceManager: PersistenceManager {
        return PersistenceManager.shared
    }
    
}
