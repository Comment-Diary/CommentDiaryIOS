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
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        textFieldSetting()
        buttonSetting()

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
        emailTextField.layer.borderColor = UIColor.greenColor.cgColor
        emailTextField.layer.cornerRadius = 4
        emailTextField.backgroundColor = UIColor.mainBackgroundColor
        passwordTextField.placeholder = "********"
        passwordTextField.layer.borderColor = UIColor.greenColor.cgColor
        passwordTextField.layer.borderWidth = 4
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.backgroundColor = UIColor.mainBackgroundColor
    }
    
    func buttonSetting() {
        self.loginButton.backgroundColor = UIColor.mainOrange
        self.loginButton.setTitle("로그인", for: .normal)
        self.loginButton.setTitleColor(UIColor.mainOrange, for: .normal)
        self.loginButton.layer.cornerRadius = 15 // 수정필요
        self.loginButton.layer.shadowColor = UIColor.black.cgColor
        self.loginButton.layer.shadowOpacity = 0.2
        self.loginButton.layer.shadowRadius = 10
        
    }

    
    //MARK: - Actions
    
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
    
    @IBAction func passwordSearchButton(_ sender: Any) {
    
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



