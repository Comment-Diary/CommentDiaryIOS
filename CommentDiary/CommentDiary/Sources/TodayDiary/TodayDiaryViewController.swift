//
//  TodayDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/18.
//

import Foundation
import UIKit
import PanModal

class TodayDiaryViewController: UIViewController, commentViewChangeDelegate, buttonChangeDelegate, countLabelChangeDelegate {
    func onCountLabelChange(data: Bool) {
        textCountLabel.isHidden = data
    }
    
    func onCommentViewChange(data: Bool) {
        saveButton.isEnabled = data
    }
    
    func onButtonChange(data: Bool) {
        commentView.isHidden = data
    }
    
    //MARK: - Properties
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        bottomsheetSetting()

    }
    
    func viewSetting() {
        view.backgroundColor = UIColor.red
    }
    
    func bottomsheetSetting() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute:  {
            let todayDiaryBottomVC = UIStoryboard(name: "TodayDiaryBottom", bundle: nil).instantiateViewController(withIdentifier: "TodayDiaryBottomViewController") as! TodayDiaryBottomViewController
            todayDiaryBottomVC.countLabelChangeDelegate = self
            todayDiaryBottomVC.buttonChangeDelegate = self
            todayDiaryBottomVC.commentViewDelegate = self
            self.presentPanModal(todayDiaryBottomVC)
        })
    }
    
    
    //MARK: - Actions
    
    @IBAction func saveTapButton(_ sender: Any) {
    }
    
}

    //MARK: - Extenstions
