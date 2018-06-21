//
//  ChordObject.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-09.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ChordObject: Object, Mappable {

    var id = RealmOptional<Int>()
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var link: String = ""
    var chords = List<Chord>()
    var authors = List<Authors>()
    @objc dynamic var date = Date()
    @objc dynamic var scheduledForDeletion: Bool = false

    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
        if map.JSON["id"] == nil { return nil }
        if map.JSON["body"] == nil { return nil }
        if map.JSON["body_chords_html"] == nil { return nil }
        if map.JSON["body_stripped"] == nil { return nil }
        if map.JSON["title"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        authors <- map["authors"]
        body <- map["body"]
        chords <- map["chords"]
        link <- map["permalink"]
        title <- map["title"]
        id.value <- map["id"]
    }
    
}

class Authors: Object, Mappable {
    
    @objc dynamic var name: String = ""
    var types = List<String>()

    required convenience init?(map: Map) {
        self.init()
        if map.JSON["name"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        types  <- map["types"]
    }
}

class Chord: Object, Mappable {
    
    @objc dynamic var code: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var instrument: Instrument?

    required convenience init?(map: Map) {
        self.init()
        if map.JSON["code"] == nil { return nil }
        if map.JSON["name"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        image <- map["image_url"]
        instrument <- map["instrument"]
        name <- map["name"]
    }
    
}

class Instrument: Object, Mappable {
   
    @objc dynamic var name: String = ""
    @objc dynamic var tuning: String = ""
    
    required convenience init?(map: Map) {
        self.init()
        if map.JSON["name"] == nil { return nil }
        if map.JSON["tuning"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        tuning <- map["tuning"]
    }
    
}

private func <- <T: Mappable>(left: List<T>, right: Map)
{
    var array: [T]?
    
    if right.mappingType == .toJSON
    {
        array = Array(left)
    }
    
    array <- right
    
    if right.mappingType == .fromJSON
    {
        if let theArray = array
        {
            left.append(objectsIn: theArray)
        }
    }
}
