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

extension SignUpTermsViewController {
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
        [backButton, mainTitleLabel, infoLabel, signUpButton].forEach {
            view.addSubview($0)
        }
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
