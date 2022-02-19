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
        textFieldSetting()
        buttonSetting()

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
//extension UIViewController {
//    // MARK: UIWindow의 rootViewController를 변경하여 화면전환
//    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
//
//
//        if let window = UIApplication.shared.windows.first {
//            window.rootViewController = viewControllerToPresent
//            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
//        } else {
//            viewControllerToPresent.modalPresentationStyle = .overFullScreen
//            self.present(viewControllerToPresent, animated: true, completion: nil)
//        }
//    }
//}
