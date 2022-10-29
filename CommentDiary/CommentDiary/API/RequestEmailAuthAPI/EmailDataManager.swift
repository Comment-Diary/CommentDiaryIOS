//
//  EmailDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/20.
//

import Foundation


import Alamofire

class EmailDataManager {
    func getEmailData(emailValue: String, _ viewController: SignUpViewController) {
        let url = "\(Constant.CODA_URL)/email"
        let params: Parameters = [
            "email" : "\(emailValue)"
        ]
        
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: EmailResponse.self) { response in
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
