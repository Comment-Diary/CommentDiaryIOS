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
        return value.count > 0
    })
    
    func buttonTapped(_ emailValue : String, codeValue: String, completion: @escaping (Int) -> (Void)) {
        EmailAuthenficationRequest.email = emailValue
        EmailAuthenficationRequest.code = codeValue
        EmailAuthenficationDataManager().checkEmailPostData(completion: { response in
            completion(response)
        })
    }
}
