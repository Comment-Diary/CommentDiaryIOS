//
//  CertificationNumberDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/25.
//

import Foundation
import Alamofire
import RxSwift

class EmailCheckDataManager {
    var viewModel = EmailCheckViewModel()
    let disposeBag = DisposeBag()
    func getEmailData(emailValue: String, completion: @escaping (Int) -> (Void)) {
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
            .responseDecodable(of: EmailCheckResponse.self) { response in
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
