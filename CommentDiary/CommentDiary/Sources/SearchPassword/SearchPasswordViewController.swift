//
//  SearchPasswordViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/09/25.
//

import Foundation
import UIKit
import Then
import SnapKit

class SearchPasswordViewController : UIViewController {
    // MARK: - PROPERTIES
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "arrowLeft.png"), for: .normal)
    }
    private let mainTitleLabel = UILabel().then {
        $0.text = "비밀번호 찾기"
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font = UIFont.AppleSDGothic(.extraBold, size: 30)
    }
    private let infoLabel = UILabel().then {
        $0.text = "코다 가입시 사용했던 \n아이디(이메일)을 입력해주세요"
        $0.numberOfLines = 2
        $0.textColor = HexColor.textColor.getHexColor()
        $0.font =  UIFont.AppleSDGothic(.medium, size: 14)
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
        $0.text = "이메일 양식에 맞춰주세요"
        $0.textColor = HexColor.warning.getHexColor()
        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    private let sendPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 전송하기", for: .normal)
        $0.setTitleColor(HexColor.whiteColor.getHexColor(), for: .normal)
        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        $0.setTitleColor(HexColor.whiteColor.getHexColor(), for: .normal)
        $0.backgroundColor = HexColor.mainGreenColor.getHexColor()
        $0.layer.cornerRadius = 10
    }
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // MARK: - ACTIONS
}

extension SearchPasswordViewController {
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
        [backButton, mainTitleLabel, infoLabel, emailTextField, warningAlertLabel, sendPasswordButton].forEach {
            view.addSubview($0)
        }
        
    }
}
