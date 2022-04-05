//
//  GatherDiaryDateDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import Foundation
import Alamofire
class GatherDiaryDateDataManager {
    func gatherDiaryDateData(_ viewController: GatherLookViewController, dateValue : String) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://comment-diary.shop/api/v1/diary/my"
        let params : Parameters = [
            "date" : "\(dateValue)"
        ]
        
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: GatherDiaryDateResponse.self) { response in
                switch response.result {
                case.success(let response):
                    print("DEBUG >> Success \(response)")

                    viewController.gatehrDiaryDateSuccess(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
    }
}
