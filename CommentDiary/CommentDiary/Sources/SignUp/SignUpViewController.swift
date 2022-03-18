//
//  SignUpViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/15.
//

//해야할일 2/22 레이아웃 처음부터 다시 확인하기


import Foundation
import UIKit
import Combine

class SignUpViewController: UIViewController, emailTextFieldChangeDelegate, authButtonChangeDelegate {
    //AuthNumberVC Delegate
    func onEmailTextFieldChange(data: Bool) {
        emailTextField.isUserInteractionEnabled = data
    }

    func onAuthButtonChange(data: Bool) {
        authNumberButton.isEnabled = data
    }
    
    //API
    lazy var emailDataManager: EmailDataManager = EmailDataManager()
    //alert
    let authNumberAlertService = AuthNumberAlertService()
    
    var viewModel: SignUpPasswordViewModel!
    //메모리 관리
    private var passwordSubscription = Set<AnyCancellable>()
    
    //MARK: - Properties
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordRuleLabel: UILabel!
    
    @IBOutlet weak var termsLabel: UILabel!
    
    @IBOutlet weak var passwordokeyLabel: UILabel!
    
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
        passwordCheckLabel.isHidden = true
        emailValidLabel.text = ""
        passwordValidLabel.text = ""
        emailTextFieldEnabled()
        authNumberSetting()
        
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signupButton.layer.masksToBounds = true
        self.signupButton.layer.masksToBounds = true
        self.authNumberButton.clipsToBounds = true
        self.signupButton.layer.cornerRadius = signupButton.frame.height / 2
        self.authNumberButton.layer.cornerRadius = authNumberButton.frame.height / 2
        
        
//        emailTextField.isUserInteractionEnabled = false 텍스트 필드 비활성화
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        viewModel = SignUpPasswordViewModel()
        textFieldSetting()
        passwordCheck()
        buttonSetting()
        viewSetting()
        authNumberDelegate()
        labelSetting()
        
        //회원가입 버튼 활성화
        [emailTextField, passwordTextField, passwordConfirmTextField].forEach({ $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
        
        

    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordConfirmTextField.resignFirstResponder()
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
            let passwordCheckText = passwordConfirmTextField.text, !passwordCheckText.isEmpty, passwordCheckText == passwordText
                
        else {
            self.signupButton.layer.opacity = 0.3
            self.signupButton.isEnabled = false
            self.signupButton.setTitleColor(UIColor(hex: 0xFDFDF9), for: .normal)
            return
        }
        self.signupButton.layer.opacity = 1
        self.signupButton.isEnabled = true
        self.signupButton.backgroundColor = UIColor(hex: 0x73BF90)
    }
    
    func authNumberDelegate() {
//        let authNumberVC = UIStoryboard(name: "AuthNumber", bundle: nil).instantiateViewController(withIdentifier: "AuthNumberViewController") as! AuthNumberViewController
//        authNumberVC.authButtonDelegate = self
//        authNumberVC.emailTextFieldDelegate = self
    }
    
    
    //이메일 인증 완료하면 이메일 textfield 비활성화
    func emailTextFieldEnabled() {
        if CheckEmailSuccessReponse.ResponseState == true {
            emailTextField.isUserInteractionEnabled = false
            authNumberButton.isEnabled = false
        } else {
            emailTextField.isUserInteractionEnabled = true
            authNumberButton.isEnabled = true
        }
    }
    
    func labelSetting() {
        signUpLabel.font = UIFont.AppleSDGothic(.extraBold, size: 30)
        signUpLabel.textColor = UIColor(hex: 0x5F5D59)
        emailLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        emailLabel.textColor = UIColor(hex: 0x5F5D59)
        passwordLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        passwordLabel.textColor = UIColor(hex: 0x5F5D59)
        passwordRuleLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        passwordRuleLabel.textColor = UIColor(hex: 0x878379)
        passwordokeyLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        passwordokeyLabel.textColor = UIColor(hex: 0x5F5D59)

        termsLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        
        
        emailValidLabel.textColor = UIColor(hex: 0xE46962)
        emailValidLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        
        passwordValidLabel.textColor = UIColor(hex: 0xE46962)
        passwordValidLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
    }

    
    func textFieldSetting() {
        emailTextField.placeholder = "coda@coda.com"
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor(hex: 0x98C2A8).cgColor
        emailTextField.layer.cornerRadius = 4
        emailTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
        passwordTextField.placeholder = "********"
        passwordTextField.layer.borderColor = UIColor(hex: 0x98C2A8).cgColor
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
        passwordConfirmTextField.placeholder = "********"
        passwordConfirmTextField.layer.borderColor = UIColor(hex: 0x98C2A8).cgColor
        passwordConfirmTextField.layer.borderWidth = 2
        passwordConfirmTextField.layer.cornerRadius = 4
        passwordConfirmTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    func buttonSetting() {
        //인증 번호 전송 버튼 초기 비활성화
        signupButton.isEnabled = false
        self.signupButton.setTitleColor(UIColor(hex: 0xFDFDF9), for: .normal)
        self.signupButton.layer.opacity = 0.3
        self.signupButton.backgroundColor = UIColor(hex: 0x73BF90)
        
        self.authNumberButton.setTitleColor(UIColor(hex: 0xFDFDF9), for: .normal)
        self.authNumberButton.backgroundColor = UIColor(hex: 0x73BF90)
        self.authNumberButton.setTitle("인증번호 보내기", for: .normal)
        self.authNumberButton.titleLabel?.font = .AppleSDGothic(.bold, size: 13)
        
        
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    func authNumberSetting() {
        authNumberButton.isEnabled = false
    }
    
    //MARK: - Actions
    
    @IBAction func signUpTapButton(_ sender: Any) {
        //SignUpAPI
        self.showIndicator()
        SignUpRequest.email = emailTextField.text!
        SignUpRequest.password = passwordTextField.text!
        SignUpRequest.checkPassword = passwordConfirmTextField.text!
        SignUpDataManager().signUpPostData(self)
        


    }
    
    @IBAction func backButton(_ sender: Any) {

        dismiss(animated: true)
    }
    
    @IBAction func AuthNumberButton(_ sender: Any) {

        //API 인증번호 발급
        let emailQueryValue: String = emailTextField.text!
        emailDataManager.getEmailData(emailValue: emailQueryValue, self)
        self.showIndicator()

        
    }
    

    @IBAction func changingEmailText(_ sender: UITextField) {
        if let emailInput = sender.text {
            if emailInput.count == 0 {
                return
            }
            
            if emailInput.isValidEmail == true {
                emailValidLabel.text = ""
                authNumberButton.isEnabled = true
                
            } else {
                emailValidLabel.text = "이메일 양식에 맞춰주세요."
                emailValidLabel.textColor = UIColor(hex: 0xE46962)
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
                passwordValidLabel.text = ""
            } else {
                passwordCheckLabel.isHidden = false
                passwordValidLabel.text = "작성 양식을 다시 한번 확인해주세요."
                passwordValidLabel.textColor = UIColor(hex: 0xE46962)
            }
        }
    }
    
    
    @IBAction func changingPasswordValidText(_ sender: UITextField) {
        
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
        }
        else if textField == passwordTextField {
            passwordConfirmTextField.becomeFirstResponder()
        }
        else if textField == passwordConfirmTextField {
            passwordConfirmTextField.resignFirstResponder()
        }
        return true
    }
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
            textColor = newValue ? .blue : UIColor(hex: 0xE46962)
            text = newValue ? "" : "일치하지 않아요."


        }
    }
}


//API 이메일 인증
extension SignUpViewController {
    func authEmailResponse() {
        self.dismissIndicator()
        let authNumberVC = UIStoryboard(name: "AuthNumber", bundle: nil).instantiateViewController(withIdentifier: "AuthNumberViewController") as! AuthNumberViewController
        authNumberVC.authButtonDelegate = self
        authNumberVC.emailTextFieldDelegate = self
        authNumberVC.emailString = self.emailTextField.text!
        self.present(authNumberVC, animated: true)
        
    }
}
extension SignUpViewController {
    func authEmailFailResponse() {
        self.dismissIndicator()
        self.presentBottomAlert(message: "이미 가입되어 있는 이메일입니다.")
        
    }
}

//API 회원가입 성공
extension SignUpViewController {
    func signUpResponse() {
        self.dismissIndicator()
        //이메일, 비밀번호 저장
        UserDefaults.standard.set(emailTextField.text!, forKey: "email")
        UserDefaults.standard.set(self.passwordTextField.text!, forKey: "password")
        //화면 이동
        let signUpCompletionVC = UIStoryboard(name: "SignUpCompletion", bundle: nil).instantiateViewController(withIdentifier: "SignUpCompletionViewController")
        signUpCompletionVC.modalTransitionStyle = .crossDissolve
        signUpCompletionVC.modalPresentationStyle = .fullScreen
        self.present(signUpCompletionVC, animated: true)
    }
}

//API 회원가입 실패
//필요하면 만들기




//                self.present(signupCompletionVC, animated: true, completion: nil)
//            } else { //API 실패시
//                //실패 알람띄우기
//
//            }
//        })
//        self.showIndicator()
//        DispatchQueue.global().sync {
//            <#code#>
//        }
        
