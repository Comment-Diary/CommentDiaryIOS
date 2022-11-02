//
//  SignUpTermsViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/09.
//

import SafariServices
import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class SignUpTermsViewController: UIViewController {
    let infoURL = NSURL(string: "https://www.notion.so/59a704f6702f4382b9398fa3b4a0d780")
    let usageURL = NSURL(string: "https://glittery-silk-987.notion.site/fb0c6c765a7a411c9362dc8d102c95e0")
    let disposeBag = DisposeBag()
    var viewModel = SignUpTermsViewModel()
    
    // MARK: - PROPERTIES
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "arrowLeft.png"), for: .normal)
        
    }
    private let mainTitleLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.extraBold, size: 30)
    }
    private let infoLabel = UILabel().then {
        $0.text = "서비스 이용에 꼭 필요한 약관입니다. \n정책 및 약관을 클릭하여 내용을 확인해주세요."
        $0.numberOfLines = 2
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 14)
    }
    private let signUpButton = UIButton().then {
        $0.setTitle("회원가입 하기", for: .normal)
        $0.setTitleColor(HexColor.whiteColor.getHexColor(), for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        $0.backgroundColor = HexColor.mainGreenColor.getHexColor()
        $0.layer.cornerRadius = 10
    }
    private let fullConsentLabel = UILabel().then {
        $0.text = "전체동의"
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.bold, size: 15)
    }
    private let fullConsentCheckImage = UIImageView().then {
        $0.image = UIImage(named: "checkImage")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let fullConsentButton = UIButton().then {
        $0.layer.borderColor = HexColor.fullConsentButtonColor.getHexColor().cgColor
        $0.layer.borderWidth = 1.5
        $0.layer.cornerRadius = 10
    }
    private let privacyCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "checkImage"), for: .normal)
        $0.setImage(UIImage(named: "checkImage"), for: .highlighted)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
    private let privacyButton = UIButton().then {
        $0.setTitle("[필수] 개인정보 처리 방침", for: .normal)
        $0.setTitleColor(HexColor.textColor.getHexColor(), for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 14)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.contentHorizontalAlignment = .leading
    }
    private let privacyButtonArrowImage = UIImageView().then {
        $0.image = UIImage(named: "arrowRight")
    }
    private let termsCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "checkImage"), for: .normal)
        $0.setImage(UIImage(named: "checkImage"), for: .highlighted)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    private let termsButton = UIButton().then {
        $0.setTitle("[필수] 서비스 이용 약관", for: .normal)
        $0.setTitleColor(HexColor.textColor.getHexColor(), for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 14)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.contentHorizontalAlignment = .leading
    }
    private let pushAlertAllowCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "checkImage"), for: .normal)
        $0.setImage(UIImage(named: "checkImage"), for: .highlighted)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    private let pushAlertAllowButton = UIButton().then {
        $0.setTitle("[선택] 앱 푸시 알림 수진", for: .normal)
        $0.setTitleColor(HexColor.textColor.getHexColor(), for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 14)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.contentHorizontalAlignment = .leading
        
    }
    private let termsButtonArrowImage = UIImageView().then {
        $0.image = UIImage(named: "arrowRight")
    }
    private let privacyStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 11
    }
    private let termsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 11
    }
    private let pushAlertAllowStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 11
    }
    private let pushAlertAllowInfoLabel = UILabel().then {
        $0.text = "동의 시 '코멘트'도착 알림을 받을 수 있어요!"
        $0.textColor = HexColor.pushAlertAllowInfoLabelColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        actions()
    }
    
    private func actions() {
        //뒤로가기 버튼 action
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        //회원가입 하기 버튼 action
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        //개인정보 처리 방침 버튼 action
        privacyButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        //서비스 이용 약간 버튼 action
        termsButton.addTarget(self, action: #selector(termsButtonTapped), for: .touchUpInside)
        
        
        
        //푸시 알림 수신 체크 버튼 action
        pushAlertAllowCheckButton.rx.tap
            .scan(false) { lastState, newState in !lastState}
            .bind(to: viewModel.pushAlertButtonSubject)
            .disposed(by: disposeBag)
        //푸시 알림 수신 버튼 action
//        pushAlertAllowButton.rx.tap
//            .scan(false) { lastState, newState in !lastState}
//            .bind(to: viewModel.pushAlertButtonSubject)
//            .disposed(by: disposeBag)
        //전체 동의 버튼 action
        fullConsentButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .bind(to: viewModel.fullConsentButtonSubject)
            .disposed(by: disposeBag)
        //개인정보 처리 체크 버튼 action
        privacyCheckButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .bind(to: viewModel.privacyButtonSubject)
            .disposed(by: disposeBag)
        //서비스 이용 약관 체크 버튼 action
        termsCheckButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .bind(to: viewModel.termsButtonSubject)
            .disposed(by: disposeBag)
        
        //전체동의 버튼 누를 때 event
        viewModel.fullConsentButtonSubject
            .subscribe(onNext: { value in
                if value {
                    self.viewModel.fullConsentButtonTrue()
                    self.fullConsentCheckImage.image = UIImage(named: "focusCheckImage")
                }
                else {
                    self.viewModel.fullConsentButtonFalse()
                    self.fullConsentCheckImage.image = UIImage(named: "checkImage")
                }
            }).disposed(by: disposeBag)
        //푸시 동의 버튼 event
        viewModel.pushAlertButtonSubject
            .subscribe(onNext: { value in
                if value {
                    self.pushAlertAllowCheckButton.setImage(UIImage(named: "focusCheckImage"), for: .normal)
                    self.viewModel.pushAlertReceptionValue = true
                    print(self.viewModel.pushAlertReceptionValue)
                }
                else {
                    self.pushAlertAllowCheckButton.setImage(UIImage(named: "checkImage"), for: .normal)
                    self.viewModel.pushAlertReceptionValue = false
                    print(self.viewModel.pushAlertReceptionValue)
                }
            }).disposed(by: disposeBag)
        //이용 약관 버튼 event
        viewModel.termsButtonSubject
            .subscribe(onNext: { value in
                if value {
                    self.termsCheckButton.setImage(UIImage(named: "focusCheckImage"), for: .normal)
                }
                else {
                    self.termsCheckButton.setImage(UIImage(named: "checkImage"), for: .normal)
                }
            }).disposed(by: disposeBag)
        //개인정보 처리방침 버튼 event
        viewModel.privacyButtonSubject
            .subscribe(onNext: { value in
                if value {
                    self.privacyCheckButton.setImage(UIImage(named: "focusCheckImage"), for: .normal)
                }
                else {
                    self.privacyCheckButton.setImage(UIImage(named: "checkImage"), for: .normal)
                }
            }).disposed(by: disposeBag)
        // 전체 동의 event
        viewModel.enableButton
            .subscribe(onNext: { value in
                if value {
                    self.signUpButton.isEnabled = true
                    self.signUpButton.alpha = 1.0
                }
                else {
                    self.signUpButton.isEnabled = false
                    self.signUpButton.alpha = 0.4
                }
            }).disposed(by: disposeBag)
        viewModel.fullConsentButton
            .subscribe(onNext: { value in
                if value {
                    self.fullConsentCheckImage.image = UIImage(named: "focusCheckImage")
                }
                else {
                    self.fullConsentCheckImage.image = UIImage(named: "checkImage")
                }
            }).disposed(by: disposeBag)
    }
    
    // MARK: - ACTIONS
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func signUpButtonTapped() {
        let emailCheckVC = EmailCheckViewController()
        emailCheckVC.modalTransitionStyle = .crossDissolve
        emailCheckVC.modalPresentationStyle = .fullScreen
        let userInfo = UserInfo.shared
        if viewModel.pushAlertReceptionValue == true {
            userInfo.pushAlertReception = "Y"
        }
        else {
            userInfo.pushAlertReception = "N"
        }
        present(emailCheckVC, animated: true, completion: nil)
    }
    @objc func privacyButtonTapped() {
        let webView : SFSafariViewController = SFSafariViewController(url: infoURL! as URL)
        present(webView, animated: true)
    }
    @objc func termsButtonTapped() {
        let notionView : SFSafariViewController = SFSafariViewController(url: usageURL! as URL)
        present(notionView, animated: true)
    }
}


// MARK: - EXTENSIONS
extension SignUpTermsViewController {
    enum HexColor {
        case backgroundColor
        case textColor
        case warning
        case mainGreenColor
        case whiteColor
        case fullConsentButtonColor
        case pushAlertAllowInfoLabelColor
        func getHexColor() -> UIColor {
            switch self {
            case .pushAlertAllowInfoLabelColor:
                return UIColor(hex: 0xB2AFAA)
            case .fullConsentButtonColor:
                return UIColor(hex: 0x878379)
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
        [backButton, mainTitleLabel, infoLabel, signUpButton, fullConsentLabel, fullConsentCheckImage, fullConsentButton, privacyStackView, termsStackView ,privacyButtonArrowImage, termsButtonArrowImage, pushAlertAllowStackView, pushAlertAllowInfoLabel].forEach {
            view.addSubview($0)
        }
        //개인정보 처리 방침 StackView
        [privacyCheckButton, privacyButton].forEach({
            privacyStackView.addArrangedSubview($0)
        })
        [termsCheckButton, termsButton].forEach({
            termsStackView.addArrangedSubview($0)
        })
        [pushAlertAllowCheckButton, pushAlertAllowButton].forEach({
            pushAlertAllowStackView.addArrangedSubview($0)
        })
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(3)
            make.leading.equalToSuperview().offset(7)
        }
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
            make.leading.equalToSuperview().offset(52)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(52)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-88)
        }
        fullConsentButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(48)
            make.top.equalTo(infoLabel.snp.bottom).offset(80)
        }
        fullConsentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fullConsentButton)
            make.leading.equalTo(fullConsentButton.snp.leading).offset(20)
        }
        fullConsentCheckImage.snp.makeConstraints { make in
            make.centerY.equalTo(fullConsentButton)
            make.trailing.equalTo(fullConsentButton.snp.trailing).offset(-20)
//            make.height.equalTo(20)
        }
        privacyStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(58)
            make.top.equalTo(fullConsentButton.snp.bottom).offset(16)
            make.height.equalTo(24)
        }
        termsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(58)
            make.top.equalTo(privacyStackView.snp.bottom).offset(15)
            make.height.equalTo(24)
        }
        pushAlertAllowStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(58)
            make.top.equalTo(termsStackView.snp.bottom).offset(16)
            make.height.equalTo(24)
        }
        privacyButton.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        privacyButtonArrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(privacyButton.snp.centerY)
            make.trailing.equalTo(privacyStackView.snp.trailing).offset(0)
        }
        termsButtonArrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(termsButton.snp.centerY)
            make.trailing.equalTo(privacyStackView.snp.trailing).offset(0)
        }
        pushAlertAllowInfoLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(pushAlertAllowButton.snp.leading).offset(0)
            make.top.equalTo(pushAlertAllowStackView.snp.bottom).offset(0)
        }
        view.backgroundColor = HexColor.backgroundColor.getHexColor()
        //text 행간 조절
        let paragraghStyle = NSMutableParagraphStyle()
        paragraghStyle.lineHeightMultiple = 1.2
        let infoLabelAttrString = NSMutableAttributedString(string: infoLabel.text ?? "")
        infoLabelAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraghStyle, range: NSMakeRange(0, infoLabelAttrString.length))
        infoLabel.attributedText = infoLabelAttrString
    }
}
