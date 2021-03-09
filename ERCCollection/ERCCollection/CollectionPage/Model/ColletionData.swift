//
//  ColletionData.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/8.
//

import RxDataSources

struct CollectionData: IdentifiableType, Equatable {
    
    let id: Int
    let name: String
    let img_url: URL?
    let image_preview_url: URL?
    let description: String
    let collectionName: String
    let webURL: URL?
    
    typealias Identity = Int
    
    var identity: Identity {
        return id
    }
    
    static func ==(lhs: CollectionData, rhs: CollectionData) -> Bool {
        return lhs.id == rhs.id
    }
}

struct CustomSectionDataType {
    var uniqueId: String
    var items: [Item]
}

extension CustomSectionDataType: AnimatableSectionModelType {
    typealias Item = CollectionData
    init(original: CustomSectionDataType, items: [Item]) {
        self = original
        self.items = items
    }
    typealias Identity = String
    var identity: String {
        return uniqueId 
    }
}
