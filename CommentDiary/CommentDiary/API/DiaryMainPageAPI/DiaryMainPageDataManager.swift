//
//  AllDiaryDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/04.
//

import Foundation
import Alamofire

class DiaryMainPageDataManager {
    func diaryMainData(_ cell: CalendarTableViewCell) {
        
        let url = "http://jwyang.shop:8080/api/v1/diary/main"
        let params: Parameters = [
            "date" : "\(cell.apiDateString)"
        ]
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        print(cell.apiDateString, "??????????")
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

                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
    }
}
