//
//  ReadCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit
class ReadCommentViewController: UIViewController {
    var diaryIDValue: Int = 0
    //MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    @IBOutlet weak var allLookButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var topBackVIew: UIView!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var contentView: UILabel!
    
    @IBOutlet weak var contentBackView: UIView!
    
    @IBOutlet weak var bottomBackView: UIView!
    
    @IBOutlet weak var readCommentLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        buttonSetting()
        viewSetting()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadDate(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadID(_:)), name: NSNotification.Name(rawValue: "SelectedID"), object: nil)
    }
    
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        contentView.textColor = UIColor(hex: 0x4E4C49)
        contentView.font = UIFont.AppleSDGothic(.medium, size: 15)
        readCommentLabel.text = "코멘트가 도착했어요. 확인해주세요!"
        readCommentLabel.textColor = UIColor(hex: 0xFDFCF9)
        readCommentLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
    }
    
    func buttonSetting() {
        allLookButton.setTitle("전체보기", for: .normal)
        allLookButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        allLookButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    func viewSetting() {
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        topBackVIew.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        bottomBackView.backgroundColor = UIColor(hex: 0x73BF90)
        
    }
    
    @objc func loadDate(_ notification: NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
    }
    
    @objc func loadTitle(_ notification: NSNotification) {
        titleLabel.text = notification.object as? String ?? ""
    }
    @objc func loadContent(_ notification: NSNotification) {
        contentView.text = notification.object as? String ?? ""
    }
    
    @objc func loadID(_ notification: NSNotification) {
        diaryIDValue = notification.object as? Int ?? 0
    }
    
    
    //MARK: - Actions
    
    @IBAction func allLookButtonTap(_ sender: Any) {
        let yReadCommentVC = UIStoryboard(name: "YReadComment", bundle: nil).instantiateViewController(withIdentifier: "YReadCommentViewController") as! YReadCommentViewController
        yReadCommentVC.diaryId = diaryIDValue
        yReadCommentVC.completion = {
            self.tabBarController?.selectedIndex = 1
        }
        self.navigationController?.pushViewController(yReadCommentVC, animated: true)
    }
    
}


    //MARK: - Extensions
