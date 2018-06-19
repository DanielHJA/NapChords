//
//  ChordObject.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-09.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import ObjectMapper

class ChordObject: Mappable {

    var authors: [Authors] = []
    var body: String!
    var bodyHTML: String!
    var bodyStripped: String!
    var chords: [Chord] = []
    var id: Int!
    var link: URL?
    var title: String!
    
    required init?(map: Map) {
        if map.JSON["id"] == nil { return nil }
        if map.JSON["body"] == nil { return nil }
        if map.JSON["body_chords_html"] == nil { return nil }
        if map.JSON["body_stripped"] == nil { return nil }
        if map.JSON["title"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        authors <- map["authors"]
        body <- map["body"]
        bodyStripped <- map["body_stripped"]
        chords <- map["chords"]
        link <- (map["permalink"], URLTransform())
        title <- map["title"]
        id <- map["id"]
    }
    
}

class Authors: Mappable {
    
    var name: String!
    var types: [String] = []
    
    required init?(map: Map) {
        if map.JSON["name"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        types  <- map["types"]
    }
}

class Chord: Mappable {
    
    var code: String!
    var image: URL?
    var instrument: Instrument?
    var name: String!
    
    required init?(map: Map) {
        if map.JSON["code"] == nil { return nil }
        if map.JSON["name"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        image <- (map["image_url"], URLTransform())
        instrument <- map["instrument"]
        name <- map["name"]
    }
    
}

class Instrument: Mappable {
   
    var name: String!
    var tuning: String!
    
    required init?(map: Map) {
        if map.JSON["name"] == nil { return nil }
        if map.JSON["tuning"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        tuning <- map["tuning"]
    }
    
}

extension ChordObject {
    func toRealm() -> RealmChordObject {
        let object = RealmChordObject(object: self)
        return object
    }
}
