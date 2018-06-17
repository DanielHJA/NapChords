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
    
    class func add(_ object: ChordObject) {
       try! realm.write {
            realm.add(object.toRealmObject())
        }
    }
    
    class func remove(_ id: Int) {
        try! realm.write {
            guard let obj = realm.object(ofType: RealmChordObject.self, forPrimaryKey: id) else { return }
            realm.delete(obj)
        }
    }
    
    class func returnAll() -> Results<RealmChordObject> {
        return realm.objects(RealmChordObject.self)
    }
    
    class func exists(_ id: Int) -> Bool {
        return realm.object(ofType: RealmChordObject.self, forPrimaryKey: id) != nil
    }
}
