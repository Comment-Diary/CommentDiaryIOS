//
//  DiaryReportDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import Alamofire

class DiaryReportDataManager {
    func diaryReportPostData(_ viewController: ArrivedDiaryViewController) {
        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let url = "http://jwyang.shop:8080/api/v1/report/diary"
        let params = ["diaryId" : "\(DiaryReportRequest.diaryId)",
                      "content" : DiaryReportRequest.content]
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        AF.request(url,
                   method: .post,
        parameters: params,
                   encoder: JSONParameterEncoder(),
        headers: headers)
            .validate()
            .responseDecodable(of: DiaryReportResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
