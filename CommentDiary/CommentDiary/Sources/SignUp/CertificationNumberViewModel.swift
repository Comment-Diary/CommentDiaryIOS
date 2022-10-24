//
//  SignUpEmailViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/09.
//

import Foundation
import RxCocoa
import RxSwift

struct EmailCheckViewModel {
    var emailTextFieldSubject = PublishSubject<String>()
    
    lazy var idFormCheck = emailTextFieldSubject.map({ value -> Bool in
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: value)
    })
    
    func buttonTapped(_ emailValue : String, completion: @escaping (Int) -> (Void)) {
        EmailCheckDataManager().getEmailData(emailValue: emailValue, completion: { response in
            completion(response)
        })
    }
}
