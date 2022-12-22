//
//  LoginCaseViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/12/23.
//

import UIKit
import Then
import SnapKit


class LoginCaseViewController : UIViewController {
    // MARK: - PROPERTIES
    private let mainTitleLabel = UILabel().then {
        $0.text = "코다 \n시작하기"
        $0.numberOfLines = 2
        $0.textColor = HexColor.mainTitleColor.getHexColor()
        $0.font =  UIFont.AppleSDGothic(.extraBold, size: 30)
    }
    private let kakaoButton = UIButton().then {
        $0.setImage(UIImage(named: "kakao"), for: .normal)
    }
    private let emailButton = UIButton().then {
        $0.setTitle("이메일로 시작하기", for: .normal)
        $0.setTitleColor(HexColor.emailButtonColor.getHexColor(), for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HexColor.emailButtonColor.getHexColor().cgColor
        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 15)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        actions()
    }
    private func actions() {
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        kakaoButton.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
    }
    
    
    
    // MARK: - ACTIONS
    @objc func emailButtonTapped() {
        let emailLoginVC = EmailLoginViewController()
        emailLoginVC.modalTransitionStyle = .crossDissolve
        emailLoginVC.modalPresentationStyle = .fullScreen
        present(emailLoginVC, animated: true, completion: nil)
    }
    @objc func kakaoButtonTapped() {
        let signUpTermsVC = SignUpTermsViewController()
        signUpTermsVC.viewModel.signUpCase = "kakao"
        signUpTermsVC.modalTransitionStyle = .crossDissolve
        signUpTermsVC.modalPresentationStyle = .fullScreen
        present(signUpTermsVC, animated: true, completion: nil)
    }
}







extension LoginCaseViewController {
    private func configureUI() {
        [mainTitleLabel, emailButton, kakaoButton].forEach({
            view.addSubview($0)
        })
        view.backgroundColor = HexColor.backgroundColor.getHexColor()
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(38)
            make.leading.equalToSuperview().offset(52)
        }
        emailButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-88)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
        }
        kakaoButton.snp.makeConstraints { make in
            make.bottom.equalTo(emailButton.snp.top).offset(-8)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
        }
        //text 행간 조절
        let paragraghStyle = NSMutableParagraphStyle()
        paragraghStyle.lineHeightMultiple = 0.93
        let infoLabelAttrString = NSMutableAttributedString(string: mainTitleLabel.text ?? "")
        infoLabelAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraghStyle, range: NSMakeRange(0, infoLabelAttrString.length))
        mainTitleLabel.attributedText = infoLabelAttrString
    }
    
    enum HexColor {
        case backgroundColor
        case mainTitleColor
        case emailButtonColor
  
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .mainTitleColor:
                return UIColor(hex: 0x5F5D59)
            case .emailButtonColor:
                return UIColor(hex: 0x4E4C49)

            }
        }
    }
}
