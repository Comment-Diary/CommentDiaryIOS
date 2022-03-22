//
//  DiaryReportViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/13.
//

import Foundation
import UIKit

class DiaryReportViewController : UIViewController {
    var diaryId : Int = 0
    //MARK: - Properties
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var okayButton: UIButton!
    
    @IBOutlet weak var reportLabel: UILabel!
    
    @IBOutlet weak var textBackView: UIView!
    
    @IBOutlet weak var reportTextView: UITextView!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        viewSetting()
        buttonSetting()
        reportTextView.delegate = self
        reportTextView.text = """
신고 사유를 자세히 작성해주세요. \n
사실과 다를 경우 이용 제재를 \n
받을 수 있습니다.
"""
        reportTextView.textColor = UIColor(hex: 0x878379)
    }
    
    func labelSetting() {
        reportLabel.text = "신고하기"
        reportLabel.textColor = UIColor(hex: 0x5F5D59)
        reportLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        
    }
    func viewSetting() {
        alertView.backgroundColor = UIColor(hex: 0xF4EDE3)
        alertView.layer.cornerRadius = 10
        textBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        textBackView.layer.cornerRadius = 10
        reportTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        
    }
    func buttonSetting() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        cancelButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .highlighted)
        cancelButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.maskedCorners  = .layerMinXMaxYCorner
        okayButton.setTitle("확인", for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .highlighted)
        okayButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        okayButton.layer.cornerRadius = 10
        okayButton.layer.maskedCorners = .layerMaxXMaxYCorner

        cancelButton.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
        cancelButton.layer.borderWidth = 1
        okayButton.layer.borderWidth = 1
        okayButton.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
    }
    
    
    //MARK: - Actions
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okayButtonTap(_ sender: Any) {
        if reportTextView.text.count == 0 || reportTextView.text == """
신고 사유를 자세히 작성해주세요. \n
사실과 다를 경우 이용 제재를 \n
받을 수 있습니다.
""" {
            self.presentBottomAlert(message: "신고 내용을 적어주세요.")
        } else {
            //API
            self.showIndicator()
            DiaryReportRequest.content = reportTextView.text
            DiaryReportDataManager().diaryReportPostData(self, diaryId: diaryId)

        }
    }
    
    
}

    //MARK: - Extensions
extension DiaryReportViewController : UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if reportTextView.text.isEmpty {
            reportTextView.text = """
    신고 사유를 자세히 작성해주세요. \n
    사실과 다를 경우 이용 제재를 \n
    받을 수 있습니다.
    """
            reportTextView.textColor = UIColor(hex: 0x878379)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reportTextView.textColor == UIColor(hex: 0x878379) {
            reportTextView.text = nil
            reportTextView.textColor = UIColor(hex: 0x4E4C49)
        }
    }
}

extension DiaryReportViewController {
    func diaryReportSuccess(_ response: DiaryReportResponse) {
        dismissIndicator()
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
}
