//
//  CheckEmailDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/20.
//

import Foundation
import Alamofire

class CheckEmailDataManager {
    func checkEmailPostData(_ viewController: AuthNumberViewController) {
        let url = "http://jwyang.shop:8080/api/v1/email/confirm"
        let params = ["email" : CheckEmailRequest.email,
                      "code" : CheckEmailRequest.code]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: CheckEmailResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.authEmailResponse()

                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.authEmailFailResponse()
                }
            }
    }
}

