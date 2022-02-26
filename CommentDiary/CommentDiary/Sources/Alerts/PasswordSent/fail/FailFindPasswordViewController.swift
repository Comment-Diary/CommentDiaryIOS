//
//  PasswordSentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/23.
//

import Foundation
import UIKit

class FailFindPasswordViewController : UIViewController {
    //MARK: - Properties
    

    @IBOutlet weak var noEmailView: UIView!
    
    @IBOutlet weak var noEmailFirstLabel: UILabel!
    @IBOutlet weak var noEmailSecondLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions

    
    @IBAction func cancelTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

    //MARK: - Extensions
