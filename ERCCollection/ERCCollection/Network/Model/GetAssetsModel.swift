//
//  GetAssetsResponse.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import Foundation

struct GetAssetsRequest: Encodable {
    let offset: Int
    let limit: Int
    
    init(offset: Int, limit: Int = 20) {
        self.offset = offset
        self.limit = limit
    }
}

class GetAssetsResponse: Decodable {
    let assets: [ERCAssset]
}

class ERCAssset: Decodable {
    let name: String?
    let image_url: String?
    let id: Int
}
