//
//  SignUpCompletionViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit

class SignUpCompletionViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var recordStartButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Actions
    
    @IBAction func recordStartTapButton(_ sender: Any) {
//        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
//        loginVC.modalTransitionStyle = .crossDissolve
//        loginVC.modalPresentationStyle = .fullScreen
//        self.present(loginVC, animated: true, completion: nil)
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.modalTransitionStyle = .crossDissolve
        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
}


    //MARK: - Extentions


//UserDefaults.standard.set(emailTextField.text, forKey: "email")
//
////        var myJWToken : String = ""
////        myJWToken = UserDefaults.standard.value(forKey: "myJWT") as? String ?? ""

//이메일 비밀번호 userdefaults로 저장한거 불러와서 API 연동 후 홈 화면으로 이동 시키기
