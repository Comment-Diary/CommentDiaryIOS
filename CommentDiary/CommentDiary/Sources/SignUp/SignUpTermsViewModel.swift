//
//  SignUpTermsViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/31.
//

import Foundation
import RxCocoa
import RxSwift
struct SignUpTermsViewModel {
    var signUpCase : String = ""
    var fullConsentButtonSubject = BehaviorSubject<Bool>(value: false)
    var pushAlertButtonSubject = BehaviorSubject<Bool>(value: false)
    var privacyButtonSubject = BehaviorSubject<Bool>(value: false)
    var termsButtonSubject = BehaviorSubject<Bool>(value: false)
    var pushAlertReceptionValue : Bool = false
    
    
    func fullConsentButtonTrue() {
        self.pushAlertButtonSubject.onNext(true)
        self.privacyButtonSubject.onNext(true)
        self.termsButtonSubject.onNext(true)
    }
    func fullConsentButtonFalse() {
        self.pushAlertButtonSubject.onNext(false)
        self.privacyButtonSubject.onNext(false)
        self.termsButtonSubject.onNext(false)
    }
    lazy var enableButton = Observable.combineLatest(privacyButtonSubject, termsButtonSubject, resultSelector: {
        (privacyButtonSubject : Bool, termsButtonSubject : Bool) in
        return privacyButtonSubject == true && termsButtonSubject == true ? true : false
    })
    lazy var fullConsentButton = Observable.combineLatest(privacyButtonSubject, termsButtonSubject, pushAlertButtonSubject, resultSelector: {
        (privacyButtonSubject : Bool, termsButtonSubject : Bool, pushAlertButtonSubject : Bool) in
        return privacyButtonSubject == true && termsButtonSubject == true && pushAlertButtonSubject == true ? true : false
    })
    
}
