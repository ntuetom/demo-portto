//
//  CollectionViewModel.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import RxSwift

class CollectionViewModel: NSObject, Assetable {
    
    let disposeBag = DisposeBag()
    let collectionDatas = PublishSubject<[CollectionData]>()
    let cellSize: CGSize
    
    override init() {
        let w = (kScreenW-3*kOffset)/2
        cellSize = CGSize(width: w, height: w)
        super.init()
    }
    func fetchAsset() {
        getAssets()
            .subscribe(onSuccess: { [weak self] response in
                
                switch response {
                case .success(let data):
                    let _a = data.assets.map { asset -> CollectionData in
                        return CollectionData(name: asset.name, url: asset.image_url ?? "")
                    }
                    self?.collectionDatas.onNext(_a)
                case .failure(let error):
                    print(error.message)
                }
            }, onError: { error in
                print("Error: ", error)
            })
            .disposed(by: disposeBag)
    }
}
