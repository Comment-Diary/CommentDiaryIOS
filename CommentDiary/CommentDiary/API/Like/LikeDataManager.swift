//
//  LikeDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/22.
//

import Foundation
import Alamofire

class LikeDataManager {
    func likePatchData(_ viewController: GatherLookDetailViewController, _ commentValue: Int) {
        let url = "\(Constant.CODA_URL)/comment/like/\(commentValue)"
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .patch,
        parameters: nil,
        headers: headers)
            .validate()
            .responseDecodable(of: LikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG>> Success \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
