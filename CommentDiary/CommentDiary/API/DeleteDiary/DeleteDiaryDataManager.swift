//
//  DeleteDiaryDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/04.
//

import Foundation
import Alamofire

class DeleteDiaryDataManater {
    func deleteDiaryDeleteData(_ viewController: DeleteCheckAlertViewController) {

        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        
        
        AF.request("http://jwyang.shop:8080/api/v1/diary/:\(UserDefaults.standard.value(forKey: "DiaryID") ?? 0)",
                   method: .delete,
                   parameters: nil,
                   headers: headers)
            .validate()
            .responseDecodable(of: DeleteDiaryResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG>> Success \(response)")
                    viewController.deleteSuccessResponse()
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.delteFailResponse()
                }
            }
    }
}
