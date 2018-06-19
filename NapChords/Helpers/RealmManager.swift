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

    private static let realm: Realm = {
        return try! Realm()
    }()
    
    class func returnAll() -> Results<RealmChordObject> {
        return realm.objects(RealmChordObject.self)
    }
    
    class func exists(_ id: Int) -> Bool {
        let object = realm.objects(RealmChordObject.self).filter("id = \(id)")
        return object.count > 0
    }
    
    class func add(_ object: ChordObject) {
        try! realm.write({
            realm.add(object.toRealm())
        })
    }
    
    class func remove(_ id: Int) {
        try! realm.write({
            if let object = realm.objects(RealmChordObject.self).filter("id = \(id)").first {
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
