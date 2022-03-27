//
//  BaseInterceptor.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
import UIKit
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

//
//class MyRequestInterceptor: UIViewController, RequestInterceptor {
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        let accessToken: String = UserDefaults.standard.value(forKey: "AccessToken") as! String
//        print("인터셉트??")
//        var urlRequest = urlRequest
//        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
//
////        urlRequest.headers.add(.authorization(bearerToken: accessToken))
//        print(completion(.success(urlRequest)), "테스트")
//        completion(.success(urlRequest))
//    }
//
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//
//        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
//              completion(.doNotRetryWithError(error))
//            print("호출")
//              return
//          }
//
//
////        func tokenRefreshPostData() {
//            let url = "http://jwyang.shop:8080/api/v1/members/reissue"
//            let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
//            let refreshToken = UserDefaults.standard.value(forKey: "RefreshToken") ?? ""
//            print(token, "토큰")
//            print(refreshToken, "리프레시")
//            let headers: HTTPHeaders = ["X-AUTH-TOKEN" : token as! String, "REFRESH-TOKEN" : refreshToken as! String]
//
//            AF.request(url,
//                       method: .post,
//            parameters: nil,
//                       encoding: URLEncoding.default,
//            headers: headers)
//                .validate()
//                .responseDecodable(of: TokenRefreshResponse.self) { response in
//                    switch response.result {
//                    case .success(let response):
//                        print("DEBUG>> Success\(response)")
//                        print("토큰리프레시 성공")
//
////                        UserDefaults.standard.removeObject(forKey: "AccessToken")
////                        UserDefaults.standard.removeObject(forKey: "RefreshToken")
//
//                        UserDefaults.standard.set(response.result?.accessToken!, forKey: "AccessToken")
//                        UserDefaults.standard.set(response.result?.refreshToken!, forKey: "RefreshToken")
//                        completion(.retry)
//
//                    case .failure(let error):
//    //                    print(error.localizedDescription)
//    //                    print(error)
//    //                    print("토큰 리프레시")
//                        print("토큰 리프레시\(error.localizedDescription)")
//                        completion(.doNotRetryWithError(error))
//                        if response.response?.statusCode == 401 {
//                            let splashVC = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as! SplashVieController
//                            self.present(splashVC, animated: true)
//
//
//                        }
//                    }
//                }
//
//
//    }
//}



//func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
//    let url = "http://jwyang.shop:8080/api/v1/members/reissue"
//    let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
//    let refreshToken = UserDefaults.standard.value(forKey: "RefreshToken") ?? ""
//    print(token, "토큰")
//    print(refreshToken, "리프레시")
//    let headers: HTTPHeaders = ["X-AUTH-TOKEN" : token as! String, "REFRESH-TOKEN" : refreshToken as! String]
//
//    AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
//        .validate()
//        .responseDecodable(of: TokenRefreshResponse.self) { response in
//            switch response.result {
//            case .success(let response):
//                print("DEBUG>> Success\(response)")
//                print("되나???")
//                completion(true)
//
//            case .failure(let error):
//                completion(false)
//                print(error.localizedDescription)
//            }
//        }
//}



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
