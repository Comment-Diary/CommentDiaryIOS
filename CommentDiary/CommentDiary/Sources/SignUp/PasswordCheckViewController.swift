//
//  PasswordCheckViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/27.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import RxKeyboard


class PasswordCheckViewController: UIViewController {
    // MARK: - PROPERTIES
    var viewModel = PasswordCheckViewModel()
    let disposeBag = DisposeBag()
    
    //뒤로가기 Button
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "arrowLeft.png"), for: .normal)
    }
    //회원가입 Label
    private let mainTitleLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = HexColor.titleColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.extraBold, size: 30)
    }
    //비밀번호 Label
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = HexColor.titleColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    //비밀번호 입력 TextField
    private let passwordTextField = UITextField().then {
        $0.placeholder = "******"
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HexColor.mainGreenColor.getHexColor().cgColor
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 4
        $0.backgroundColor = HexColor.backgroundColor.getHexColor()
    }
    //비밀번호 Form Alert Label
    private let passwordFormAlertLabel = UILabel().then {
        $0.text = "영문자, 숫자, 특수문자를 포함해 8~16자 작성해주세요."
        $0.textColor = HexColor.infoLabelColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    //비밀번호 Form Warning Label
    private let passwordFormWarningLabel = UILabel().then {
        $0.text = ""
        $0.textColor = HexColor.warning.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    //비밀번호 확인 Label
    private let passwordCheckLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.textColor = HexColor.titleColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    //비밀번호 확인 TextField
    private let passwordCheckTextField = UITextField().then {
        $0.placeholder = "******"
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HexColor.mainGreenColor.getHexColor().cgColor
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 4
        $0.backgroundColor = HexColor.backgroundColor.getHexColor()
    }
    //Check Password Warning Label
    private let passwordCheckWarningLabel = UILabel().then {
        $0.text = ""
        $0.textColor = HexColor.warning.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    //Terms Label
    private let codaTermsLabel = UILabel().then {
        $0.text = "회원가입 시 코다의 개인정보 취급 방침 및 이용 약관에 동의합니다."
        $0.textColor = HexColor.titleColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 11)
    }
    
    //Coda Button
    private let codaButton = UIButton().then {
        $0.setTitle("코다 시작하기", for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        $0.setTitleColor(HexColor.whiteColor.getHexColor(), for: .normal)
        $0.backgroundColor = HexColor.mainGreenColor.getHexColor()
        $0.layer.cornerRadius = 10
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        action()
        passwordFormCheck()
        passwordMatchCheck()
        codaButtonEnabledCheck()
        keyboardSetting()
    }
    // MARK: - 키보드 올라감과 동시에 버튼 올리기
    private func keyboardSetting() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { keyboardVisibleHeight in
                let height = keyboardVisibleHeight > 0 ? -keyboardVisibleHeight + self.view.safeAreaInsets.bottom - 16 : -88
                self.codaButton.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(height)
                }
                self.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
    
    private func passwordFormCheck() {
        passwordTextField.rx.text
            .orEmpty
            .asDriver(onErrorJustReturn: "")
            .drive(viewModel.passwordTextFieldSubject)
            .disposed(by: disposeBag)
        
        viewModel.passwordFormCheck
            .subscribe(onNext: { result in
                if result {
                    self.passwordFormWarningLabel.text = ""
                }
                else {
                    self.passwordFormWarningLabel.text = "양식에 맞춰주세요."
                }
            }).disposed(by: disposeBag)

    }
    private func passwordMatchCheck() {
        passwordCheckTextField.rx.text
            .orEmpty
            .asDriver(onErrorJustReturn: "")
            .drive(viewModel.passwordCheckTextFieldSubject)
            .disposed(by: disposeBag)
        
        viewModel.matchPasswordCheck.subscribe(onNext: { result in
            if result {
                self.passwordCheckWarningLabel.text = ""
            }
            else {
                self.passwordCheckWarningLabel.text = "일치하지 않습니다."
            }
        }).disposed(by: disposeBag)
    }
    private func codaButtonEnabledCheck() {
        viewModel.enabledButton.subscribe(onNext: { result in
            if result {
                self.codaButton.alpha = 1.0
                self.codaButton.isEnabled = true
            }
            else {
                self.codaButton.alpha = 0.4
                self.codaButton.isEnabled = false
            }
        }).disposed(by: disposeBag)
    }
    
    
    private func action() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        codaButton.addTarget(self, action: #selector(codaButtonTapped), for: .touchUpInside)
        
    }
    // MARK: - ACTIONS
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func codaButtonTapped() {
        let userInfo = UserInfo.shared
        userInfo.password = passwordTextField.text ?? ""
        userInfo.passwordCheck = passwordCheckTextField.text ?? ""
        print(userInfo.email ?? "", "이메일 값")
        print(userInfo.password ?? "", "비번 값")
        print(userInfo.passwordCheck ?? "", "비번2 값")
        print(userInfo.pushAlertReception ?? "", "푸시 값")
        
        viewModel.signUpButtonTapped { value in
            switch value {
            case 200:
                print("성공")
            case 409:
                print("이미 가입되어 있는 이메일")
            default:
                print("에외 오류")
            }
        }
    }
    
    
}


    // MARK: - EXTENSIONS
extension PasswordCheckViewController {
    enum HexColor {
        case infoLabelColor
        case backgroundColor
        case titleColor
        case textColor
        case warning
        case mainGreenColor
        case whiteColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .infoLabelColor:
                return UIColor(hex: 0x878379)
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .titleColor:
                return UIColor(hex: 0x5F5D59)
            case .textColor:
                return UIColor(hex: 0x4E4C49)
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
        [backButton, mainTitleLabel, passwordLabel, passwordTextField, passwordFormAlertLabel, passwordFormWarningLabel, passwordCheckLabel, passwordCheckTextField, codaTermsLabel, passwordCheckWarningLabel, codaButton].forEach {
            view.addSubview($0)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
                .offset(3)
            make.leading.equalToSuperview().offset(7)
        }
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(52)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
            
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(52)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(52)
            make.height.equalTo(40)
        }
        passwordFormAlertLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(52)
        }
        passwordFormWarningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordFormAlertLabel.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(52)
            make.height.equalTo(20)
        }
        passwordCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordFormWarningLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(52)
        }
        passwordCheckTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordCheckLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(52)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        passwordCheckWarningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordCheckTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(52)
            make.height.equalTo(20)
        }
        codaButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-88)
        }
        codaTermsLabel.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.bottom.equalTo(codaButton.snp.top).offset(-5)
            make.centerX.equalToSuperview()
            
        }
        
        view.backgroundColor = HexColor.backgroundColor.getHexColor()
        codaButton.alpha = 0.4
        codaButton.isEnabled = false
    }
}
