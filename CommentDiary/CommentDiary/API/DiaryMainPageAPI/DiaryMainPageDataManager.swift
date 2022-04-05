//
//  AllDiaryDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/04.
//

import Foundation
import Alamofire


class DiaryMainPageDataManager {
    func diaryMainDate(_ viewcontroller: WritingDiaryVC) {
        let url = "http://comment-diary.shop/api/v1/diary/main"
        let params: Parameters = [
                    "date" : ""
                ]

        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: DiaryMainPageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewcontroller.diaryMainDateSuccessResponse(response)
//                    print(viewcontroller.tempYArray, "임시저장 배열")
//                    print(viewcontroller.deliveryNArray, "혼자 쓴 일기 배열")
//                    print(viewcontroller.commentNoArrivalArray, "코멘트 아직 안온 배열")
//                    print(viewcontroller.commentArrivalArray, "코멘트 온 배열")
                case .failure(let error):
                
                    print("메일 다이어리",error)
                    print(error.localizedDescription)
                }
            }
    }
}
