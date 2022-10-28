//
//  EmailAuthenticationViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/27.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class EmailAuthenticationViewController: UIViewController {
    //전달받을 email String
    var emailValue = ""
    let disposeBag = DisposeBag()
    var viewModel = EmailAuthenticationViewModel()
    // MARK: - PROPERTIES
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
    //확인된 이메일 라벨
    private let emailLabel = UILabel().then {
        $0.text = ""
        $0.textColor = HexColor.mainGreenColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 14)
    }
    
    //인증 안내 라벨
    private let guideLabel = UILabel().then {
        $0.text = "이메일로 인증번호가 전송되었습니다. \n확인 후 입력해주세요."
        $0.numberOfLines = 2
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 14)
    }
    
    //인증번호입력 TextField
    private let codeTextField = UITextField().then {
        $0.placeholder = "인증번호를 입력해주세요."
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HexColor.mainGreenColor.getHexColor().cgColor
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 4
        $0.backgroundColor = HexColor.backgroundColor.getHexColor()
    }
    //인증번호 불일치 안내 라벨
    private let warningAlertLabel = UILabel().then {
        $0.text = ""
        $0.textColor = HexColor.warning.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    //인증하기 버튼
    private let authenficationButton = UIButton().then {
        $0.setTitle("인증하기", for: .normal)
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
        authenficationButtonClicked()
    }
    private func authenficationNumberCheck() {
        codeTextField.rx.text
            .orEmpty
            .asDriver(onErrorJustReturn: "")
            .drive(viewModel.codeTextFieldSubject)
            .disposed(by: disposeBag)
        viewModel.codeFormCheck
            .subscribe(onNext: { value in
                if value {
                    self.authenficationButton.isEnabled = true
                    self.authenficationButton.alpha = 1.0
                }
                else {
                    self.authenficationButton.isEnabled = false
                    self.authenficationButton.alpha = 0.4
                }
            }).disposed(by: disposeBag)
    }
    private func authenficationButtonClicked() {
        authenficationButton.rx.tap
            .bind {
                self.showIndicator()
                self.viewModel.buttonTapped(self.emailValue, codeValue: self.codeTextField.text ?? "", completion: { result in
                    self.dismissIndicator()
                    switch result {
                    case 200: //비밀번호 일치
                        //화면전환
                        print("성공")
                        //이메일 데이터 저장
                        let userInfo = UserInfo.shared
                        userInfo.email = self.emailValue
                        let passwordCheckVC = PasswordCheckViewController()
                        passwordCheckVC.modalTransitionStyle = .crossDissolve
                        passwordCheckVC.modalPresentationStyle = .fullScreen
                        self.present(passwordCheckVC, animated: true)
                        
                    case 404: //비밀번호 불일치
                        self.warningAlertLabel.text = "인증번호가 일치하지 않아요."
                    default:
                        print("예외 오류")
                        self.warningAlertLabel.text = "인증번호 인증에 실패하였습니다."
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


    // MARK: - EXTENSIONS
extension EmailAuthenticationViewController {
    enum HexColor {
        case backgroundColor
        case titleColor
        case textColor
        case warning
        case mainGreenColor
        case whiteColor
        
        func getHexColor() -> UIColor {
            switch self {
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
        [backButton, mainTitleLabel, emailLabel, guideLabel, codeTextField, warningAlertLabel].forEach {
            view.addSubview($0)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
                .offset(3)
            make.leading.equalToSuperview().offset(7)
        }
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
            make.leading.equalToSuperview().offset(52)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom)
                .offset(18)
            make.leading.equalToSuperview().offset(52)
        }
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom)
                .offset(6)
            make.leading.equalToSuperview().offset(52)
        }
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(52)
            make.height.equalTo(40)
        }
        authenficationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-88)
        }
        view.backgroundColor = HexColor.backgroundColor.getHexColor()
        //버튼 초기 비활성화
        authenficationButton.isEnabled = false
        authenficationButton.alpha = 0.4
        //이메일 데이터 전달
        emailLabel.text = emailValue
        //text 행간 조절
        let paragraghStyle = NSMutableParagraphStyle()
        paragraghStyle.lineHeightMultiple = 1.2
        let infoLabelAttrString = NSMutableAttributedString(string: guideLabel.text ?? "")
        infoLabelAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraghStyle, range: NSMakeRange(0, infoLabelAttrString.length))
        guideLabel.attributedText = infoLabelAttrString
    }

}
