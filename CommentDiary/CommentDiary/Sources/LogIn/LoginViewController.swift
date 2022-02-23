//
//  LoginViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/15.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var findPasswordButton: UIButton!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var idEmailLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        textFieldSetting()
        buttonSetting()
        labelSetting()

    }
    //키보드 제어
    override func viewWillAppear(_ animated: Bool) {
//        self.emailTextField.becomeFirstResponder()
//        self.passwordTextField.becomeFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    
    func textFieldSetting() {
        emailTextField.placeholder = "coda@coda.com"
        emailTextField.layer.borderWidth = 4
        emailTextField.layer.borderColor = UIColor.mainGreenColor.cgColor
        emailTextField.layer.cornerRadius = 4
        emailTextField.backgroundColor = UIColor.mainBackgroundColor
        passwordTextField.placeholder = "********"
        passwordTextField.layer.borderColor = UIColor.mainGreenColor.cgColor
        passwordTextField.layer.borderWidth = 4
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.backgroundColor = UIColor.mainBackgroundColor
    }
    
    func buttonSetting() {
        self.signinButton.setTitle("회원가입", for: .normal)
        self.signinButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        self.signinButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 14)
        self.findPasswordButton.setTitle("비밀번호 찾기", for: .normal)
        self.findPasswordButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        self.findPasswordButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 14)
        
        self.loginButton.backgroundColor = UIColor.mainGreenColor
        self.loginButton.setTitle("로그인", for: .normal)
        self.loginButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        self.loginButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeoEB00", size: 18)
        self.loginButton.layer.cornerRadius = self.loginButton.frame.height / 2 // 수정필요
        self.loginButton.layer.shadowColor = UIColor.black.cgColor
        self.loginButton.layer.shadowOpacity = 0.2
        self.loginButton.layer.shadowRadius = 10
        
    }
    
    func labelSetting() {
        self.idEmailLabel.text = "아이디(이메일)"
        self.idEmailLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        self.idEmailLabel.textColor = UIColor(hex: 0x5F5D59)
        self.passwordLabel.text = "비밀번호"
        self.passwordLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        self.passwordLabel.textColor = UIColor(hex: 0x5F5D59)
        self.questionLabel.text = "코다 계정이 없으신가요?"
        self.questionLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        self.questionLabel.textColor = UIColor(hex: 0x5F5D59)
    }

    
    //MARK: - Actions
    
    @IBAction func findPasswordTapButton(_ sender: Any) {
        let passwordSearchStoryboard = UIStoryboard(name: "PasswordSearch", bundle: nil).instantiateViewController(withIdentifier: "PasswordSearchViewController")
        passwordSearchStoryboard.modalTransitionStyle = .crossDissolve
        passwordSearchStoryboard.modalPresentationStyle = .fullScreen
        self.present(passwordSearchStoryboard, animated: true, completion: nil)
    }
    
    
    @IBAction func loginTapButton(_ sender: Any) {
//        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
//        changeRootViewController(mainTabBarController)
        
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.modalTransitionStyle = .crossDissolve
        self.present(mainTabBarController, animated: true, completion: nil)
    }
    @IBAction func signupTapButton(_ sender: Any) {
        let signupVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        signupVC.modalTransitionStyle = .crossDissolve
        signupVC.modalPresentationStyle = .fullScreen
        self.present(signupVC, animated: true, completion: nil)

        
    }
    
    
    
}


//    //MARK: - Extensions
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}


