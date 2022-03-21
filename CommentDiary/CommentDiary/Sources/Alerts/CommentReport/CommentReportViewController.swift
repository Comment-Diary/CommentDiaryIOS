//
//  CommentReportViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/23.
//

import Foundation
import UIKit

class CommentReportViewController : UIViewController {
    var commentIndex: Int = 0
    //MARK: - Properties
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var reportLabel: UILabel!
    
    @IBOutlet weak var reportTextView: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var okayButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        viewSetting()
        buttonSetting()
        
        //textview place holder
        reportTextView.delegate = self
        reportTextView.text = """
신고 사유를 자세히 작성해주세요. \n
사실과 다를 경우 이용 제재를 \n
받을 수 있습니다.
"""
        reportTextView.textColor = UIColor(hex: 0x878379)
    }
    
    func viewSetting() {
        backView.backgroundColor = UIColor(hex: 0xF4EDE3)
        backView.layer.cornerRadius = 10
        reportTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        reportTextView.layer.cornerRadius = 10
        
    }
    
    func labelSetting() {
        reportLabel.text = "신고하기"
        reportLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        reportLabel.textColor = UIColor(hex: 0x5F5D59)
        
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
//        cancelButton.layer.addBorder([.top, .right], color: UIColor(hex: 0xE2DFD7), width: 1)
//        okayButton.layer.addBorder([.top], color: UIColor(hex: 0xE2DFD7), width: 1)
        cancelButton.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
        cancelButton.layer.borderWidth = 1
        okayButton.layer.borderWidth = 1
        okayButton.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
        
        
    }
    
    //MARK: - Actions
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func okayButtonTap(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        if reportTextView.text.count == 0 || reportTextView.text == """
신고 사유를 자세히 작성해주세요. \n
사실과 다를 경우 이용 제재를 \n
받을 수 있습니다.
""" {
            self.presentBottomAlert(message: "신고 내용을 적어주세요.")
        } else {
            //API
            self.showIndicator()
            CommentReportRequest.content = reportTextView.text ?? ""
            CommentReportRequest.commentId = commentIndex
        }
    }
    
    
}

    //MARK: - Extentions

extension CommentReportViewController : UITextViewDelegate {
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

extension CommentReportViewController {
    func commentReportSuccess(_ response: CommentReportResponse) {
        
    }
}
