//
//  Assetable.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import RxSwift

protocol Assetable: NSObjectProtocol {
    func getAssets(req: GetAssetsRequest) -> Single<Result<GetAssetsResponse,ParseResponseError>>
}

extension Assetable {
    func getAssets(req: GetAssetsRequest) -> Single<Result<GetAssetsResponse,ParseResponseError>> {
        return rxRequest.request(target: .fetchAssets(req: req))
    }
}
