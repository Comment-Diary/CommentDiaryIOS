//
//  SignUpCompletionViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit

class SignUpCompletionViewController: UIViewController {
 
    //로그인을 위한 이메일, 비밀번호
    var loginEmail = UserDefaults.standard.value(forKey: "email")
    
    var loginPassword = UserDefaults.standard.value(forKey: "password")
    //MARK: - Properties
    
    @IBOutlet weak var recordStartButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetting()
  
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordStartButton.layer.cornerRadius = recordStartButton.frame.height / 2
    }
    
    func buttonSetting() {
        recordStartButton.backgroundColor = UIColor(hex: 0x73BF90)
        recordStartButton.setTitle("기록 시작하기", for: .normal)
        recordStartButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        recordStartButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
    }
    
    
    //MARK: - Actions
    
    @IBAction func recordStartTapButton(_ sender: Any) {
        //LoginAPI
        self.showIndicator()
        LoginRequest.email = loginEmail as! String
        LoginRequest.password = loginPassword as! String
        LoginAPIDataManager().loginPostData(self)
        print(loginEmail!, "이메일")
        print(loginPassword!, "비밀번호")
        

    }
    
}


    //MARK: - Extentions
//API 로그인 성공
extension SignUpCompletionViewController {
    func loginSuccessResponse() {
        self.dismissIndicator()
        //이메일, 비밀번호 userdefault 객체 삭제하기
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        
        //자동 로그인
//        UserDefaults.standard.set(true, forKey: "login_save")
        
        //화면전환
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
//        mainTabBarController.modalPresentationStyle = .fullScreen
//        mainTabBarController.modalTransitionStyle = .crossDissolve
        self.changeRootViewController(mainTabBarController)
        
        
    }
}
extension SignUpCompletionViewController {
    func loginFailResponse() {
        self.dismissIndicator()

    }
}

//UserDefaults.standard.set(emailTextField.text, forKey: "email")
//
////        var myJWToken : String = ""
////        myJWToken = UserDefaults.standard.value(forKey: "myJWT") as? String ?? ""

//이메일 비밀번호 userdefaults로 저장한거 불러와서 API 연동 후 홈 화면으로 이동 시키기



//UserDefaults.standard.set(emailTextField.text, forKey: "email")
//UserDefaults.standard.set(passwordTextField.text, forKey: "password")
//        UserDefaults.standard.removeObject(forKey: "helloWorldStringKey")
