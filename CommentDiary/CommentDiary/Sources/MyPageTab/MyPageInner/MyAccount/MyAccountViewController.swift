//
//  MyAccountViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import UIKit

class MyAccountViewController : UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var myAccount: UILabel!
    
    @IBOutlet weak var firstSeparteView: UIView!
    
    @IBOutlet weak var logOutLabel: UILabel!
    
    @IBOutlet weak var logOutBackView: UIView!
    @IBOutlet weak var secondSeparateView: UIView!
    
    @IBOutlet weak var memberOutView: UIView!
    
    @IBOutlet weak var memberOutLabel: UILabel!
    @IBOutlet weak var thirdSeparateView: UIView!
    
    @IBOutlet weak var fourthSeparateView: UIView!
    
    @IBOutlet weak var passwordChangeBackView: UIView!
    @IBOutlet weak var changePasswordLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        myAccount.backgroundColor = UIColor(hex: 0xFDFCF9)
        memberOutView.backgroundColor = UIColor(hex: 0xFDFCF9)
        passwordChangeBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        firstSeparteView.backgroundColor = UIColor(hex: 0xE2DFD7)
        secondSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        thirdSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        fourthSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        
    }
    
    func labelSetting() {
        myAccount.textColor = UIColor(hex: 0x4E4C49)
        myAccount.font = UIFont.AppleSDGothic(.bold, size: 21)
        logOutLabel.textColor = UIColor(hex: 0x4E4C49)
        logOutLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        memberOutLabel.textColor = UIColor(hex: 0x4E4C49)
        memberOutLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        changePasswordLabel.textColor = UIColor(hex: 0x4E4C49)
        changePasswordLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
    }
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func memberOutButtonTap(_ sender: Any) {
        let memberOutVC = UIStoryboard(name: "MemberOut", bundle: nil).instantiateViewController(withIdentifier: "MemberOutViewController") as! MemberOutViewController
        self.navigationController?.pushViewController(memberOutVC, animated: true)
    }
    
    @IBAction func logOutTapButton(_ sender: Any) {
    }
    
    @IBAction func changePassowordButtonTap(_ sender: Any) {
        let changePasswordVC = UIStoryboard(name: "ChangePassword", bundle: nil).instantiateViewController(withIdentifier: "ChagePasswordViewController") as! ChagePasswordViewController
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    
}

    //MARK: - Extensions
