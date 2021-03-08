//
//  ColletionData.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/8.
//

import Foundation

class CollectionData {
    let name: String?
    let img_url: URL?
    
    init(name: String?, url: String) {
        self.name = name
        self.img_url = URL(string: url)
    }
}
