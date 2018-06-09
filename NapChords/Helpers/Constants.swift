//
//  Constants.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-09.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

struct Constants {
    
    struct ChordsAPI {
        static let base = "http://api.guitarparty.com/v2/songs/?query="
        static let header = "Guitarparty-Api-Key"
        static let APIkey = "e6abdb2699cb7cc80cafffb4fcdd0c9a54bd653f"
    }
    
    struct YoutubeAPI {
        static let key: String = "AIzaSyCFSXDyxVvUmH-MXlNBPAV1DHUjjDhaM9g"
        static let root: String = "https://www.googleapis.com/youtube/v3/search?"
        static let playRoot: String = "https://www.youtube.com/watch?v="
    }

}

enum CustomError: CustomStringConvertible {
    case serializingError, noResults
    var description: String {
        switch self {
        case .serializingError:
            return "Unable to serialize data"
        case .noResults:
            return "No results found"
        }
    }
}
