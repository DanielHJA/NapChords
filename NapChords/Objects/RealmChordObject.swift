//
//  RealmChordObject.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-17.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class RealmChordObject: Object {

    var id = RealmOptional<Int>()
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var link: String = ""
    let chords = List<RealmChords>()
    let authors = List<RealmAuthors>()
    @objc dynamic var date = Date()
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init(object: ChordObject) {
        self.init()

        id.value = object.id
        title = object.title
        body = object.body
        
        if let link = object.link?.absoluteString {
            self.link = link
        }
        
        for chord in object.chords {
            let chordObject = RealmChords(object: chord)
            chords.append(chordObject)
        }
     
        for author in object.authors {
            let authorObject = RealmAuthors(object: author)
            authors.append(authorObject)
        }
    }
    
}

class RealmAuthors: Object {
    @objc dynamic var name: String = ""
    let types = List<String>()

    convenience required init(object: Authors) {
        self.init()
        name = object.name
        types.append(objectsIn: object.types)
    }
}

class RealmChords: Object {
    @objc dynamic var code: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var instrument: RealmInstrument?

    convenience required init(object: Chord) {
        self.init()
        code = object.code
        name = object.name
        
        if let image = object.image?.absoluteString {
            self.image = image
        }
        
        if let instrument = object.instrument {
            self.instrument = RealmInstrument(object: instrument)
        }
    }
}

class RealmInstrument: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var tuning: String = ""
    
    convenience required init(object: Instrument) {
        self.init()
        name = object.name
        tuning = object.tuning
    }
}
