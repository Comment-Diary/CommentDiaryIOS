//
//  GatherDiaryDateDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import Foundation
import Alamofire
class GatherDiaryDateDataManager {
    func gatherDiaryDateData(_ viewController: GatherLookViewController) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://jwyang.shop:8080/api/v1/diary/my"
        let params : Parameters = [
            "date" : "\(viewController.apiDateString)"
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
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
    }
}
