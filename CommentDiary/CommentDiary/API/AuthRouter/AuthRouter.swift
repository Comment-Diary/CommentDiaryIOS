//
//  AuthRouter.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Alamofire

// 인증 라우터
// 회원가입, 로그인, 토큰갱신
enum AuthRouter: URLRequestConvertible {
    

    case tokenRefresh
    
    var baseURL: URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    
    var endPoint: String {
        switch self {

        case .tokenRefresh:
            return "members/reissue"
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .post
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .tokenRefresh:
            var header = HTTPHeaders()
            let tokenData = UserDefaultManager.shared.getTokens()
            header["X-AUTH-TOKEN"] = tokenData.accessToken
            header["REFRESH-TOKEN"] = tokenData.refreshToken
            return header
        }
    }
    
//    var parameters: Parameters{
//        switch self {
//
//        case .tokenRefresh:
//
//            var params = Parameters()
//            let tokenData = UserDefaultManager.shared.getTokens()
//            params["refresh_token"] = tokenData.refreshToken
//            return params
//        }
//    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        request.headers = headers
        
//        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        
        return request
    }
    
    
}
