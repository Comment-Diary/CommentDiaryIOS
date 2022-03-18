//
//  DiaryStopViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/17.
//

import Foundation
import UIKit

class DiaryStopViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var cancelButton: CornerButton!
    @IBOutlet weak var okayButton: CornerButton!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        buttonSetting()
        labelSetting()
    }
    
    
    func viewSetting() {
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
    
    func labelSetting() {
        topLabel.textColor = UIColor(hex: 0x5F5D59)
        topLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        bottomLabel.textColor = UIColor(hex: 0x5F5D59)
        bottomLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    
    //MARK: - Actions
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okayButtonTap(_ sender: Any) {
        guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
        self.dismiss(animated: true) {
            presentingVC.popToRootViewController(animated: true)
        }
    }
    
    
    
}

    //MARK: - Extensions
