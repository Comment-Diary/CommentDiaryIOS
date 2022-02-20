//
//  SignUpViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/15.
//

import Foundation
import UIKit
import Combine

class SignUpViewController: UIViewController {
    //alert
    let authNumberAlertService = AuthNumberAlertService()
    var viewModel: SignUpPasswordViewModel!
    //메모리 관리
    private var passwordSubscription = Set<AnyCancellable>()
    
    //MARK: - Properties
    @IBOutlet weak var passwordCheckLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var emailValidLabel: UILabel!
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    @IBOutlet weak var authNumberButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordCheckLabel.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        viewModel = SignUpPasswordViewModel()
        signupButton.isEnabled = false
        textFieldSetting()
        passwordCheck()
        buttonSetting()
        
        [emailTextField, passwordTextField, passwordConfirmTextField].forEach({ $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
        
        
//        passwordValidLabel.text = "대소문자, 숫자, 특수문자를 포함해 8~16자를 작성해주세요"
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let emailText = emailTextField.text, !emailText.isEmpty,
            let passwordText = passwordTextField.text, !passwordText.isEmpty,
            let passwordCheckText = passwordConfirmTextField.text, !passwordCheckText.isEmpty
        else {
            self.signupButton.isEnabled = false
            self.signupButton.layer.borderColor = UIColor(hex: 0xF7BC86).cgColor
            return
        }
        self.signupButton.isEnabled = true
        self.signupButton.backgroundColor = UIColor(hex: 0xF5CDA9)
        self.signupButton.layer.borderColor = UIColor(hex: 0xF5CDA9).cgColor
    }

    
    func textFieldSetting() {
        emailTextField.placeholder = "coda@coda.com"
        emailTextField.layer.borderWidth = 4
        emailTextField.layer.borderColor = UIColor(hex: 0x98C2A8).cgColor
        emailTextField.layer.cornerRadius = 4
        emailTextField.backgroundColor = UIColor(hex: 0xE5E5E5)
        passwordTextField.placeholder = "********"
        passwordTextField.layer.borderColor = UIColor(hex: 0x98C2A8).cgColor
        passwordTextField.layer.borderWidth = 4
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.backgroundColor = UIColor(hex: 0xE5E5E5)
        passwordConfirmTextField.placeholder = "********"
        passwordConfirmTextField.layer.borderColor = UIColor(hex: 0x98C2A8).cgColor
        passwordConfirmTextField.layer.borderWidth = 4
        passwordConfirmTextField.layer.cornerRadius = 4
        passwordConfirmTextField.backgroundColor = UIColor(hex: 0xE5E5E5)
    }
    
    func buttonSetting() {
        //인증 번호 전송 버튼 초기 비활성화
        self.authNumberButton.isEnabled = false
        self.signupButton.layer.borderWidth = 4
        self.signupButton.layer.borderColor = UIColor(hex: 0xF7BC86).cgColor
        self.signupButton.layer.cornerRadius = 15 //수정 필요
    }
    
    //MARK: - Actions
    
    @IBAction func signUpTapButton(_ sender: Any) {
        //비밀번호 텍스트 저장
        UserDefaults.standard.set(passwordTextField.text, forKey: "password")
        let signupCompletionVC = UIStoryboard(name: "SignUpCompletion", bundle: nil).instantiateViewController(withIdentifier: "SignUpCompletionViewController")
        signupCompletionVC.modalTransitionStyle = .crossDissolve
        signupCompletionVC.modalPresentationStyle = .fullScreen
        self.present(signupCompletionVC, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    @IBAction func AuthNumberButton(_ sender: Any) {
        EmailRequest.email = emailTextField.text ?? ""
        EmailDataManager().emailPostData()
        //이메일 텍스트 저장
        UserDefaults.standard.set(emailTextField.text, forKey: "email")
        
//        var myJWToken : String = ""
//        myJWToken = UserDefaults.standard.value(forKey: "myJWT") as? String ?? ""
        
        let alertVC = authNumberAlertService.alert()
        present(alertVC, animated: true)
    }
    
//    @IBAction func changingEmailText(_ sender: UITextField) {
//        if let emailInput = sender.text
//    }
    @IBAction func changingEmailText(_ sender: UITextField) {
        if let emailInput = sender.text {
            if emailInput.count == 0 {
                return
            }
            
            if emailInput.isValidEmail == true {
                emailValidLabel.text = "이메일 양식입니다."
                authNumberButton.isEnabled = true
                
            } else {
                emailValidLabel.text = "이메일 양식이 아닙니다."
                authNumberButton.isEnabled = false
                

            }
        }
    }
    
    
    @IBAction func changingPasswordText(_ sender: UITextField) {
        if let passwordInput = sender.text {
            if passwordInput.count == 0 {
                return
            }
            if passwordInput.isValidPassword == true {
                passwordValidLabel.text = "비밀번호 양식입니다."
            } else {
                passwordValidLabel.text = "비밀번호 양식이 아닙니다."
                passwordValidLabel.textColor = .red
            }
        }
    }
    
    
    
    
    
    func passwordCheck() {
        passwordTextField
            .myTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordInput, on: viewModel)
            .store(in: &passwordSubscription)

        passwordConfirmTextField
            .myTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordComfirmInput, on: viewModel)
            .store(in: &passwordSubscription)

        viewModel.isMatchPasswordInput
            .print()
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: passwordCheckLabel)
            .store(in: &passwordSubscription)
    }

    
}


    //MARK: - Extentions
extension SignUpViewController: UITextFieldDelegate {

}

extension UITextField {
    var myTextPublisher : AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
        //UITextField 가져옴
            .compactMap { $0.object as? UITextField }
        // String 가져옴
            .map { $0.text ?? "" }
        //매핑이 여러개 되어 있는 것을 하나로 퉁치기
            .print()
            .eraseToAnyPublisher()
    }
}


extension UILabel {
    var isValid: Bool {
        get {
            return text == ""
        }
        set {
            textColor = newValue ? .blue : .red
            text = newValue ? "일치합니다" : "일치하지 않아요."


        }
    }
}
