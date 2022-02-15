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
    var viewModel: SignUpPasswordViewModel!
    //메모리 관리
    private var passwordSubscription = Set<AnyCancellable>()
    
    //MARK: - Properties
    @IBOutlet weak var passwordCheckLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        viewModel = SignUpPasswordViewModel()
        signupButton.isEnabled = false
        textFieldSetting()
        passwordCheck()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordCheckLabel.text = ""
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
    
    //MARK: - Actions
    
    @IBAction func signUpTapButton(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
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
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////        if emailrange.location == 0 && range.length != 0 {
////            self.signupButton.isEnabled = false
////        } else {
////            self.signupButton.isEnabled = true
////        }
////        if emailTextField.text != "" && passwordTextField.text != "" && passwordConfirmTextField.text != "" {
////            self.signupButton.isEnabled = true
////        } else {
////            self.signupButton.isEnabled = false
////        }
//        emailTextField.text?.range.location
//        return true
//    }
    

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
