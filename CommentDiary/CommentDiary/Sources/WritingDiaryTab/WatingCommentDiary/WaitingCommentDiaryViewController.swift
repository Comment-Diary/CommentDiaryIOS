//
//  WaitingCommentDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/08/08.
//

import Foundation
import UIKit

class WaitingCommentDiaryViewController : UIViewController {
    
    //API 코멘트 일기 id 값
    var diaryInt = 0
    //pop or 루트뷰 토글
    var transToggle : Bool = false
    // MARK: - Properties
    
    @IBOutlet weak var diaryTItleSeparateView: UIView!
    @IBOutlet weak var diaryTitleLabel: UILabel!
    @IBOutlet weak var completeSendButton: UIButton!
    @IBOutlet weak var diaryContentLabel: UILabel!
    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var navigationTItleLabel: UILabel!
    @IBOutlet weak var navigationSeparateView: UIView!
    @IBOutlet weak var diaryScrollView: UIScrollView!
    @IBOutlet weak var diaryWholeView: UIView!
    @IBOutlet weak var diaryContentView: UIView!
    @IBOutlet weak var diaryTItleView: UIView!
    @IBOutlet weak var diaryInfoView: UIView!
    @IBOutlet weak var diaryInfoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    enum stringValue {
        case navigationTitle
        case completeSendButtonString
        case infoLabel
        
        func getLabelValue() -> String {
            switch self {
            case .navigationTitle:
                return "코멘트 받는 일기"
            case .completeSendButtonString:
                return "전송완료"
            case .infoLabel:
                return "'누군가의 코멘트'가 곧 도착합니다."
            }
        }
    }
    
    enum hexColor {
        case backgroundColor
        case navigationTitleLabelColor
        case navigationSeparateViewColor
        case completeSendButtonColor
        case dateLabelColor
        case titleLabelColor
        case contentLabelColor
        case titleSeparateColor
        case infoColor
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .navigationTitleLabelColor:
                return UIColor(hex: 0x4E4C49)
            case .navigationSeparateViewColor:
                return UIColor(hex: 0xF4F1EB)
            case .completeSendButtonColor:
                return UIColor(hex: 0x878379)
            case .dateLabelColor:
                return UIColor(hex: 0x5ABD80)
            case .titleLabelColor:
                return UIColor(hex: 0x5F5D59)
            case .contentLabelColor:
                return UIColor(hex: 0x5F5D59)
            case .titleSeparateColor:
                return UIColor(hex: 0xE2DFD7)
            case .infoColor:
                return UIColor(hex: 0x5ABD80)
            }
        }
    }
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        buttonSetting()
        viewSetting()
        spaceBetweenLines()
    }
    
    func labelSetting() {
        navigationTItleLabel.text = stringValue.navigationTitle.getLabelValue()
        diaryInfoLabel.text = stringValue.infoLabel.getLabelValue()
        diaryInfoLabel.textColor = hexColor.infoColor.getHexColor()
        navigationTItleLabel.textColor = hexColor.navigationTitleLabelColor.getHexColor()
        dateLabel.textColor = hexColor.dateLabelColor.getHexColor()
        diaryTitleLabel.textColor = hexColor.titleLabelColor.getHexColor()
        diaryContentLabel.textColor = hexColor.contentLabelColor.getHexColor()
        
        navigationTItleLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        diaryTitleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        diaryContentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        diaryInfoLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
        
        
        
    }
    func spaceBetweenLines() {
        let paragraghStyle = NSMutableParagraphStyle()
        paragraghStyle.lineHeightMultiple = 1.23
        let titleAttrString = NSMutableAttributedString(string: diaryTitleLabel.text ?? "")
        let contentAttrString = NSMutableAttributedString(string: diaryContentLabel.text ?? "")
        titleAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraghStyle, range: NSMakeRange(0, titleAttrString.length))
        contentAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraghStyle, range: NSMakeRange(0, contentAttrString.length))
        diaryTitleLabel.attributedText = titleAttrString
        diaryContentLabel.attributedText = contentAttrString
        
    }
    
    
    func buttonSetting() {
        completeSendButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        completeSendButton.setTitleColor(hexColor.completeSendButtonColor.getHexColor(), for: .normal)
        completeSendButton.setTitleColor(hexColor.completeSendButtonColor.getHexColor(), for: .highlighted)
        completeSendButton.setTitle(stringValue.completeSendButtonString.getLabelValue(), for: .normal)
        completeSendButton.setTitle(stringValue.completeSendButtonString.getLabelValue(), for: .highlighted)
        
    }
    func viewSetting() {
        view.backgroundColor = hexColor.backgroundColor.getHexColor()
        navigationBarView.backgroundColor = hexColor.backgroundColor.getHexColor()
        view.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryScrollView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryWholeView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryInfoView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryInfoView.layer.cornerRadius = 20
        diaryInfoView.layer.borderWidth = 2
        diaryInfoView.layer.borderColor = hexColor.infoColor.getHexColor().cgColor
        navigationSeparateView.backgroundColor = hexColor.navigationSeparateViewColor.getHexColor()
        diaryTItleSeparateView.backgroundColor = hexColor.titleSeparateColor.getHexColor()
    }
    
    // MARK: - Actions
    @IBAction func backButtonClicked(_ sender: Any) {
        if transToggle == true {
            navigationController?.popViewController(animated: true)
        }
        else if transToggle == false {
            let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
            self.changeRootViewController(mainTabBarController)
        }
//        navigationController?.popViewController(animated: true)
    }
    
}

    // MARK: - Extension
extension WaitingCommentDiaryViewController {
    func commentDiaryGet(_ response: DiaryCheckResopnse) {
        dateLabel.text = response.result.date
        diaryContentLabel.text = response.result.content
        diaryTitleLabel.text = response.result.title
    }
}
