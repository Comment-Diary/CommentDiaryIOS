//
//  TokenRefreshDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import Alamofire

class TokenRefreshDataManager {
    func tokenRefreshPostData() {
        let url = "http://jwyang.shop:8080/api/v1/members/reissue"
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let refreshToken = UserDefaults.standard.value(forKey: "RefreshToken") ?? ""
        let headers: HTTPHeaders = ["X-AUTH-TOKEN" : token as! String, "REFRESH-TOKEN" : refreshToken as! String]
        
        AF.request(url,
                   method: .post,
        parameters: nil,
                   encoding: URLEncoding.default,
        headers: headers)
            .validate()
            .responseDecodable(of: TokenRefreshResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG>> Success\(response)")
//                    response.result.accessToken
                    UserDefaults.standard.set(response.result.accessToken, forKey: "AccessToken")
                    UserDefaults.standard.set(response.result.refreshToken, forKey: "RefreshToken")
                    print("ddddddddddd")
                case .failure(let error):
                    print(error.localizedDescription)
                    print("?????")
                }
            }
    }
}
