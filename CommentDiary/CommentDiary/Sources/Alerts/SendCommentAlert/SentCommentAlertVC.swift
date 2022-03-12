//
//  SentCommentAlertVC.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import Foundation
import UIKit

class SentCommentAlertVC : UIViewController {
    
    
    //MARK: - Properties
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var labelView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var okButton: UIButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        buttonSetting()
    }
    
    func viewSetting() {
        alertView.backgroundColor = UIColor(hex: 0xFDFCF9)
        labelView.backgroundColor = UIColor(hex: 0xFDFCF9)
        
    }
    
    func buttonSetting() {
        cancelButton.backgroundColor = UIColor(hex: 0xE2DFD7)
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        okButton.backgroundColor = UIColor(hex: 0x73BF90)
        okButton.layer.cornerRadius = okButton.frame.height / 2
        
    }
    
    
    //MARK: - Actions
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

    //MARK: - Extensions
