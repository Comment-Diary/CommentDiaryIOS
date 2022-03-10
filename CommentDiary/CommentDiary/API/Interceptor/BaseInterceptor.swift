//
//  BaseInterceptor.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
import Alamofire

//class BaseInterceptor : RequestInterceptor {
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        var request = urlRequest
//
//        //헤어부분 넣어주기
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("*/*", forHTTPHeaderField: "Accept")
//
//        completion(.success(request))
//    }
//}



import Foundation
import Alamofire

final class MyRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let accessToken: String = UserDefaults.standard.value(forKey: "AccessToken") as! String

        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
              completion(.doNotRetryWithError(error))
              return
          }

        func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
            let url = "http://jwyang.shop:8080/api/v1/members/reissue"
            let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
            let refreshToken = UserDefaults.standard.value(forKey: "RefreshToken") ?? ""
            let headers: HTTPHeaders = ["X-AUTH-TOKEN" : "\(token)", "REFRESH-TOKEN" : "\(refreshToken)"]

            AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate()
                .responseDecodable(of: TokenRefreshResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        print("DEBUG >> Success \(response)")
                        UserDefaults.standard.set(response.result.accessToken, forKey: "AccessToken")
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                
            }
        }
    }
}
//import Foundation
//import Alamofire
//
//class DeleteDiaryDataManater {
//    func deleteDiaryDeleteData(_ viewController: DeleteCheckAlertViewController) {
//
//        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
//
//        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
//
//        let diaryID: Int = UserDefaults.standard.value(forKey: "DiaryID") as! Int
//
//
//        AF.request("http://jwyang.shop:8080/api/v1/diary/\(diaryID)",
//                   method: .delete,
//                   parameters: nil,
//                   headers: headers)
//            .validate()
//            .responseDecodable(of: DeleteDiaryResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    print("DEBUG>> Success \(response)")
//                    viewController.deleteSuccessResponse()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    viewController.delteFailResponse()
//                }
//            }
//    }
//}
