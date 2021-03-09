//
//  DetailViewModel.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/9.
//

import RxSwift

class DetailViewModel: NSObject {
    
    let collectionData: CollectionData
    var cellSource = PublishSubject<[TableViewCellData]>()
    
    init(data: CollectionData) {
        collectionData = data
        super.init()
    }
    
    func emitData() {
        cellSource.onNext([TableViewCellData(name: collectionData.name ?? "沒資料", desc: collectionData.description, imageURL: collectionData.img_url)])
    }
}
