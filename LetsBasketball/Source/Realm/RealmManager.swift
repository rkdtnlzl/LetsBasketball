//
//  RealmManager.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/31/24.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    private var realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    func add<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetch<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil, sortedBy keyPath: String? = nil, ascending: Bool = true) -> Results<T> {
        var results = realm.objects(type)
        
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        
        if let keyPath = keyPath {
            results = results.sorted(byKeyPath: keyPath, ascending: ascending)
        }
        
        return results
    }
    
    // MARK: - Update
    
    func update<T: Object>(_ object: T, with updates: (() -> Void)) {
        do {
            try realm.write {
                updates()
            }
        } catch let error {
            print("Failed to update object: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Delete
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error {
            print("Failed to delete object: \(error.localizedDescription)")
        }
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
        do {
            try realm.write {
                let objects = realm.objects(type)
                realm.delete(objects)
            }
        } catch let error {
            print("Failed to delete all objects: \(error.localizedDescription)")
        }
    }
}

