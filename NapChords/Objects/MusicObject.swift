//
//  MusicObject.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-09.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import ObjectMapper

class MusicObject: Mappable {

    var items: [Item] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}

class Item: Mappable {
    
    var videoKey: String!
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        videoKey <- map["id.videoId"]
    }
    
}
