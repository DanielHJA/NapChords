//
//  RealmChordObject.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-17.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import RealmSwift

class RealmChordObject: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var object: String = ""
    @objc dynamic var date: Date?
 
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
}
