//
//  CollectionViewModel.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import RxSwift
import RxDataSources

class CollectionViewModel: NSObject, Assetable {
    
    let disposeBag = DisposeBag()
    let cellSize: CGSize
    var offset = 0
    var limit = 20
    var cellSource = PublishSubject<[CustomSectionDataType]>()
    var collectionDatas: [CollectionData] = []
    
    override init() {
        let w = (kScreenW-3*kOffset)/2
        cellSize = CGSize(width: w, height: w)
        super.init()
    }
    
    func fetchAsset() {
        let request = GetAssetsRequest(offset: offset, limit: limit)
        getAssets(req: request)
            .subscribe(onSuccess: { [unowned self] response in
                switch response {
                case .success(let data):
                    let temp = data.assets.enumerated().map { (index, asset) -> CollectionData in
                        return CollectionData(id: offset + index, name: asset.name, img_url: URL(string: asset.image_url ?? ""))
                    }
                    self.collectionDatas.append(contentsOf: temp)
                    self.cellSource.onNext([CustomSectionDataType(uniqueId: "", items: collectionDatas)])
                    self.offset += self.limit
                case .failure(let error):
                    print(error.message)
                }
            }, onError: { error in
                print("Error: ", error)
            })
            .disposed(by: disposeBag)
    }
}
