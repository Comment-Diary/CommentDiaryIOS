//
//  TermsViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import UIKit

class TermsViewController : UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var termsBackView: UIView!
    
    @IBOutlet weak var termsLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var firstSeparateView: UIView!
    @IBOutlet weak var usageLabel: UILabel!
    
    @IBOutlet weak var usageView: UIView!
    
    @IBOutlet weak var secondSeparateView: UIView!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var thirdSeparateView: UIView!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        termsBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        usageView.backgroundColor = UIColor(hex: 0xFDFCF9)
        infoView.backgroundColor = UIColor(hex: 0xFDFCF9)
        firstSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        secondSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        thirdSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func usageButtonTap(_ sender: Any) {
    }
    @IBAction func infoButtonTap(_ sender: Any) {
    }
    
}


    //MARK: - Extensions
