//
//  EmailDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/20.
//

import Foundation


import Alamofire

class EmailDataManager {
    func emailPostData() {
        let url = "http://jwyang.shop:8080/api/v1/email"
        let params = ["email" : EmailRequest.email]
        
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: EmailResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


