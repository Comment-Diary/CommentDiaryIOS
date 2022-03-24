//
//  AllDiaryDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/04.
//

import Foundation
import Alamofire
//
//protocol delegatable: AnyObject {
//    func diaryMainPageSuccess(_ response: DiaryMainPageResponse)
//}
//class DiaryMainPageDataManager {
//    weak var delegate: delegatable?
//    func diaryMainData(_ viewController: WritingDiaryViewController) {
//
//        let url = "http://jwyang.shop:8080/api/v1/diary/main"
//        let params: Parameters = [
//            "date" : "\(viewController.selectedMonDate)"
//        ]
//        let token = UserDefaults.standard.value(forKey: "AccessToken") ?? ""
//        let headers: HTTPHeaders = [.authorization(bearerToken: token as! String)]
//
////        print(cell.apiDateString, "??????????")
//        AF.request(url,
//                   method: .get,
//                   parameters: params,
//                   encoding: URLEncoding.default,
//        headers: headers)
//            .validate()
//            .responseDecodable(of: DiaryMainPageResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    print("DEBUG >> Success \(response)")
////                    cell.diaryMainPagesu
////                    cell.diaryMainPageSuccess(response)
//                    viewController.writingDiaryTableView.reloadData()
//                    self.delegate?.diaryMainPageSuccess(response)
//
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//
//    }
//}

class DiaryMainPageDataManager {
    func diaryMainDate(_ viewcontroller: WritingDiaryVC) {
        let url = "http://jwyang.shop:8080/api/v1/diary/main"
        let params: Parameters = [
                    "date" : ""
                ]

        let token =  UserDefaults.standard.value(forKey: "AccessToken") ?? ""
        let headers : HTTPHeaders = [.authorization(bearerToken: token as! String)]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers,
        interceptor: MyRequestInterceptor())
            .validate()
            .responseDecodable(of: DiaryMainPageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewcontroller.diaryMainDateSuccessResponse(response)
                    print(viewcontroller.tempYArray, "임시저장 배열")
                    print(viewcontroller.deliveryNArray, "혼자 쓴 일기 배열")
                    print(viewcontroller.commentNoArrivalArray, "코멘트 아직 안온 배열")
                    print(viewcontroller.commentArrivalArray, "코멘트 온 배열")
                case . failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
