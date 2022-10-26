//
//  ReceivedDiaryDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/22.
//

import Foundation
import Alamofire

class ReceivedDiaryDataManager {
    func receivedDiaryGetData(_ viewController: ArrivedDiaryViewController, dateValue: String) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "\(Constant.CODA_URL)/delivery"
        let params : Parameters = [
            "date" : "\(dateValue)"
        ]
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: ReceivedDiaryResponse.self) {
                response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.receivedDiaryGetSuccess(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
//                    response.response?.statusCode
//                    print(response.response?.statusCode , "상태 코드")
                    if response.response?.statusCode == 404 {
                        viewController.dismissIndicator()
                        viewController.commentScrollView.isHidden = true
                    }
                }
            }
    }
}
