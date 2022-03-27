//
//  SuccessFindPasswordViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/27.
//

import Foundation
import UIKit

class SuccessFindPasswordViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var sentCompleteView: UIView!
    @IBOutlet weak var sentCompleteLabel: UILabel!
    @IBOutlet weak var checkEmailLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        buttonSetting()
        labelSetting()
    }
    func labelSetting() {
        sentCompleteLabel.textColor = UIColor(hex: 0x5F5D59)
        sentCompleteLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        checkEmailLabel.textColor = UIColor(hex: 0x5F5D59)
        checkEmailLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
    }
    
    func viewSetting() {
        self.sentCompleteView.layer.cornerRadius = 10
        self.sentCompleteView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    func buttonSetting() {
        self.okButton.backgroundColor = UIColor(hex: 0xFDFCF9)
        self.okButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        self.okButton.setTitle("작성하기", for: .normal)
    }
    //MARK: - Actions
    @IBAction func okTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
    //MARK: - Extensions
