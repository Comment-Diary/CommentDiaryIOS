//
//  SearchPasswordViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/09/25.
//

//import Foundation
//import RxCocoa
//import RxSwift
//
//struct SearchPasswordViewModel {
//    var emailTextFieldSubject = PublishSubject<String>()
//    var findingPasswordAPICode = PublishSubject<String>()
//    
//    lazy var idFormCheck = emailTextFieldSubject.map({ value -> Bool in
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
//        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: value)
//    })
//    
//    func buttonTapped(_ emailValue: String, completion: @escaping (Int) -> Void) {
//        SearchPasswordDataManager().getPasswordData(emailValue: emailValue, completion: { response in
//            completion(response)
//        })
//    }
//}
