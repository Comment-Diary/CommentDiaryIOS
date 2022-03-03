//
//  UserVM.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
import Alamofire
import Combine

//class UserVM: ObservableObject {
//    
//    //MARK: properteis
//    var subscription = Set<AnyPublisher>()
//    
//    @Published var loggedInUser: UserData? = nil
//    
//    
//    //회원가입 하기
//    func register(name: String, email: String, password: String) {
//        print("UserVM: register() called")
//        AuthApiService.register(name: name, email: email, password: password)
//            .sink { completion: Subscribers.Completion<AFError> in
//                print("UserVM completion:  \(completion)")
//                
//            } receiveValue: { (receivedUser: UserData) in
//                self.loggedInUser = receivedUser
//            }.store(in: &subscription)
//    }
//}
