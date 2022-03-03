//
//  ApiClient.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
////
//
//import Foundation
//import Alamofire
//
//// api 호출 클라이언트
//final class ApiClient {
//    static let shared = ApiClient()
//    
//    static let BASE_URL = "http://jwyang.shop:8080/api/v1"
//    
//    let interceptors = Interceptor(interceptors: [
//        BaseInterceptor() //application/json
//    ])
//    
//    let monitors = [ApiLogger()] as [EventMonitor]
//    
//    var session: Session
//    
//    init() {
//        print("ApiClient - init() called")
//        session = Session(interceptor: interceptors, eventMonitors: monitors)
//    }
//}
