//
//  PasswordSearchViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/22.
//

import Foundation
import UIKit

class PasswordSearchViewController : UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var searchPasswordLabel: UILabel!
    
    @IBOutlet weak var emailInputTextField: UITextField!
    
    @IBOutlet weak var sendPasswordButton: UIButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackgroundColor
    }
    
    //MARK: - Actions
    @IBAction func sendPasswordTapButton(_ sender: Any) {
    }
    @IBAction func backButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
}

    //MARKL: - Extentions
