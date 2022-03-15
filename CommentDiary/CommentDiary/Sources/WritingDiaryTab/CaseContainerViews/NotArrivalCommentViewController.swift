//
//  NotArrivalCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit


class NotArrivalCommentViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var allLookButton: UIButton!
    
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var commentSoonLabel: UILabel!
    
    @IBOutlet weak var bottomBackView: UIView!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        buttonSetting()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(loadDate(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
    }
    
    @objc func loadDate(_ notification: NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
    }
    
    @objc func loadTitle(_ notification: NSNotification) {
        titleLabel.text = notification.object as? String ?? ""
    }
    @objc func loadContent(_ notification: NSNotification) {
        contentLabel.text = notification.object as? String ?? ""
    }
    
    func viewSetting() {
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        bottomBackView.backgroundColor = UIColor(hex: 0xE2DFD7)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        commentSoonLabel.textColor = UIColor(hex: 0x878379)
        commentSoonLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
    }
    
    func buttonSetting() {
        allLookButton.setTitle("전체보기", for: .normal)
        allLookButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        allLookButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    //MARK: - Actions
    
    

}

