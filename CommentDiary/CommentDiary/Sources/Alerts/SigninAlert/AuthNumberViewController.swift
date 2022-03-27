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
    var emailString = ""
    //Delegate
    var emailTextFieldDelegate: emailTextFieldChangeDelegate?
    var authButtonDelegate: authButtonChangeDelegate?
    
    //MARK: - Properties
    
    @IBOutlet weak var authNumberNotMatchLabel: UILabel!
    @IBOutlet weak var authTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okayButton: UIButton!
    
    
    
    @IBOutlet weak var topFirstLabel: UILabel!
    
    @IBOutlet weak var topSecondLabel: UILabel!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var alertView: UIView!
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        labelSetting()
        viewSetting()
        buttonSetting()
        textFieldSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        alertView.layer.cornerRadius = 10
    }
    
    
    func labelSetting() {
        authNumberNotMatchLabel.text = "인증번호가 일치하지 않습니다."
        authNumberNotMatchLabel.isHidden = true
        authNumberNotMatchLabel.textColor = UIColor(hex: 0xE46962)
        authNumberNotMatchLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        
        topFirstLabel.text = "이메일로 인증번호가 전송되었습니다."
        topSecondLabel.text = "확인 후 입력해주세요."
        topFirstLabel.textColor = UIColor(hex: 0x5F5D59)
        topFirstLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        topSecondLabel.textColor = UIColor(hex: 0x5F5D59)
        topSecondLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        
    }
    func textFieldSetting() {
        authTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
        authTextField.layer.borderColor = UIColor(hex: 0x73BF90).cgColor
        authTextField.layer.borderWidth = 2
        authTextField.layer.cornerRadius = 4
    }
    
    
    
    func viewSetting() {
        alertView.backgroundColor = UIColor(hex: 0xFDFCF9)
        alertView.layer.cornerRadius = 10
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius =  10
        cancelButton.layer.maskedCorners = .layerMinXMaxYCorner
        okayButton.layer.cornerRadius = 10
        okayButton.layer.maskedCorners = .layerMaxXMaxYCorner
        

    }
    
    func buttonSetting() {
        cancelButton.backgroundColor = UIColor(hex: 0xFDFCF9)
        okayButton.backgroundColor = UIColor(hex: 0xFDFCF9)
        cancelButton.layer.borderWidth = 1
        okayButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
        okayButton.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = .AppleSDGothic(.bold, size: 14)
        okayButton.titleLabel?.font = .AppleSDGothic(.bold, size: 14)
        cancelButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        
        
    }
    
    //MARK: - Actions
    @IBAction func cancelTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func okTapButton(_ sender: Any) {
//        CheckEmailRequest.email = UserDefaults.standard.value(forKey: "email") as? String ?? ""
//        CheckEmailRequest.code = authTextField.text!
        
        
        
        CheckEmailDataManager().checkEmailPostData(self, email: emailString, code: authTextField.text!)
        
        

        
        
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
