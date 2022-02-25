//
//  SendDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/25.
//

import Foundation
import UIKit

class SendDiaryAlertViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var textBackView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var middleTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetting()
        labelSetting()
        viewSetting()
    }
    
    func buttonSetting() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        cancelButton.backgroundColor = UIColor(hex: 0xE2DFD7)
        
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        okButton.layer.cornerRadius = okButton.frame.height / 2
        okButton.backgroundColor = UIColor(hex: 0x73BF90)
//        okButton.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
        
    }
    
    func labelSetting() {
        topTextLabel.text = "다른 누군가에게 일기가 전송됩니다."
        middleTextLabel.text = "전송 후에는 수정 및 삭제가 어렵습니다."
        bottomTextLabel.text = "전송하시겠습니까?"
//        topTextLabel.font
//        middleTextLabel.font
//        bottomTextLabel.font
        topTextLabel.textColor = UIColor(hex: 0x5F5D59)
        middleTextLabel.textColor = UIColor(hex: 0x5F5D59)
        bottomTextLabel.textColor = UIColor(hex: 0x5F5D59)
    }
    
    func viewSetting() {
        alertView.backgroundColor = UIColor(hex: 0xFDFDF9)
        textBackView.backgroundColor = UIColor(hex: 0xFDFDF9)
    }
    
    //MARK: - Actions
    
    @IBAction func cancelButtonTap(_ sender: Any) {
    }
    
    @IBAction func okButtonTap(_ sender: Any) {
    }
    
    
}

    //MARK: - Extenstions
