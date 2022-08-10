//
//  OverTImeCommentDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/08/08.
//

import Foundation
import UIKit

class OverTImeCommentDiaryViewController : UIViewController {
    // MARK: - Properties
    //일기 제목
    var diaryTItle: String = ""
    //일기 날짜
    var diaryDate: String = ""
    //일기 내용
    var diaryContent: String = ""
    //일기 id
    var diaryId: Int = 0
    @IBOutlet weak var navigationSeparateView: UIView!
    @IBOutlet weak var diaryScrollContentView: UIView!
    @IBOutlet weak var diaryScrollView: UIScrollView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var diaryTitleView: UIView!
    @IBOutlet weak var diaryInfoLabel: UILabel!
    @IBOutlet weak var diaryContentLabel: UILabel!
    @IBOutlet weak var diaryTitleSeparateView: UIView!
    @IBOutlet weak var diaryTitleLabel: UILabel!
    @IBOutlet weak var diaryDateLabel: UILabel!
    @IBOutlet weak var diaryInfoView: UIView!
    @IBOutlet weak var diaryContentView: UIView!
    @IBOutlet weak var navigationBarView: UIView!
    enum stringValue {
        case navigationTitle
        case infoLabel
        
        func getLabelValue() -> String {
            switch self {
            case .navigationTitle:
                return "코멘트 받는 일기"
            case .infoLabel:
                return "※ 일기 전송 시간이 지났어요. ※"
            }
        }
    }
    enum hexColor {
        case backgroundColor
        case navigationSeparateViewColor
        case navigationTitleColor
        case diaryDateLabelColor
        case diaryTitleColor
        case diaryContentColor
        case diaryTitleSeparatViewColor
        case infoLabelColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .navigationTitleColor:
                return UIColor(hex: 0x4E4C49)
            case .navigationSeparateViewColor:
                return UIColor(hex: 0xF4F1EB)
            case .diaryDateLabelColor:
                return UIColor(hex: 0x5ABD80)
            case .diaryTitleColor:
                return UIColor(hex: 0x5F5D59)
            case .diaryContentColor:
                return UIColor(hex: 0x5F5D59)
            case .diaryTitleSeparatViewColor:
                return UIColor(hex: 0xE2DFD7)
            case .infoLabelColor:
                return UIColor(hex: 0xB2AFAA)
            }
        }
    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        viewSetting()
    }
    
    
    func labelSetting() {
        navigationTitleLabel.text = stringValue.navigationTitle.getLabelValue()
        diaryInfoLabel.text = stringValue.infoLabel.getLabelValue()
        
        navigationTitleLabel.textColor = hexColor.navigationTitleColor.getHexColor()
        diaryDateLabel.textColor = hexColor.diaryDateLabelColor.getHexColor()
        diaryTitleLabel.textColor = hexColor.diaryTitleColor.getHexColor()
        diaryContentLabel.textColor = hexColor.diaryContentColor.getHexColor()
        diaryInfoLabel.textColor = hexColor.infoLabelColor.getHexColor()
    }
    func viewSetting() {
        view.backgroundColor = hexColor.backgroundColor.getHexColor()
        navigationBarView.backgroundColor = hexColor.backgroundColor.getHexColor()
        navigationSeparateView.backgroundColor = hexColor.navigationSeparateViewColor.getHexColor()
        diaryScrollContentView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryScrollView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryInfoView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryTitleView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryContentView.backgroundColor = hexColor.backgroundColor.getHexColor()
    }
    
    
    // MARK: - Actions
    @IBAction func diaryDeleteButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        let deleteCheckAlertVC = UIStoryboard(name: "DeleteCheck", bundle: nil).instantiateViewController(withIdentifier: "DeleteCheckAlertViewController") as! DeleteCheckAlertViewController
        deleteCheckAlertVC.diaryId = self.diaryId
        print(deleteCheckAlertVC.diaryId, "보낸 id 값")
        present(deleteCheckAlertVC, animated: true, completion: nil)
    }
}

    // MARK: - Extensions

