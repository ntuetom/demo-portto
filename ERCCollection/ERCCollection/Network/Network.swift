//
//  Network.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import Moya
import RxSwift

public enum ERCResponseResult<Value, Failure> {
    case success(Value)
    case failure(Failure)
    
    init(value: Value){
        self = .success(value)
    }
    
    init(error: Failure){
        self = .failure(error)
    }
}

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

let provider = MoyaProvider<ERCAPI>()

let rxRequest = RxRequest.shared
public class RxRequest: NSObject {
    static let shared = RxRequest()
    
    func request<T: Decodable>(target: ERCAPI) -> Observable<ERCResponseResult<T,ParseResponseError>> {
        return Observable.create({ observer -> Disposable in
            provider.request(target) { responseResult in
                switch responseResult{
                case let .success(response):
                    if response.statusCode == 200 {
                        do {
                            let tempObj = try JSONDecoder().decode(T.self, from: response.data)
                            observer.onNext(.success(tempObj))
                        } catch (let error) {
                            let _error = ParseResponseError.respnseError(errCode: "", errMsg: error.localizedDescription)
                            observer.onNext(.failure(_error))
                        }
                    } else {
                        observer.onNext(.failure(.others))
                    }
                case let .failure(error):
                    let _error = ParseResponseError.respnseError(errCode: "", errMsg: error.localizedDescription)
                    observer.onNext(.failure(_error))
                }
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
}
