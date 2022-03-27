//
//  LogOutDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/26.
//

import Foundation
import Alamofire

class LogOutDataManager {
    func logOutMemberData(_ viewController: MyAccountViewController) {
        let url = "http://jwyang.shop:8080/api/v1/members/logout"
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
//        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        let headers: HTTPHeaders = ["X-AUTH-TOKEN" : token as! String]
        
        AF.request(url,
                   method: .delete,
                   parameters: nil,
                   headers: headers)
            .validate()
            .responseDecodable(of: LogOutResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG>> Success \(response)")
                    viewController.successLogOut(response)
                    UserDefaults.standard.removeObject(forKey: "AccessToken")
                    UserDefaults.standard.removeObject(forKey: "RefreshToken")
                    UserDefaults.standard.set(false, forKey: "login_save")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
