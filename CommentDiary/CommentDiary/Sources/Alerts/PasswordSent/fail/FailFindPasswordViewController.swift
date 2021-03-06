//
//  PasswordSentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/23.
//

import Foundation
import UIKit

class FailFindPasswordViewController : UIViewController {
    //MARK: - Properties
    

    @IBOutlet weak var noEmailView: UIView!
    
    @IBOutlet weak var noEmailFirstLabel: UILabel!
    @IBOutlet weak var noEmailSecondLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        
        
    }
    
    func labelSetting() {
        noEmailFirstLabel.textColor = UIColor(hex: 0x5F5D59)
        noEmailFirstLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        noEmailSecondLabel.textColor = UIColor(hex: 0x5F5D59)
        noEmailSecondLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
    }
    
    func viewSetting() {
        self.noEmailView.layer.cornerRadius = 10
        self.noEmailView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    //MARK: - Actions

    
    @IBAction func cancelTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

    //MARK: - Extensions
