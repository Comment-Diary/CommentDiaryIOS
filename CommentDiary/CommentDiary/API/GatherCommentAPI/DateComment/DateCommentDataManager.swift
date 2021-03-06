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
        let url = "http://comment-diary.shop/api/v1/comment"
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
                    print(error)
                    
                }
            }
    }
}

class CompareDataManager {
    func dateCommentData(_ viewController: ReadCommentViewController, dateValue: String) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://comment-diary.shop/api/v1/comment"
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
                    print(error)
                    
                }
            }
    }
}

class CompareDateDataManager {
    func commentDiaryDateData(_ viewController: GatherLookViewController, dateValue: String) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://comment-diary.shop/api/v1/comment"
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
                    print("DEBUG>> Success \(response)")
                    viewController.countCommentResponse(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
    }
}



class PreparationStatusDataManager {
    func preparationStatusData(_ viewController: GatherLookDetailViewController, dateValue: String) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "http://comment-diary.shop/api/v1/comment"
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
                    viewController.preparationStatusResponse(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
    }
}

