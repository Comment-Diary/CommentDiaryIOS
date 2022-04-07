//
//  LoginViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/15.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    //로그인을 위한 이메일, 비밀번호
    var loginEmail = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    
    var loginPassword = UserDefaults.standard.value(forKey: "password") as? String ?? ""
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
    
    @IBOutlet weak var loginFailLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        textFieldSetting()
        buttonSetting()
        labelSetting()

        viewSetting()
    }
    //키보드 제어
    override func viewWillAppear(_ animated: Bool) {

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    
    func textFieldSetting() {
        emailTextField.placeholder = "coda@coda.com"
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.mainGreenColor.cgColor
        emailTextField.layer.cornerRadius = 4
        emailTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
        passwordTextField.placeholder = "********"
        passwordTextField.layer.borderColor = UIColor.mainGreenColor.cgColor
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    func buttonSetting() {
        self.signinButton.setTitle("회원가입", for: .normal)
        self.signinButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        self.signinButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        self.findPasswordButton.setTitle("비밀번호 찾기", for: .normal)
        self.findPasswordButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        self.findPasswordButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        
        self.loginButton.backgroundColor = UIColor(hex: 0x73BF90)
        self.loginButton.setTitle("로그인", for: .normal)
        self.loginButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        self.loginButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)


        
    }
    
    func labelSetting() {
        self.loginLabel.textColor = UIColor(hex: 0x5F5D59)
        self.loginLabel.font = UIFont.AppleSDGothic(.extraBold, size: 30)
        self.idEmailLabel.text = "아이디(이메일)"
        self.idEmailLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        self.idEmailLabel.textColor = UIColor(hex: 0x5F5D59)
        
        self.passwordLabel.text = "비밀번호"
        self.passwordLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        self.passwordLabel.textColor = UIColor(hex: 0x5F5D59)
        self.questionLabel.text = "코다 계정이 없으신가요?"
        self.questionLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        self.questionLabel.textColor = UIColor(hex: 0x5F5D59)
        self.questionLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        
        self.loginFailLabel.isHidden = true
        self.loginFailLabel.textColor = UIColor(hex: 0xE46962)
        self.loginFailLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
    }

    
    //MARK: - Actions
    
    @IBAction func findPasswordTapButton(_ sender: Any) {
//        self.showIndicator()
        let passwordSearchStoryboard = UIStoryboard(name: "PasswordSearch", bundle: nil).instantiateViewController(withIdentifier: "PasswordSearchViewController")
        passwordSearchStoryboard.modalTransitionStyle = .crossDissolve
        passwordSearchStoryboard.modalPresentationStyle = .fullScreen
        self.present(passwordSearchStoryboard, animated: true, completion: nil)
    }
    
    
    @IBAction func loginTapButton(_ sender: Any) {

        self.showIndicator()

        LoginRequest.email = emailTextField.text!
        LoginRequest.password = passwordTextField.text!
        //토큰tokenuserdefault 기존 삭제
//        UserDefaults.standard.removeObject(forKey: "AccessToken")
//        UserDefaults.standard.removeObject(forKey: "RefreshToken")
        LoginDataManager().loginPostData(self)
//        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
//        mainTabBarController.modalPresentationStyle = .fullScreen
//        mainTabBarController.modalTransitionStyle = .crossDissolve
//        self.present(mainTabBarController, animated: true, completion: nil)
        

        

    }
    @IBAction func signupTapButton(_ sender: Any) {
        let signupVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        signupVC.modalTransitionStyle = .crossDissolve
        signupVC.modalPresentationStyle = .fullScreen
        self.present(signupVC, animated: true, completion: nil)

        
    }
    
    
    
}


//    //MARK: - Extensions

//API 로그인 Login
//MARK: - Extentions
//API 로그인 성공
extension LoginViewController {
func loginSuccessResponse() {
    self.dismissIndicator()
    //이메일, 비밀번호 userdefault 객체 삭제하기
    UserDefaults.standard.removeObject(forKey: "email")
    UserDefaults.standard.removeObject(forKey: "password")
    
    //자동로그인
    UserDefaults.standard.set(true, forKey: "login_save")
    
    //화면전환
    let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
//    mainTabBarController.modalPresentationStyle = .fullScreen
//    mainTabBarController.modalTransitionStyle = .crossDissolve
//    self.present(mainTabBarController, animated: true, completion: nil)
    self.changeRootViewController(mainTabBarController)
    
}
}
extension LoginViewController {
func loginFailResponse() {
    self.dismissIndicator()
    self.loginFailLabel.text = "이메일 혹은 비밀번호가 올바르지 않습니다."
    self.loginFailLabel.isHidden = false

}
    func blockResponse() {
        dismissIndicator()
        self.loginFailLabel.text = "차단된 계정입니다."
        self.loginFailLabel.isHidden = false
    }
}




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



