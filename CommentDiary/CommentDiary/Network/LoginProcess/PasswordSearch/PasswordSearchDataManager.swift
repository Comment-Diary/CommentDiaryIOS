//
//  PasswordSearchDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/12/23.
//


import Alamofire

class PasswordSearchDataManager {
    func getPasswordData(emailValue: String,completion: @escaping (Int) -> (Void)){
        let url = "\(Constant.CODA_URL)/email/password"
        let params: Parameters = [
            "email" : "\(emailValue)"
        ]

        AF.request(url,
                   method: .get,
        parameters: params,
                   encoding: URLEncoding.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: PasswordSearchResponse.self) { response in
                completion(response.response?.statusCode ?? 0)
                print(response.response?.statusCode)
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                case .failure(let error):
                    print(error)
                

                }
            }
    }
}
