//
//  WritingDiaryDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/28.
//

import Foundation
import Alamofire

class WritingDiaryDataManager {
    func writingDiaryPostData(_ viewController: TodayDiaryViewController) {
//        let storedTokenData = UserDefaultManager.shared.getTokens()
//        let credential = OAuthCredential(accessToken: storedTokenData.accessToken , refreshToken: storedTokenData.refreshToken, expiration: Date(timeIntervalSinceNow: 60 * 5))
//        let authenticator = OAuthAuthenticator()
//        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
//                                                    credential: credential)
//
        
        
        
        let url = "http://jwyang.shop:8080/api/v1/diary"
        let params = ["title" : WritingDiaryRequest.title,
                      "content" : WritingDiaryRequest.content,
                      "date" : WritingDiaryRequest.date,
                      "deliveryYn" : WritingDiaryRequest.deliveryYn,
                      "tempYn" : WritingDiaryRequest.tempYn]
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: headers,
        interceptor: MyRequestInterceptor())
            .validate()
            .responseDecodable(of: WritingDiaryResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.writingDiarySucessResponse(response)

                    UserDefaults.standard.set(response.result.id, forKey: "DiaryID")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


class WritingCommentDiaryDataManager {
    func writingCommentDiaryPostData(_ viewController: SendDiaryAlertViewController) {
        let url = "http://jwyang.shop:8080/api/v1/diary"
        let params = ["title" : WritingDiaryRequest.title,
                      "content" : WritingDiaryRequest.content,
                      "date" : WritingDiaryRequest.date,
                      "deliveryYn" : WritingDiaryRequest.deliveryYn]
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: headers)
            .validate()
            .responseDecodable(of: WritingDiaryResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.writingCommentDiarySuccessResponse(response)
                    UserDefaults.standard.set(response.result.id, forKey: "DiaryID")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
