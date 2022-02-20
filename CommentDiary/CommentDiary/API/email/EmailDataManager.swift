//
//  EmailDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/20.
//

import Foundation


//import Alamofire
//
//class EmailDataManager {
//    func emailPostData() {
//        let url = ""
////        let params
//        
//        
//        AF.request(url,
//                   method: .post,
//                   parameters: <#T##Encodable?#>,
//                   encoder: <#T##ParameterEncoder#>,
//                   headers: <#T##HTTPHeaders?#>)
//    }
//}



//
//import Foundation
//import Alamofire
//
//class SelfSignInDataManager {
//    func signInPostData() {
//        let url = "\(Constant.BASE_URL)/users"
//        let params = ["email" : SelfSignInUserInto.email,
//                      "password" : SelfSignInUserInto.password,
//                      "storeName" : SelfSignInUserInto.storeName,
//                      "userType": SelfSignInUserInto.userType
//        ]
//        AF.request(url,
//                   method: .post,
//                   parameters: params,
//                   encoder: JSONParameterEncoder(),
//                   headers: nil)
//            .validate()
//            .responseDecodable(of: SelfSignInResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    print("DEBUG >> Success \(response)")
//                    SignResponse.ResponseState = response.isSuccess
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//    }
//}
