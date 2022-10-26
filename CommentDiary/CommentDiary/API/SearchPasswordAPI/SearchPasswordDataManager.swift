//
//  SearchPasswordDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/22.
//

import Foundation
import Alamofire
import RxSwift

class SearchPasswordDataManager {
    var viewModel = SearchPasswordViewModel()
    let disposeBag = DisposeBag()
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
            .responseDecodable(of: SearchPasswordResponse.self) { response in
                completion(response.response?.statusCode ?? 0)
                
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                case .failure(let error):
                    print(error)
                

                }
            }
    }
}
