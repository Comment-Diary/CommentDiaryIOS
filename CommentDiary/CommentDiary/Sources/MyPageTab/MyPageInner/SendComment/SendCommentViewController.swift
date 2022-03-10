//
//  SendCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import UIKit

class SendCommentViewController : UIViewController {
    //MARK: - Properties
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var sendCommentLabel: UILabel!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var commentBackView: UIView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        commentBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
    }
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

    //MARK: - Extensions
