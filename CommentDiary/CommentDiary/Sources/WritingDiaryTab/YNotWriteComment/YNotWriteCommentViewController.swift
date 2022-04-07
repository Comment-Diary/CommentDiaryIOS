//
//  YNotWriteCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/04/07.
//

import Foundation
import UIKit

class YNotWriteCommentViewController : UIViewController {
    var diaryID : Int = 0
    //MARK: - Properties
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var diaryScrollView: UIScrollView!
    
    @IBOutlet weak var alllBackView: UIView!
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var bottomBackView: UIView!
    @IBOutlet weak var contentBackView: UIView!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var infoTopLabel: UILabel!
    
    @IBOutlet weak var infoBottomLabel: UILabel!
    @IBOutlet weak var backButtonTap: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        navigationBackSwipeMotion()
        
        
        //API 조회
        YNotWriteCommentDataManager().YNotWriteCommentData(diaryID: diaryID, self)
        self.showIndicator()
        
    }
    
    func navigationBackSwipeMotion() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        infoTopLabel.text = "'도착한 일기'의 코멘트를 작성하지 않아서"
        infoTopLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        infoTopLabel.textColor = UIColor(hex: 0x878379)
        infoBottomLabel.text = "코멘트를 놓쳤어요. 다음에는 꼭 작성해주세요."
        infoBottomLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        infoBottomLabel.textColor = UIColor(hex: 0x878379)
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
        alllBackView.layer.cornerRadius = 10
        alllBackView.backgroundColor = .clear
        diaryScrollView.backgroundColor = .clear
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

    //MARK: - Extensions
extension YNotWriteCommentViewController {
    func diaryGet(_ response: DiaryCheckResopnse) {
        dateLabel.text = response.result.date
        titleLabel.text = response.result.title
        contentLabel.text = response.result.content
        self.dismissIndicator()
        
    }
}
