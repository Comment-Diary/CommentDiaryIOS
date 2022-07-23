//
//  AloneDiaryDetailViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/07/14.
//

import Foundation
import UIKit

class AloneDiaryDetailViewController : UIViewController {
    enum hexColor {
        case backgroundColor
        case diaryTitleColor
        case diaryContentColor
        case dateLabelColor
        case titleSeparateColor
        case topSeparateColor
        case editButtonColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .diaryTitleColor:
                return UIColor(hex: 0x4E4C49)
            case .diaryContentColor:
                return UIColor(hex: 0x5F5D59)
            case .dateLabelColor:
                return UIColor(hex: 0xFFA665)
            case .titleSeparateColor:
                return UIColor(hex: 0xE2DFD7)
            case .topSeparateColor:
                return UIColor(hex: 0xF4F1EB)
            case .editButtonColor:
                return UIColor(hex: 0x5F5D59)
                
            }
        }
    }
    // MARK: - PROPERTIES
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var topSeparateView: UIView!
    @IBOutlet weak var scrollBackView: UIView!
    @IBOutlet weak var diaryScrollView: UIScrollView!
    @IBOutlet weak var scrollAllView: UIView!
    @IBOutlet weak var diaryTItleBackView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diaryTitleLabel: UILabel!
    @IBOutlet weak var titleSeparateView: UIView!
    @IBOutlet weak var diaryContentBackView: UIView!
    @IBOutlet weak var diaryContentLabel: UILabel!
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewColorSetting()
        labelColorSetting()
        buttonSetting()
    }
    
    func viewColorSetting() {
        topBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        scrollBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        scrollAllView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryContentBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryTItleBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        
        topSeparateView.backgroundColor = hexColor.topSeparateColor.getHexColor()
        titleSeparateView.backgroundColor = hexColor.titleSeparateColor.getHexColor()
    }
    func labelColorSetting() {
        diaryTitleLabel.textColor = hexColor.diaryTitleColor.getHexColor()
        diaryContentLabel.textColor = hexColor.diaryContentColor.getHexColor()
        
    }
    func buttonSetting() {
        editButton.setTitle("수정", for: .normal)
        editButton.setTitleColor(hexColor.editButtonColor.getHexColor(), for: .normal)
        editButton.setTitleColor(hexColor.editButtonColor.getHexColor(), for: .highlighted)
        editButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 15)
    }
    
    
    // MARK: - ACTIONS
    @IBAction func backButtonClicked(_ sender: Any) {
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
    }
    
}
    // MARK: - EXTENSIONS
