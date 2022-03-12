//
//  SentCommentListDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/13.
//

import Foundation
import Alamofire

class SentCommentListDataManager {
    func sentCommentListData(_ viewController: SendCommentViewController) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://jwyang.shop:8080/api/v1/comment"
        
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: headers)
            .validate()
            .responseDecodable(of: SentCommentListResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
    }
}
