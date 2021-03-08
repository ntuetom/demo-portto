//
//  Network.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import Moya
import RxSwift

public enum ParseResponseError: Error{
    case respnseError(errCode: String, errMsg: String, data: Data? = nil)
    case parseError
    case others
    
    public var message: String {
        switch self {
        case .respnseError(_, let msg, _):
            return msg
        case .parseError:
            return "解析錯誤"
        default:
            return "未知的錯誤"
        }
    }
    
    public var code: String {
        switch self {
        case .respnseError(let code, _, _):
            return code
        case .parseError:
            return "PARSE_ERROR"
        default:
            return "GYResponse_UNKNOWN_ERROR"
        }
    }
}


let rxRequest = RxRequest.shared
public class RxRequest: NSObject {
    
    static let shared = RxRequest()
    var provider: MoyaProvider<ERCAPI>!
    var _loadingPlugin: [PluginType]!
    
    override init() {
        super.init()
        _loadingPlugin = [loadingPluging]
        provider = MoyaProvider<ERCAPI>(plugins: _loadingPlugin)
    }
    
    
    lazy var loadingPluging = NetworkActivityPlugin{ (type, target) in
        switch type{
        case .began:
            k_RefreshView.toggle(isOn: true)
        case .ended:
            k_RefreshView.toggle(isOn: false)
        }
    }
    
    func request<T: Decodable>(target: ERCAPI) -> Single<Result<T,ParseResponseError>> {
        return Single.create{ [unowned self] single in
            self.provider.request(target) { responseResult in
                switch responseResult{
                case let .success(response):
                    if response.statusCode == 200 {
                        do {
                            let tempObj = try JSONDecoder().decode(T.self, from: response.data)
                            single(.success(.success(tempObj)))
                        } catch (let error) {
                            let _error = ParseResponseError.respnseError(errCode: "", errMsg: error.localizedDescription)
                            single(.error(_error))
                        }
                    } else {
                        let _error = ParseResponseError.others
                        single(.error(_error))
                    }
                case let .failure(error):
                    let _error = ParseResponseError.respnseError(errCode: "", errMsg: error.localizedDescription)
                    single(.error(_error))
                }
            }
            return Disposables.create()
        }
    }
}
