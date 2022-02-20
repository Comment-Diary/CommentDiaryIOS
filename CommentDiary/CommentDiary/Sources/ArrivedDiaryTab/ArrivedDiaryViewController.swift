//
//  ArrivedDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit

class ArrivedDiaryViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var diaryTitleLabel: UILabel!
    @IBOutlet weak var diaryContentLabel: UILabel!
    
    @IBOutlet weak var myCommentCountLabel: UILabel!
    
    @IBOutlet weak var sendCommentButton: UIButton!
    
    @IBOutlet weak var myCommentTextView: UITextView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textLineSpacing()
    }
    
    
    func textLineSpacing() {
        let attrString = NSMutableAttributedString(string: diaryTitleLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        diaryTitleLabel.attributedText = attrString
    }
    
    //MARK: - Actions
    @IBAction func sendCommentButtonTap(_ sender: UIButton) {
    }
    
}


    //MARK: - Extensions
