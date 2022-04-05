//
//  SearchPasswordDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/22.
//

import Foundation
import Alamofire

class SearchPasswordDataManager {
    func getPasswordData(emailValue: String, _ viewController: PasswordSearchViewController) {
        let url = "http://comment-diary.shop/api/v1/email/password"
        let params: Parameters = [
            "email" : "\(emailValue)"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: SearchPasswordResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.findPasswordResponse()

                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.failFindPasswordResponse()
                }
            }
    }
    
}
