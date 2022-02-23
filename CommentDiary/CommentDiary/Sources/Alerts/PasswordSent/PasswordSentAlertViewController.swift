//
//  PasswordSentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/23.
//

import Foundation
import UIKit

class PasswordSentAlertViewController : UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var sentCompleteView: UIView!
    @IBOutlet weak var sentCompleteLabel: UILabel!
    @IBOutlet weak var checkEmailLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    
    @IBOutlet weak var noEmailView: UIView!
    
    @IBOutlet weak var noEmailFirstLabel: UILabel!
    @IBOutlet weak var noEmailSecondLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @IBAction func okTapButton(_ sender: Any) {
    }
    
    @IBAction func cancelTapButton(_ sender: Any) {
    }
    
}

    //MARK: - Extensions
