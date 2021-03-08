//
//  ERCAPI+Parameter.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import Moya

extension ERCAPI: TargetType {
    public var baseURL: URL {
        var path = rxRequest.domain
        switch self {
        case .fetchAssets(let req):
            do{
                let string = try req.asDictionary().queryString
                path += string
                
            } catch (let error) {
                print(error.localizedDescription)
            }
            return URL(string: path)!
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
