//
//  DateCommentDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/25.
//

import Foundation
import Alamofire


class DateCommentDataManager {
    func dateCommentData(_ viewController: SendCommentViewController, dateValue: String) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://jwyang.shop:8080/api/v1/comment"
        let params : Parameters = [
            "date" : "\(dateValue)"
        ]
        
        AF.request(url,
                   method: .get,
        parameters: params,
                   encoding: URLEncoding.default,
        headers: headers)
            .validate()
            .responseDecodable(of: DateCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.getDateCommentListSucces(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
    }
}

class CompareDataManager {
    func dateCommentData(_ viewController: YReadCommentViewController, dateValue: String) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://jwyang.shop:8080/api/v1/comment"
        let params : Parameters = [
            "date" : "\(dateValue)"
        ]
        
        AF.request(url,
                   method: .get,
        parameters: params,
                   encoding: URLEncoding.default,
        headers: headers)
            .validate()
            .responseDecodable(of: DateCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.countMyCommentResponse(response)
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
    }
}
