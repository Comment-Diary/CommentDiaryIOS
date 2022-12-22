//
//  PasswordSearchViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/12/23.
//

import RxCocoa
import RxSwift

struct PasswordSearchViewModel {
    var emailTextFieldSubject = PublishSubject<String>()
    var findingPasswordAPICode = PublishSubject<String>()
    
    lazy var idFormCheck = emailTextFieldSubject.map({ value -> Bool in
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: value)
    })
    
    func buttonTapped(_ emailValue: String, completion: @escaping (Int) -> Void) {
        PasswordSearchDataManager().getPasswordData(emailValue: emailValue, completion: { response in
            completion(response)
        })
    }
}
