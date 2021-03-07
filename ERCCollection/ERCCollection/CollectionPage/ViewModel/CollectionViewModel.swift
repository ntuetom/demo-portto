//
//  CollectionViewModel.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import RxSwift

class CollectionViewModel: NSObject, Assetable {
    
    let disposeBag = DisposeBag()
    
    func fetchAsset() {
        getAssets().subscribe(onNext: { response in
            switch response {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }).disposed(by: disposeBag)
    }
}
