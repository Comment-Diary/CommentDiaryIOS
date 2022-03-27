//
//  NotArrivalCommentDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/23.
//

import Foundation
import UIKit

class NotArrivalCommentDiaryViewController : UIViewController, UIScrollViewDelegate {
    var diaryDate: String = ""
    var diaryTitle: String = ""
    var diaryContent: String = ""
    //MARK: - Properties
    
    @IBOutlet weak var allBackView: UIView!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var titleBackView: UIView!
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var bottomBackView: UIView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var diaryScrollView: UIScrollView!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryScrollView.delegate = self
        dateLabel.text = diaryDate
        titleLabel.text = diaryTitle
        contentLabel.text = diaryContent
        
        
        
        labelSetting()
        buttonSetting()
        viewSetting()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    
    //MARK: - Actions
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        infoLabel.text = "아쉽게도 누군가로부터 코멘트가 도착하지 않았어요."
        infoLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        infoLabel.textColor = UIColor(hex: 0x878379)
    }
    func buttonSetting() {
        
    }
    
    func viewSetting() {
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        bottomBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        titleBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryScrollView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        contentBackView.layer.cornerRadius = 10
        contentBackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        titleBackView.layer.cornerRadius = 10
        titleBackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        allBackView.layer.cornerRadius = 10
        allBackView.backgroundColor = .clear
        diaryScrollView.backgroundColor = .clear
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        
        
    }
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

    //MARK: - Extensions
