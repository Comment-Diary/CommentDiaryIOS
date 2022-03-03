//
//  ApiLogger.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
import Alamofire
import UIKit

final class ApiLogger: EventMonitor {
    let queue = DispatchQueue(label: "CommentDiary") //프로젝트 이름
    
    //Event called when any type of Request is resumed
    //
    func requestDidResume(_ request: Request) {
        print("ApiLogger - Resuming \(request)")
    }
    
    
    // Event called whenever a DataRequest has parsed a response
    //API 끝날때마다
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("ApiLogger - Finished: \(response)")
    }
    
}
