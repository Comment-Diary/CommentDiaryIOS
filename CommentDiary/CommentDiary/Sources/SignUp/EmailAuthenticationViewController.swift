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
    var viewModel = EmailAuthenticationViewModel()
    // MARK: - PROPERTIES
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
}

    // MARK: - EXTENSIONS
extension EmailAuthenticationViewController {
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

}
