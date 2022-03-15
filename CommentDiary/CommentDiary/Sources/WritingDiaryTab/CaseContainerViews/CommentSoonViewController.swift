//
//  CommentSoonViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit

class CommentSoonViewController:UIViewController {
    private lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    //MARK: - Properties
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var detailDiaryButton: UIButton!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bottomBackView: UIView!
    
    @IBOutlet weak var waitLabel: UILabel!
    
    
    @IBOutlet weak var contentBackView: UIView!
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        viewSetting()
        buttonSetting()
        NotificationCenter.default.addObserver(self, selector: #selector(loadDate(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
    }
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
    
        waitLabel.textColor = UIColor(hex: 0x878379)
        waitLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
    }
    func viewSetting() {
        self.backView.backgroundColor = UIColor(hex: 0xE2DFD7)
        self.topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        self.bottomBackView.backgroundColor = UIColor(hex: 0xE2DFD7)
        self.separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        self.contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    func buttonSetting() {
        detailDiaryButton.setTitle("전체보기", for: .normal)
        detailDiaryButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        detailDiaryButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
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
    
    
    
    
    //MARK: - Actions
}

    //MARK: - Extensions
