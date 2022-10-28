//
//  EmailAuthenficationDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/29.
//

import Foundation
import Alamofire

class EmailAuthenficationDataManager {
    func checkEmailPostData(completion: @escaping (Int) -> (Void)) {
        let url = "\(Constant.CODA_URL)/email/confirm"
        let params = ["email" : EmailAuthenficationRequest.email,
                      "code" : EmailAuthenficationRequest.code]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: CheckEmailResponse.self) { response in
                completion(response.response?.statusCode ?? 0)
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")

                case .failure(let error):
                    print(error.localizedDescription)

                }
            }
    }
}
