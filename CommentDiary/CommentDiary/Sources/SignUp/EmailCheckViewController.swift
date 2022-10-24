//
//  SignUpEmailViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/09.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class EmailCheckViewController : UIViewController {
    let disposeBag = DisposeBag()
    var viewModel = EmailCheckViewModel()
    // MARK: - PROPERTIES
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "arrowLeft.png"), for: .normal)
    }
    private let mainTitleLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.extraBold, size: 30)
    }
    private let emailLabel = UILabel().then {
        $0.text = "아이디(이메일)"
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
    private let warningAlertLabel = UILabel().then {
        $0.text = ""
        $0.textColor = HexColor.warning.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    private let sendCertificationNumberButton = UIButton().then {
        $0.setTitle("인증번호 보내기", for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        $0.setTitleColor(HexColor.whiteColor.getHexColor(), for: .normal)
        $0.backgroundColor = HexColor.mainGreenColor.getHexColor()
        $0.layer.cornerRadius = 10
    }
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        action()
        configureUI()
        emailFormCheck()
        sendCertificationNumberButtonClicked()
    }
    private func emailFormCheck() {
        emailTextField.rx.text
            .orEmpty
            .asDriver(onErrorJustReturn: "")
            .drive(viewModel.emailTextFieldSubject)
            .disposed(by: disposeBag)
        viewModel.idFormCheck
            .subscribe(onNext: { value in
                if value {
                    self.warningAlertLabel.text = ""
                    self.sendCertificationNumberButton.isEnabled = true
                    self.sendCertificationNumberButton.alpha = 1.0
                }
                else {
                    self.warningAlertLabel.text = "이메일 양식에 맞춰주세요."
                    self.warningAlertLabel.textColor = HexColor.warning.getHexColor()
                    self.sendCertificationNumberButton.isEnabled = false
                    self.sendCertificationNumberButton.alpha = 0.4
                }
            }).disposed(by: disposeBag)
    }
    private func sendCertificationNumberButtonClicked() {
        sendCertificationNumberButton.rx.tap
            .bind {
                self.showIndicator()
                self.viewModel.buttonTapped(self.emailTextField.text ?? "", completion: { result in
                    self.dismissIndicator()
                    switch result {
                    case 200:
                        //화면전환
                        print("성공")
                    case 409:
                        self.warningAlertLabel.text = "이미 이메일을 사용하는 유저가 있습니다."
                    default:
                        print("예외")
                    }
                })
            }
            .disposed(by: disposeBag)
    }
    private func action() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    // MARK: - ACTIONS
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension EmailCheckViewController {
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
        [backButton, mainTitleLabel, emailLabel, emailTextField, warningAlertLabel, sendCertificationNumberButton].forEach({
            view.addSubview($0)
        })
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(3)
            make.leading.equalToSuperview().offset(7)
        }
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
            make.leading.equalToSuperview().offset(52)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(52)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(52)
            make.height.equalTo(40)
        }
        warningAlertLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(52)
        }
        sendCertificationNumberButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-88)
        }
        
        view.backgroundColor = HexColor.backgroundColor.getHexColor()
        sendCertificationNumberButton.isEnabled = false
        sendCertificationNumberButton.alpha = 0.4
    }
}
