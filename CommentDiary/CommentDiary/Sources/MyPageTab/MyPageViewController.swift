//
//  MyPageViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit

class MyPageViewController :UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var myPageView: UIView!
    @IBOutlet weak var myPageLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var firstSeparateView: UIView!
    
    @IBOutlet weak var myTempView: UIView!
    
    @IBOutlet weak var secondSeparateView: UIView!
    
    @IBOutlet weak var myAccountView: UIView!
    @IBOutlet weak var myAccountLabel: UILabel!
    
    @IBOutlet weak var thirdSeparateView: UIView!
    
    @IBOutlet weak var sendCommentView: UIView!
    
    @IBOutlet weak var sendCommentLabel: UILabel!
    
    @IBOutlet weak var pushAlertView: UIView!
    
    @IBOutlet weak var pushAlertLabel: UILabel!
    
    @IBOutlet weak var termsView: UIView!
    
    @IBOutlet weak var termsLabel: UILabel!
    
    @IBOutlet weak var fourthSeparateView: UIView!
    
    @IBOutlet weak var fifthSeparateView: UIView!
    
    @IBOutlet weak var sixthSeparateView: UIView!
    
    @IBOutlet weak var emailBackView: UIView!
    
    @IBOutlet weak var myTemp: UILabel!
    
    @IBOutlet weak var tempBackView: UIView!
    
    @IBOutlet weak var progressBackView: UIView!
    
    @IBOutlet weak var tempProgressView: UIProgressView!
    
    @IBOutlet weak var myTempInfoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        
        MyPageDataManager().myPageData(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailBackView.layer.cornerRadius = emailBackView.frame.height / 2
        progressBackView.layer.cornerRadius = progressBackView.frame.height / 2
        
        
    }
    
    func viewSetting() {
        backView.backgroundColor = UIColor(hex: 0xFDFCF9)
        firstSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        secondSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        thirdSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        fourthSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        fifthSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        sixthSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        myPageView.backgroundColor = UIColor(hex: 0xFDFCF9)
        myTempView.backgroundColor = UIColor(hex: 0xFDFCF9)
        myAccountView.backgroundColor = UIColor(hex: 0xFDFCF9)
        sendCommentView.backgroundColor = UIColor(hex: 0xFDFCF9)
        pushAlertView.backgroundColor = UIColor(hex: 0xFDFCF9)
        termsView.backgroundColor = UIColor(hex: 0xFDFCF9)
        emailBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        emailBackView.layer.borderWidth = 1
        emailBackView.layer.borderColor = UIColor(hex: 0x4E4C49).cgColor
        
        tempBackView.layer.cornerRadius = 10
        tempBackView.backgroundColor = UIColor(hex: 0xF4F1EB)
    }
    
    func labelSetting() {
        myTemp.textColor = UIColor(hex: 0x878379)
        myTemp.font = UIFont.AppleSDGothic(.bold, size: 14)
        myTempInfoLabel.text = "보낸 코멘트가 '좋아요'를 받을 때 온도가 채워집니다."
        myTempInfoLabel.font = UIFont.AppleSDGothic(.medium, size: 11)
        myTempInfoLabel.textColor = UIColor(hex: 0x878379)
        myPageLabel.textColor = UIColor(hex: 0x4E4C49)
        myPageLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        emailLabel.textColor = UIColor(hex: 0x4E4C49)
        emailLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
        myAccountLabel.textColor = UIColor(hex: 0x4E4C49)
        myAccountLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        sendCommentLabel.textColor = UIColor(hex: 0x4E4C49)
        sendCommentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        pushAlertLabel.textColor = UIColor(hex: 0x4E4C49)
        pushAlertLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        termsLabel.textColor = UIColor(hex: 0x4E4C49)
        termsLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
    }
    
    
    @IBAction func myAccountButtonTap(_ sender: Any) {
        let myAccountVC = UIStoryboard(name: "MyAccount", bundle: nil).instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        self.navigationController?.pushViewController(myAccountVC, animated: true)
    }
    
    
    @IBAction func sendCommentButtonTap(_ sender: Any) {
        let sendCommentVC = UIStoryboard(name: "SendComment", bundle: nil).instantiateViewController(withIdentifier: "SendCommentViewController") as! SendCommentViewController
        self.navigationController?.pushViewController(sendCommentVC, animated: true)
    }
    
    @IBAction func pushAlertButtonTap(_ sender: Any) {
    }
    
    @IBAction func termsButtonTap(_ sender: Any) {
        let termsvc = UIStoryboard(name: "Terms", bundle: nil).instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        self.navigationController?.pushViewController(termsvc, animated: true)
    }
    
    
}
//        let selfPayVC = UIStoryboard(name: "payment", bundle: nil).instantiateViewController(identifier: "SelfPaymentViewController") as! SelfPaymentViewController
//        self.navigationController?.pushViewController(selfPayVC, animated: true)

    //Extensions
extension MyPageViewController {
    func myPageSuccessResponse(_ response: MyPageResponse) {
        self.emailLabel.text = response.result.email
    }
}
