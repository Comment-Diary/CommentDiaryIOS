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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    
    func viewSetting() {
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
        emailBackView.layer.cornerRadius = emailBackView.frame.height / 2
        emailBackView.layer.borderWidth = 1
        emailBackView.layer.borderColor = UIColor(hex: 0x4E4C49).cgColor
    }
    
    
    @IBAction func myAccountButtonTap(_ sender: Any) {
    }
    
    
    @IBAction func sendCommentButtonTap(_ sender: Any) {
    }
    
    @IBAction func pushAlertButtonTap(_ sender: Any) {
    }
    
    @IBAction func termsButtonTap(_ sender: Any) {
    }
    
    
}
