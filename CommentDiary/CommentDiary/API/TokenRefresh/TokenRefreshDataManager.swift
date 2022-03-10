//
//  TokenRefreshDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

//import Foundation
//import Alamofire
//
//class TokenRefreshDataManager {
//    func tokenRefreshPostData() {
//        let url = "http://jwyang.shop:8080/api/v1/members/reissue"
//        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
//        let refreshToken = UserDefaults.standard.value(forKey: "RefreshToken") ?? ""
//        let headers: HTTPHeaders = ["X-AUTH-TOKEN" : "\(token)", "REFRESH-TOKEN" : "\(refreshToken)"]
//
//
//        AF.request(url,
//                   method: .post,
//                   parameters: nil,
//        encoder: JSONParameterEncoder(),
//        headers: headers)
//            .validate()
//            .responseDecodable(of: TokenRefreshResponse.self) { response in
//
//            }
//
//
//
//
//    }
//}
