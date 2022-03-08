//
//  ModifyDiaryDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/28.
//

import Foundation
import Alamofire
//let diaryID =  UserDefaults.standard.value(forKey: "DiaryID") ?? ""
class ModifyDiaryDataManager {
    func modifyDiaryPostData(_ viewController: NEidtViewController) {
        let diaryID: Int = UserDefaults.standard.value(forKey: "DiaryID") as! Int
        let url = "http://jwyang.shop:8080/api/v1/diary/\(diaryID)"
        let params = ["title" : ModifyDiaryRequest.title,
                      "content" : ModifyDiaryRequest.content]
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .patch,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: headers)
            .validate()
            .responseDecodable(of: ModifyDiaryResopnse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.editDiarySuccessResponse(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
