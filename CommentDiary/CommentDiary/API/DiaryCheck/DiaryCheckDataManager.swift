//
//  DiaryCheckDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import Alamofire

class DiaryCheckDataManager {
    func diaryCheckData(diaryID: Int, _ viewController: NSaveViewController) {
        let url = "http://jwyang.shop:8080/api/v1/diary/\(diaryID)"
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
        headers: headers)
            .validate()
            .responseDecodable(of: DiaryCheckResopnse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.diaryCheckSuccessResopnse(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


class CommentDiaryCheckDataManager {
    func commentDiaryCheckData(diaryID: Int, _ viewController: DetailCommentDiaryViewController) {
        let url = "http://jwyang.shop:8080/api/v1/diary/\(diaryID)"
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
        headers: headers)
            .validate()
            .responseDecodable(of: DiaryCheckResopnse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.commentDiaryGet(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


class PreSaveDiaryCheckDataManager {
    func commentDiaryCheckData(diaryID: Int, _ viewController: YPreSaveViewController) {
        let url = "http://jwyang.shop:8080/api/v1/diary/\(diaryID)"
        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
        headers: headers)
            .validate()
            .responseDecodable(of: DiaryCheckResopnse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.preSaveDiaryGet(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
