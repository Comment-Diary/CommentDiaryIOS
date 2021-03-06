//
//  CommentReportDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import Alamofire
class CommentReportDataManager {
    func commentReportPostData(_ viewController: CommentReportViewController, commentIdx: Int, commentReportContent: String) {
        let url = "http://comment-diary.shop/api/v1/report/comment"
        let params = ["commentId" : "\(commentIdx)",
                      "content" : commentReportContent]
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .post,
        parameters: params,
        encoder: JSONParameterEncoder(),
        headers: headers)
            .validate()
            .responseDecodable(of: CommentReportResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")

                    viewController.commentReportSuccess(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


class CommentBlockDataManager {
    func commentReportPostData(_ viewController: CommentBlockViewController, commentIdx: Int, commentReportContent: String) {
        let url = "http://comment-diary.shop/api/v1/report/comment"
        let params = ["commentId" : "\(commentIdx)",
                      "content" : commentReportContent]
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .post,
        parameters: params,
        encoder: JSONParameterEncoder(),
        headers: headers)
            .validate()
            .responseDecodable(of: CommentReportResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")

                    viewController.commentBlockSuccess(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
