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
    }
    
    func viewSetting() {
        self.sentCompleteView.layer.cornerRadius = 10
        self.sentCompleteView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    func buttonSetting() {
        self.okButton.backgroundColor = UIColor(hex: 0xFDFCF9)
        self.okButton.layer.cornerRadius = okButton.frame.height / 2
    }
    //MARK: - Actions
    @IBAction func okTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
    //MARK: - Extensions
