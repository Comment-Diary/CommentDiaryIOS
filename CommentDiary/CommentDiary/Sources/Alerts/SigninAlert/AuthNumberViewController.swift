//
//  SigninAlertViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit
//https://www.youtube.com/watch?v=NP7H_LjTZGw
//성공 여부 확인시켜주기

protocol emailTextFieldChangeDelegate {
    func onEmailTextFieldChange(data: Bool)
}
protocol authButtonChangeDelegate {
    func onAuthButtonChange(data: Bool)
}

class AuthNumberViewController: UIViewController {
    var emailAuthNumber = ""
    //Delegate
    var emailTextFieldDelegate: emailTextFieldChangeDelegate?
    var authButtonDelegate: authButtonChangeDelegate?
    
    //MARK: - Properties
    
    @IBOutlet weak var authNumberNotMatchLabel: UILabel!
    @IBOutlet weak var authTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okayButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        labelSetting()
    }
    
    func labelSetting() {
        authNumberNotMatchLabel.text = "인증번호가 일치하지 않습니다."
        authNumberNotMatchLabel.isHidden = true
    }
    
    //MARK: - Actions
    @IBAction func cancelTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func okTapButton(_ sender: Any) {
        CheckEmailRequest.email = UserDefaults.standard.value(forKey: "email") as? String ?? ""
        CheckEmailRequest.code = authTextField.text!
        CheckEmailDataManager().checkEmailPostData(self)
        print(UserDefaults.standard.value(forKey: "email") as? String ?? "")

        
        
        self.showIndicator()

        
    }
    
}
extension AuthNumberViewController {
    func authEmailResponse() {
        self.dismissIndicator()
        self.dismiss(animated: true, completion: nil)
        self.emailTextFieldDelegate?.onEmailTextFieldChange(data: false) //텍스트필드 비활
        self.authButtonDelegate?.onAuthButtonChange(data: false) //버튼 비활성화
    }
}

extension AuthNumberViewController {
    func authEmailFailResponse() {
        self.dismissIndicator()
        self.authNumberNotMatchLabel.isHidden = false
    }
}
