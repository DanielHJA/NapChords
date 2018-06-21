//
//  RealmManager.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-17.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager {
    
    private static let scheduled: String = "scheduledForDeletion"

    private static let realm: Realm = {
        return try! Realm()
    }()
    
    class func returnAll() -> Results<ChordObject> {
        return realm.objects(ChordObject.self).filter("\(scheduled) = \(false)")
    }
    
    class func exists(_ id: Int) -> Bool {
        let object = realm.objects(ChordObject.self).filter("id = \(id)")
        return object.count > 0
    }
    
    class func add(_ object: ChordObject) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    class func scheduleForDeletion(_ object: ChordObject, shouldDelete: Bool) {
        try! realm.write({
            object.scheduledForDeletion = shouldDelete
        })
    }
    
    class func deleteScheduled(){
        let objectsToBeDeleted = realm.objects(ChordObject.self).filter("\(scheduled) = \(true)")
        remove(objectsToBeDeleted)
    }
    
    class func remove(_ objects: Results<ChordObject>) {
        try! realm.write({
            for object in objects {
                realm.delete(object.authors)
                
                for chord in object.chords {
                    if let instrument = chord.instrument {
                        realm.delete(instrument)
                    }
                }
                
                realm.delete(object.chords)
                realm.delete(object)
                
            }
        })
    }
    
}
