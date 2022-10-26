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
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
                    print(error)
                }
            }
    }
}


class CommentDiaryCheckDataManager {
    func commentDiaryCheckData(diaryID: Int, _ viewController: DetailCommentDiaryViewController) {
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
                    print(error)
                }
            }
    }
}


class PreSaveDiaryCheckDataManager {
    func commentDiaryCheckData(diaryID: Int, _ viewController: YPreSaveViewController) {
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
                    print(error)
                }
            }
    }
}

class NotArrivalCommentDiaryCheckDataManager {
    func diaryCheckData(diaryID: Int, _ viewController: NotArrivalCommentDiaryViewController) {
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
                    viewController.successGetDiary(response)
                
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
    }
}


class GatherLookDetailDiaryCheckDataManager {
    func commentDiaryCheckData(diaryID: Int, _ viewController: GatherLookDetailViewController) {
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
                    viewController.diaryGetSuccess(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}



class YReadCommentCheckDataManager {
    func DiaryCheckData(diaryID: Int, _ viewController: YReadCommentViewController) {
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
//                    viewController.diaryGetSuccess(response)
                    viewController.yReadDiarySuccessResponse(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


class ReadCommentAllButtonTapDataManager {
    func allbuttonTapData(diaryID: Int, _ viewController: ReadCommentViewController) {
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
                    viewController.checkCommentBool(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
    }
}


class YNotWriteCommentDataManager {
    func YNotWriteCommentData(diaryID: Int, _ viewController: YNotWriteCommentViewController) {
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
                    viewController.diaryGet(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


class SortationDataManager {
    func gatherLookDetailSortData(diaryID: Int, _ viewController: GatherLookViewController) {
        let url = "\(Constant.CODA_URL)/diary/\(diaryID)"
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
                    viewController.selectedDiaryGet(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
