//
//  Extensions.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-09.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

extension String {
    func URLEncode() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}

extension Data {
    func toString() -> String? {
        guard let string = String(data: self, encoding: .utf8) else { return nil }
        return string
    }
    
    func extractJSON(key: String) -> String? {
        do {
            guard let jsonDict = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] else { return nil }
            guard let unwrappedDict = jsonDict[key] else { return nil }
            guard let data = try? JSONSerialization.data(withJSONObject: unwrappedDict, options: []) else { return nil }
            
            return String(data: data, encoding: .utf8)
            
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
