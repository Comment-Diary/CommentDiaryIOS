//
//  DiaryBlockViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/29.
//

import Foundation
import UIKit

class DiaryBlockViewController: UIViewController {
    var diaryID : Int = 0
    //MARK: - Properties
    
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var cancelButton: CornerButton!
    
    @IBOutlet weak var okayButton: CornerButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        buttonSetting()
        viewSetting()
    }
    
    func labelSetting() {
        alertView.clipsToBounds = true
        alertView.layer.cornerRadius = 10
        alertView.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    func buttonSetting() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(UIColor(hex: 0x878379), for: .highlighted)
        cancelButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        cancelButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        cancelButton.backgroundColor = UIColor(hex: 0xE2DFD7)
        okayButton.setTitle("확인", for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        okayButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        okayButton.backgroundColor = UIColor(hex: 0x73BF90)
        

        okayButton.isHighlighted = false
        cancelButton.isHighlighted = false
    }
    func viewSetting() {
        alertLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        alertLabel.textColor = UIColor(hex: 0x5F5D59)
        alertLabel.text = "정말 차단하시나요?"
    }
    
    //MARK: - Actions
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func okayButtonTap(_ sender: Any) {
        self.showIndicator()
        DiaryReportRequest.content = alertLabel.text ?? ""
        DiaryBlockDataManaber().diaryReportPostData(self, diaryId: diaryID, blockContent: "차단하였습니다.")
    }
    
}

    //MARK: - Extensions
extension DiaryBlockViewController {
    func diaryBlockSuccess(_ response: DiaryReportResponse) {
        dismissIndicator()
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
}
