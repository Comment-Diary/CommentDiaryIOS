//
//  GatherDiaryAllDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import Foundation
import Alamofire
class GatherDiaryAllDataManager {
    func gahterDiaryAllData(_ viewController: GatherLookViewController) {
        let url = "http://jwyang.shop:8080/api/v1/diary/my/all"
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
        headers: headers)
            .validate()
            .responseDecodable(of: GatherDiaryAllResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.gatehrDiaryAllSuccess(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
