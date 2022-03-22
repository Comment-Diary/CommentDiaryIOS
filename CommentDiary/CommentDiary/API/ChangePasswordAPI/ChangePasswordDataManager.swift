//
//  ChangePasswordDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/22.
//

import Foundation
import Alamofire

class ChangePasswordDataManager {
    func changePasswordPatchData(_ viewController: ChagePasswordViewController) {
        let url = "http://jwyang.shop:8080/api/v1/members"
        let params = ["password" : ChangePasswordRequest.password, "checkPassword" : ChangePasswordRequest.checkPassword]
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .patch,
        parameters: params,
        encoder: JSONParameterEncoder(),
        headers: headers)
            .validate()
            .responseDecodable(of: ChangePasswordResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
    }
}
