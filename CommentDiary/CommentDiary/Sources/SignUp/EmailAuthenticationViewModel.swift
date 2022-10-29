//
//  EmailAuthenticationViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/27.
//

import Foundation
import RxCocoa
import RxSwift

struct EmailAuthenticationViewModel {
    var codeTextFieldSubject = PublishSubject<String>()
    
    lazy var codeFormCheck = codeTextFieldSubject.map({
        value -> Bool in
        print(value)
        return value.count > 3 ? true : false
    })
//    lazy var codeFormCheck = Observable.map(codeTextFieldSubject)
    
    func buttonTapped(_ emailValue : String, codeValue: String, completion: @escaping (Int) -> (Void)) {
        EmailAuthenficationRequest.email = emailValue
        EmailAuthenficationRequest.code = codeValue
        EmailAuthenficationDataManager().checkEmailPostData(completion: { response in
            completion(response)
        })
    }
}
