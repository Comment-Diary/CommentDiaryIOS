//
//  AllCommentDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/25.
//

import Foundation
import Alamofire

class AllCommentDataManager {
    func allCommentData(_ viewController: UIViewController) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://jwyang.shop:8080/api/v1/diary/all"
        
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: AllCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}