//
//  LikeDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/22.
//

import Foundation
import Alamofire

class LikeDataManager {
    func likePatchData(_ viewController: ViewController, _ commentValue: Int) {
        let url = "http://jwyang.shop:8080/api/v1/like/\(commentValue)"
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .patch,
        parameters: nil,
        headers: headers)
            .validate()
            .responseDecodable(of: LikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG>> Success \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
