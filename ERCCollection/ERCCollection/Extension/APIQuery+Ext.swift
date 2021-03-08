//
//  Dictionary+APIQuery.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import Foundation

extension Dictionary {
    var queryString: String {
        let result = self.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        return "?\(result)"
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
