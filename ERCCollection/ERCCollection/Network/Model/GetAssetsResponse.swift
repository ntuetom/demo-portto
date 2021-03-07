//
//  GetAssetsResponse.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import Foundation

class GetAssetsResponse: Decodable {
    let assets: [ERCAssset]
}

class ERCAssset: Decodable {
    let name: String?
    let image_url: String?
}
