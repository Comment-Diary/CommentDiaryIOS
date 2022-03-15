//
//  PreSaveViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit

class PreSaveViewController : UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    @IBOutlet weak var diaryTItleLabel: UILabel!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    @IBOutlet weak var allLookButton: UIButton!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var bottomBackView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var preSaveLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        buttonSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.layer.cornerRadius = 10
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadDate(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
    }
    
    func viewSetting() {
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        bottomBackView.backgroundColor = UIColor(hex: 0xF7BC86)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        
    }
    
    func labelSetting() {
        preSaveLabel.textColor = UIColor(hex: 0x5F5D59)
        preSaveLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        diaryTItleLabel.textColor = UIColor(hex: 0x4E4C49)
        diaryTItleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        
    }
    func buttonSetting() {
        allLookButton.setTitle("전체보기", for: .normal)
        allLookButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        allLookButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    
    @objc func loadDate(_ notification: NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
    }
    
    @objc func loadTitle(_ notification: NSNotification) {
        diaryTItleLabel.text = notification.object as? String ?? ""
    }
    @objc func loadContent(_ notification: NSNotification) {
        contentLabel.text = notification.object as? String ?? ""
    }
    
}
