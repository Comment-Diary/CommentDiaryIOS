//
//  PasswordSearchViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/22.
//

import Foundation
import UIKit

class PasswordSearchViewController : UIViewController {
    //alert
    let successFindPasswordAlertService = SuccessFindPasswordSentAlertService()
    let failFindPasswordAlertService = FailFindPasswordAlertService()
    //API
    lazy var searchPasswordDataManager: SearchPasswordDataManager = SearchPasswordDataManager()
    
    
    //MARK: - Properties
    
    @IBOutlet weak var topStackLabel: UILabel!
    
    @IBOutlet weak var bottomStackLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var searchPasswordLabel: UILabel!
    
    @IBOutlet weak var emailInputTextField: UITextField!
    
    @IBOutlet weak var sendPasswordButton: UIButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendPasswordButton.clipsToBounds = true
        self.sendPasswordButton.layer.cornerRadius = sendPasswordButton.frame.height / 2
        
        emailInputTextField.delegate = self
        backgroundSetting()
        labelSetting()
        buttonSetting()
        textfieldSetting()
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    

    
    
    func backgroundSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    func labelSetting() {
        self.searchPasswordLabel.text = "비밀번호 찾기"
        self.searchPasswordLabel.font = UIFont.AppleSDGothic(.extraBold, size: 30)
        self.searchPasswordLabel.textColor = UIColor(hex: 0x5F5D59)
        
        self.topStackLabel.text = "코다 가입시 사용했던"
        self.topStackLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        self.topStackLabel.textColor = UIColor(hex: 0x5F5D59)
        self.bottomStackLabel.text = "아이디(이메일)을 입력해주세요"
        self.bottomStackLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        self.bottomStackLabel.textColor = UIColor(hex: 0x5F5D59)
    }
    func buttonSetting() {
        self.sendPasswordButton.isEnabled = false
        self.sendPasswordButton.layer.opacity = 0.3
        self.sendPasswordButton.setTitle("비밀번호 전송하기", for: .normal)
        self.sendPasswordButton.setTitleColor(UIColor(hex: 0xFDFDF9), for: .normal)
        self.sendPasswordButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        self.sendPasswordButton.backgroundColor = UIColor(hex: 0x73BF90)
        
        
    }
    
    func textfieldSetting() {
        self.emailInputTextField.placeholder = "coda@coda.com"
        self.emailInputTextField.layer.borderWidth = 2
        self.emailInputTextField.layer.cornerRadius = 4
        self.emailInputTextField.layer.borderColor = UIColor.mainGreenColor.cgColor
        self.emailInputTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    //MARK: - Actions
    @IBAction func sendPasswordTapButton(_ sender: Any) {
        //API 비밀번호 찾기
        let emailInputValue: String = emailInputTextField.text!
        searchPasswordDataManager.getPasswordData(emailValue: emailInputValue, self)
        self.showIndicator()

    }
    @IBAction func backButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    //비밀번호 버튼 활성화
    @IBAction func emaliValidTextField(_ sender: UITextField) {
        if let emailInput = sender.text {
            if emailInput.count == 0 {
                return
            }
            if emailInput.isValidEmail == true {
                self.sendPasswordButton.layer.opacity = 1
                self.sendPasswordButton.isEnabled = true
                self.sendPasswordButton.backgroundColor = UIColor(hex: 0x73BF90)
                self.sendPasswordButton.layer.borderColor = UIColor(hex: 0x73BF90).cgColor
            } else {
                self.sendPasswordButton.layer.opacity = 0.3
                self.sendPasswordButton.isEnabled = false
                self.sendPasswordButton.setTitleColor(UIColor(hex: 0xFDFDF9), for: .normal)
                self.sendPasswordButton.layer.borderColor = UIColor(hex: 0x73BF90).cgColor
            }
        }
    }

}

    //MARKL: - Extentions

extension PasswordSearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailInputTextField {
            emailInputTextField.resignFirstResponder()
        }
        return true
    }
}

extension PasswordSearchViewController {
    func findPasswordResponse() {
        self.dismissIndicator()
//        let successFindPasswordVC = successFindPasswordAlertService.alert()
//        present(successFindPasswordVC, animated: true)
        
        
//        let successFindPasswordVC = UIStoryboard(name: "SignUpCompletion", bundle: nil).instantiateViewController(withIdentifier: "SignUpCompletionViewController")
//        successFindPasswordVC.modalTransitionStyle = .crossDissolve
//        successFindPasswordVC.modalPresentationStyle = .fullScreen
//        self.present(successFindPasswordVC, animated: true)
//
//
//        let successFindPasswordVC = UIStoryboard(name: "SuccessFindPassword", bundle: nil).instantiateViewController(withIdentifier: "AuthNumberViewController") as! AuthNumberViewController
        
        let successFindPasswordVC = UIStoryboard(name: "SuccessFindPassword", bundle: nil).instantiateViewController(withIdentifier: "SuccessFindPasswordViewController") as! SuccessFindPasswordViewController
        self.present(successFindPasswordVC, animated: true)
    }
}

extension PasswordSearchViewController {
    func failFindPasswordResponse() {
        self.dismissIndicator()
        let failFindPasswordVC = UIStoryboard(name: "FailFIndPassword", bundle: nil).instantiateViewController(withIdentifier: "FailFindPasswordViewController") as! FailFindPasswordViewController
        self.present(failFindPasswordVC, animated: true)
    }
}
