//
//  PasswordCheckVIewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/27.
//

import Foundation
import RxCocoa
import RxSwift
struct PasswordCheckViewModel {
    var passwordTextFieldSubject = PublishSubject<String>()
    var passwordCheckTextFieldSubject = PublishSubject<String>()
    
    
    lazy var passwordFormCheck = passwordTextFieldSubject.map( { value -> Bool in
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: value)
    })
    lazy var matchPasswordCheck = Observable.combineLatest(passwordTextFieldSubject, passwordCheckTextFieldSubject, resultSelector: { (password: String, passwordCheck : String) in
        return password == passwordCheck ? true : false
    })
    lazy var enabledButton = Observable.combineLatest(passwordFormCheck, matchPasswordCheck, resultSelector: {
        (passwordFormCheck : Bool, matchPasswordCheck : Bool) in
        return passwordFormCheck == true && matchPasswordCheck == true ? true : false
    })
    func signUpButtonTapped(completion: @escaping (Int) -> (Void)) {
        let userInfo = UserInfo.shared
        SignUpRequest.email = userInfo.email ?? ""
        SignUpRequest.password = userInfo.password ?? ""
        SignUpRequest.checkPassword = userInfo.passwordCheck ?? ""
        SignUpRequest.loginType = "EMAIL"
        SignUpRequest.pushYn = userInfo.pushAlertReception ?? "N"
        
        SignUpDataManager().signUpPostData(completion: { response in
            completion(response)
        })
    }
}
