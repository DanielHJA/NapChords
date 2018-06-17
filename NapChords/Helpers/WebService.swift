//
//  WebService.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-09.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

typealias Failure = (CustomError) -> ()
typealias YoutubeSuccess = (MusicObject) -> ()
typealias ChordSuccess = ([ChordObject]) -> ()

class WebService {

    class func fetchYoutube(query: String, completion: @escaping YoutubeSuccess, failure: @escaping Failure) {
        let url: String = "\(Constants.YoutubeAPI.root)q=\(query.URLEncode())%20-vevo%20-SME%20-Sony&part=snippet&type=video&maxResults=1&key=\(Constants.YoutubeAPI.key)"
    
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data, let json = data.toString() else { return }
            
            guard let result = Mapper<MusicObject>().map(JSONString: json) else {
                failure(.serializingError)
                return
            }
        
            completion(result)
        }
    }
    
    class func fetchChords(query: String, completion: @escaping ChordSuccess, failure: @escaping Failure) {
        let headers: [String: String] = [Constants.ChordsAPI.header : Constants.ChordsAPI.APIkey]
        let url: String = "\(Constants.ChordsAPI.base)\(query.URLEncode())"
    
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            guard response.response?.statusCode != nil else {
                failure(.noConnection)
                return
            }
            guard let data = response.data else { return }
            
            guard let extractedJSON = data.extractJSON(key: "objects") else { return }
            
            guard let result = Mapper<ChordObject>().mapArray(JSONString: extractedJSON) else { 
                failure(.serializingError)
                return
            }
            
            completion(result)
        }
    }
}
