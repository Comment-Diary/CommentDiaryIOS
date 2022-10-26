//
//  AllCommentDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/25.
//

import Foundation
import Alamofire

class AllCommentDataManager {
    func allCommentData(_ viewController: SendCommentViewController) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let url = "\(Constant.CODA_URL)/v1/comment/all"
        
        
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
                    viewController.getCommentListSuccess(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
    }
}
