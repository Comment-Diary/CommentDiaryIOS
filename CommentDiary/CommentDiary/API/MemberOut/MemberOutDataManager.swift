//
//  MemberOutDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/26.
//

import Foundation
import Alamofire

class MemberOutDataManager {
    func deleteMemberData(_ viewController : MemberOutViewController) {
        let url = "\(Constant.CODA_URL)/members"
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .delete,
        parameters: nil,
        headers: headers)
            .validate()
            .responseDecodable(of: MemberOutResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.memberOutSuccess(response)
                    UserDefaults.standard.removeObject(forKey: "AccessToken")
                    UserDefaults.standard.removeObject(forKey: "RefreshToken")
                    UserDefaults.standard.set(false, forKey: "login_save")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
