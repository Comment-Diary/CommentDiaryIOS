//
//  AuthRouter.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
import Alamofire

//인증 라우터
//회원가입, 로그인, 토큰갱신
enum AuthRouter: URLRequestConvertible {
    case register(name: String, email: String, password: String)
    case login(email: String, password: String)
    
    case tokenRefresh
    
    
    var baseURL: URL {
        return URL(string: ApiClient.BASE_URL)!
        
    }
    
    var endPoint: String {
        switch self {
        case .register:
            return "user/register"
        case .login:
            return "" //예시
            
        case .tokenRefresh:
            return "members/reissue"
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
//        case .tokenRefresh: return .get
        default: return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .login(email, password):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            return params
        case .register(let name, let email, let password):
            var params = Parameters()
            params["name"] = name
            params["email"] = email
            params["password"] = password
        case .tokenRefresh:
            var params = Parameters()
//            params
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        
        request.method = method
        
        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        
        return request
        
    }
}
