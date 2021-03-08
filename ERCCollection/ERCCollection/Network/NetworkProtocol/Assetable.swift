//
//  Assetable.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import RxSwift

protocol Assetable: NSObjectProtocol {
    func getAssets() -> Single<Result<GetAssetsResponse,ParseResponseError>>
}

extension Assetable {
    func getAssets() -> Single<Result<GetAssetsResponse,ParseResponseError>> {
        return rxRequest.request(target: .fetchAssets)
    }
}
