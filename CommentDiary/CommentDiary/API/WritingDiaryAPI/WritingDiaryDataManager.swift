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
        let url = "http://jwyang.shop:8080/api/v1/diary"
        let params = ["title" : WritingDiaryRequest.title,
                      "content" : WritingDiaryRequest.content,
                      "date" : WritingDiaryRequest.date,
                      "deliveryYn" : WritingDiaryRequest.deliveryYn]
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
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
                    viewController.writingDiarySucessResponse()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
