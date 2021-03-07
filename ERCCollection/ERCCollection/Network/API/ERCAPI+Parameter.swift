//
//  ERCAPI+Parameter.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import Moya

extension ERCAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .fetchAssets:
            return URL(string: "https://api.opensea.io")!
        }
    }
    
    public var path: String {
        switch self {
        case .fetchAssets:
            return "/api/v1/assets"        }
    }
    
    public var method: Method {
        switch self {
        case .fetchAssets:
            return .get
        }
    }
    
    public var headers: [String : String]? {
        let header = ["Content-Type": "application/json"]
        return header
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var sampleData: Data {
        return Data()
    }
}
