//
//  TokenRefreshDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import Alamofire

//class TokenRefreshDataManager {
//    func tokenRefreshPostData() {
//        let url = "http://jwyang.shop:8080/api/v1/members/reissue"
//        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
//        let refreshToken = UserDefaults.standard.value(forKey: "RefreshToken") ?? ""
//        print(token, "토큰")
//        print(refreshToken, "리프레시")
//        let headers: HTTPHeaders = ["X-AUTH-TOKEN" : token as! String, "REFRESH-TOKEN" : refreshToken as! String]
//
//        AF.request(url,
//                   method: .post,
//        parameters: nil,
//                   encoding: URLEncoding.default,
//        headers: headers)
//            .validate()
//            .responseDecodable(of: TokenRefreshResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    print("DEBUG>> Success\(response)")
//                    print("토큰리프레시 성공")
//                    UserDefaults.standard.removeObject(forKey: "AccessToken")
//                    UserDefaults.standard.removeObject(forKey: "RefreshToken")
//
//                    UserDefaults.standard.set(response.result?.accessToken!, forKey: "AccessToken")
//                    UserDefaults.standard.set(response.result?.refreshToken!, forKey: "RefreshToken")
//                    
//
//                case .failure(let error):
////                    print(error.localizedDescription)
////                    print(error)
////                    print("토큰 리프레시")
//                    print("토큰 리프레시\(error.localizedDescription)")
//                }
//            }
//    }
//}

//
//
//
//
class TokenRefreshDataManager {
    func tokenRefreshPostData(completion: @escaping(Bool) -> Void) {
        let url = "http://comment-diary.shop/api/v1/members/reissue"
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let refreshToken = UserDefaults.standard.value(forKey: "RefreshToken") ?? ""
        print(token, "토큰")
        print(refreshToken, "리프레시")
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

                    UserDefaults.standard.set(response.result?.accessToken, forKey: "AccessToken")
                    UserDefaults.standard.set(response.result?.refreshToken, forKey: "RefreshToken")
                        UserDefaults.standard.set(true, forKey: "login_save")
                        completion(true)

                case .failure(let error):
                    print(error.localizedDescription)
                    if response.response?.statusCode == 401 {
                        UserDefaults.standard.set(nil, forKey: "AccessToken")
                        UserDefaults.standard.set(nil, forKey: "RefreshToken")
                        UserDefaults.standard.set(false, forKey: "login_save")
                        completion(false)

                    }
                }
            }
    }
}
