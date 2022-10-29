//
//  SignUpTermsViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/09.
//

import Foundation
import UIKit
import Then
import SnapKit
class SignUpTermsViewController: UIViewController {
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
        //todo
    }
    private let privacyStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 11
    }
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        actions()
    }
    
    private func actions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - ACTIONS
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func signUpButtonTapped() {
        let emailCheckVC = EmailCheckViewController()
        emailCheckVC.modalTransitionStyle = .crossDissolve
        emailCheckVC.modalPresentationStyle = .fullScreen
        present(emailCheckVC, animated: true, completion: nil)
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
        func getHexColor() -> UIColor {
            switch self {
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
        [backButton, mainTitleLabel, infoLabel, signUpButton, fullConsentLabel, fullConsentCheckImage, fullConsentButton, privacyStackView, privacyButtonArrowImage].forEach {
            view.addSubview($0)
        }
        //개인정보 처리 방침 StackView
        [privacyCheckButton, privacyButton].forEach({
            privacyStackView.addArrangedSubview($0)
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
        privacyButton.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        privacyButtonArrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(privacyButton.snp.centerY)
            make.trailing.equalTo(privacyStackView.snp.trailing).offset(0)
        }
        view.backgroundColor = HexColor.backgroundColor.getHexColor()
        //버튼 초기 비활성화
//        signUpButton.alpha = 0.4
//        signUpButton.isEnabled = false
        //text 행간 조절
        let paragraghStyle = NSMutableParagraphStyle()
        paragraghStyle.lineHeightMultiple = 1.2
        let infoLabelAttrString = NSMutableAttributedString(string: infoLabel.text ?? "")
        infoLabelAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraghStyle, range: NSMakeRange(0, infoLabelAttrString.length))
        infoLabel.attributedText = infoLabelAttrString
    }
}
