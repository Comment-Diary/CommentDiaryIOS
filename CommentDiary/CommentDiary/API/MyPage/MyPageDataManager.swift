//
//  MyPageDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/11.
//

import Foundation
import Alamofire

class MyPageDataManager {
    func myPageData(_ viewController: MyPageViewController) {
        let url = "http://comment-diary.shop/api/v1/members"
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: MyPageResponse.self) { response in
                switch  response.result {
                case .success(let response):
                    
                    print("DEBUG >> Success \(response)")
                    viewController.myPageSuccessResponse(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                    
                }
            }
        
    }
}
