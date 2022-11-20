//
//  EmailLoginViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/09/22.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import RxKeyboard

class EmailLoginViewController: UIViewController {
    var viewModel = EmailLoginViewModel()
    let disposeBag = DisposeBag()
    // MARK: - PROPERTIES
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "arrowLeft.png"), for: .normal)
    }
    private let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.extraBold, size: 30)
    }
    private let emailLabel = UILabel().then {
        $0.text = "아이디(이메일)"
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    private let emailTextField = UITextField().then {
        $0.placeholder = "coda@coda.com"
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HexColor.mainGreenColor.getHexColor().cgColor
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 4
        $0.backgroundColor = HexColor.backgroundColor.getHexColor()
        
    }
    private let passwordTextField = UITextField().then {
        $0.placeholder = "****"
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HexColor.mainGreenColor.getHexColor().cgColor
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 4
        $0.backgroundColor = HexColor.backgroundColor.getHexColor()
    }
    private let warningAlertLabel = UILabel().then {
        $0.text = "이메일 혹은 비밀번호가 올바르지 않습니다."
        $0.textColor = HexColor.warning.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    private let makeingAccountLabel = UILabel().then {
        $0.text = "코다 계정이 없으신가요?"
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 14)
    }
    private let signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(HexColor.textColor.getHexColor(), for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    private let searchPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        $0.setTitleColor(HexColor.textColor.getHexColor(), for: .normal)
    }
    private let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(HexColor.whiteColor.getHexColor(), for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        $0.setTitleColor(HexColor.whiteColor.getHexColor(), for: .normal)
        $0.backgroundColor = HexColor.mainGreenColor.getHexColor()
        $0.layer.cornerRadius = 10
    }
    private let signUpStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 16
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        actions()
        keyboardSetting()
    }
    private func keyboardSetting() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { keyboardVisibleHeight in
                let height = keyboardVisibleHeight > 0 ? -keyboardVisibleHeight + self.view.safeAreaInsets.bottom - 16 + 28 + 48 : -12
                self.loginButton.snp.updateConstraints { make in
                    make.bottom.equalTo(self.signUpStackView.snp.top).offset(height)
                }
                self.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }

    private func actions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        searchPasswordButton.addTarget(self, action: #selector(searchPasswordButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        //로그인 버튼
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    private func formCheck() {
        emailTextField.rx.text
            .orEmpty
            .asDriver(onErrorJustReturn: "")
            .drive(viewModel.emailTextFieldSubject)
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .orEmpty
            .asDriver(onErrorJustReturn: "")
            .drive(viewModel.passwordTextFieldSubject)
            .disposed(by: disposeBag)
        
        // MARK: - 버튼 활성화 여부
        viewModel.enabledButton.subscribe(onNext: { result in
            if result {
                self.loginButton.alpha = 1.0
                self.loginButton.isEnabled = true
            }
            else {
                self.loginButton.alpha = 0.4
                self.loginButton.isEnabled = false
            }
        })
        .disposed(by: disposeBag)
    }
 
    
    
    // MARK: - ACTIONS
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func signUpButtonTapped() {
        let signUpTermsVC = SignUpTermsViewController()
        signUpTermsVC.viewModel.signUpCase = "email"
        signUpTermsVC.modalTransitionStyle = .crossDissolve
        signUpTermsVC.modalPresentationStyle = .fullScreen
        present(signUpTermsVC, animated: true, completion: nil)
    }
    @objc func searchPasswordButtonTapped() {
        let searchPasswordVC = SearchPasswordViewController()
        searchPasswordVC.modalTransitionStyle = .crossDissolve
        searchPasswordVC.modalPresentationStyle = .fullScreen
        present(searchPasswordVC, animated: true, completion: nil)
    }
    @objc func loginButtonTapped() {
        print("로그인 버튼 클릭")
    }
    
}


    // MARK: - EXTENSIONS
extension EmailLoginViewController {
    enum HexColor {
        case backgroundColor
        case textColor
        case warning
        case mainGreenColor
        case whiteColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .textColor:
                return UIColor(hex: 0x5F5D59)
            case .warning:
                return UIColor(hex: 0xF83C32)
            case .mainGreenColor:
                return UIColor(hex: 0x5ABD80)
            case .whiteColor:
                return UIColor(hex: 0xFDFCF9)
            }
        }
    }
    
    private func configureUI() {
       
        [backButton, loginLabel, emailLabel, passwordLabel, emailTextField, passwordTextField, warningAlertLabel, searchPasswordButton, signUpStackView, loginButton].forEach({
            view.addSubview($0)
        })
        
        [makeingAccountLabel, signUpButton].forEach({
            signUpStackView.addArrangedSubview($0)
        })
        
        searchPasswordButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-26)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        
        signUpStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
            make.bottom.equalTo(searchPasswordButton.snp.top).offset(-6)
        }
        loginButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.bottom.equalTo(signUpStackView.snp.top).offset(-12)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(3)
            make.leading.equalToSuperview().offset(7)
        }
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(73)
            make.leading.equalToSuperview().offset(48)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(52)
        }
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(52)
            make.height.equalTo(40)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(52)
        }
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(52)
            make.height.equalTo(40)
        }
        warningAlertLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(4)
        }
        
        view.backgroundColor = HexColor.backgroundColor.getHexColor()
        loginButton.alpha = 0.4
        loginButton.isEnabled = false
    }
    
}
