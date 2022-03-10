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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        myAccount.backgroundColor = UIColor(hex: 0xFDFCF9)
        logOutLabel.backgroundColor = UIColor(hex: 0xFDFCF9)
        memberOutView.backgroundColor = UIColor(hex: 0xFDFCF9)
        firstSeparteView.backgroundColor = UIColor(hex: 0xE2DFD7)
        secondSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        thirdSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        
    }
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func memberOutButtonTap(_ sender: Any) {
    }
    
    @IBAction func logOutTapButton(_ sender: Any) {
    }
    
}

    //MARK: - Extensions
