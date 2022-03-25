//
//  ChangePasswordViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/22.
//

import Foundation
import UIKit
import Combine

class ChagePasswordViewController : UIViewController {
    
    var viewModel : ChangePasswordChangeModel!
    //메모리 관리
    private var passwordSubscription = Set<AnyCancellable>()
    //MARK: - Properties
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var changePasswordLabel: UILabel!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var ruleLabel: UILabel!
    
    @IBOutlet weak var passwordCheckLabel: UILabel!
    
    @IBOutlet weak var passwordCheckValidLabel: UILabel!
    
    
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var okayButton: UIButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        viewSetting()
        buttonSetting()
        textFieldSetting()
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        
        viewModel = ChangePasswordChangeModel()
        
        //회원가입 버튼 활성화
        [passwordTextField, passwordCheckTextField].forEach({ $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
        passwordCheck()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        passwordValidLabel.text = ""
//        passwordCheckValidLabel.text = ""
        passwordCheckValidLabel.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordTextField.resignFirstResponder()
        self.passwordCheckTextField.resignFirstResponder()
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let passwordText = passwordTextField.text, !passwordText.isEmpty, passwordText.isValidPassword == true,
            let passwordCheckText = passwordCheckTextField.text, !passwordCheckText.isEmpty, passwordCheckText == passwordText
                
        else {
            // >>>
            self.okayButton.layer.opacity = 0.3
            self.okayButton.isEnabled = false
            self.okayButton.setTitleColor(UIColor(hex: 0xFDFDF9), for: .normal)
            return
        }
        self.okayButton.layer.opacity = 1
        self.okayButton.isEnabled = true
        self.okayButton.backgroundColor = UIColor(hex: 0x73BF90)
    }
    
    
    func textFieldSetting() {
        passwordTextField.layer.cornerRadius = 4
        passwordCheckTextField.layer.cornerRadius = 4
        passwordTextField.placeholder = "****"
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor(hex: 0x73BF90).cgColor
        passwordTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
        passwordCheckTextField.placeholder = "****"
        passwordCheckTextField.layer.borderWidth = 2
        passwordCheckTextField.layer.borderColor = UIColor(hex: 0x73BF90).cgColor
        passwordCheckTextField.backgroundColor = UIColor(hex: 0xFDFCF9)
        
    }
    
    
    func labelSetting() {
        ruleLabel.textColor = UIColor(hex: 0x878379)
        ruleLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        changePasswordLabel.text = "비밀번호 변경"
        changePasswordLabel.textColor = UIColor(hex: 0x4E4C49)
        changePasswordLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        passwordLabel.text = "비밀번호"
        passwordLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        passwordLabel.textColor = UIColor(hex: 0x5F5D59)
        passwordCheckLabel.text = "비밀번호 확인"
        passwordCheckLabel.textColor = UIColor(hex: 0x5F5D59)
        passwordCheckLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        
        
        
        
    }
    func buttonSetting() {
        okayButton.isEnabled = false
        okayButton.layer.opacity = 0.4
        okayButton.backgroundColor = UIColor(hex: 0x73BF90)
        okayButton.setTitle("변경하기", for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        okayButton.titleLabel?.font = .AppleSDGothic(.bold, size: 18)
        
    }
    
    @IBAction func passwordEditing(_ sender: UITextField) {
        if let passwordInput = sender.text {
            if passwordInput.count == 0 {
                return
            }
            
            if passwordInput.isValidPassword == true {
                passwordValidLabel.text = ""
                
                
            } else {
                passwordCheckValidLabel.isHidden = false
                passwordValidLabel.text = "작성 양식을 다시 한번 확인해주세요."
                passwordValidLabel.textColor = UIColor(hex: 0xE46962)
            }
        }
            
    }
    
    func passwordCheck() {
        passwordTextField
            .myTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordInput, on: viewModel)
            .store(in: &passwordSubscription)
        
        passwordCheckTextField
            .myTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordComfirmInput, on: viewModel)
            .store(in: &passwordSubscription)
        
        viewModel.isMatchPasswordInput
            .print()
            .receive(on: RunLoop.main)
            .assign(to: \.passwordIsValid, on: passwordCheckValidLabel)
            .store(in: &passwordSubscription)
    }
    
    @IBAction func passwordCheckEditing(_ sender: Any) {
    }
    
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func okayButtonTap(_ sender: Any) {
        self.showIndicator()
        
        ChangePasswordRequest.password = passwordTextField.text ?? ""
        ChangePasswordRequest.checkPassword = passwordCheckTextField.text ?? ""
        ChangePasswordDataManager().changePasswordPatchData(self)
    }
    
    
    //MARK: - Actions
}

    //MARK: - Extensions
extension ChagePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            passwordCheckTextField.becomeFirstResponder()
        }
        else if textField == passwordCheckTextField {
            passwordCheckTextField.resignFirstResponder()
        }
        return true
    }
}
extension UITextField {
    var passwordTextPublisher : AnyPublisher<String, Never> {
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
    var passwordIsValid: Bool {
        get {
            return text == ""
        }
        set {
            textColor = newValue ? .blue : UIColor(hex: 0xE46962)
            text = newValue ? "" : "일치하지 않아요!"


        }
    }
}
