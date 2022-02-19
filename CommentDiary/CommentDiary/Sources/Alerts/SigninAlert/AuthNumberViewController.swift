//
//  SigninAlertViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit
//https://www.youtube.com/watch?v=NP7H_LjTZGw
class AuthNumberViewController: UIViewController {
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func cancelTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func okTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
