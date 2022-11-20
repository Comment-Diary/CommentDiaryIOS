//
//  EmailLoginViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/11/18.
//

import RxCocoa
import RxSwift

struct EmailLoginViewModel {
    var passwordTextFieldSubject = PublishSubject<String>()
    var emailTextFieldSubject = PublishSubject<String>()
    
    lazy var idFormChechk = emailTextFieldSubject.map({ value -> Bool in
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: value)
    })
    
    lazy var passwordFormCheck = passwordTextFieldSubject.map( { value -> Bool in
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: value)
    })
    
    lazy var enabledButton = Observable.combineLatest(idFormChechk, passwordFormCheck, resultSelector: {
        (idFormChechk : Bool, passwordFormCheck : Bool) in
        return idFormChechk == true && passwordFormCheck == true ? true : false
    })
    
    func loginButtonTapped() {
        
    }
}
