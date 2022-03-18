//
//  DetailCommentDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/18.
//

import Foundation
import UIKit

class DetailCommentDiaryViewController: UIViewController {
    //API 코멘트 일기 id 값
    var diaryInt = 0
    //pop or 루트뷰 토글
    var transToggle : Bool = false
    //MARK: - Properties
    
    @IBOutlet weak var topBackView: UIView!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var commentDiaryScrollView: UIScrollView!
    
    @IBOutlet weak var allContentView: UIView!
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var sendBackView: UIView!
    
    @IBOutlet weak var sendLabel: UILabel!
    
    @IBOutlet weak var waitLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        buttonSetting()
        viewSetting()
        scrollViewSetting()
        
        //API 조회
        print(diaryInt, "코멘트 일기 id 값")
        CommentDiaryCheckDataManager().commentDiaryCheckData(diaryID: diaryInt, self)
    }
    
    
    func labelSetting() {
        waitLabel.text = "전송 후 코멘트 도착까지 조금만 기다려주세요."
        waitLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        waitLabel.textColor = UIColor(hex: 0x878379)
        sendLabel.text = "전송완료"
        sendLabel.textColor = UIColor(hex: 0x878379)
        sendLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
        
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        
        
    }
    
    func buttonSetting() {
        
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        sendBackView.backgroundColor = UIColor(hex: 0xE2DFD7)
        contentView.backgroundColor = UIColor(hex: 0xFDFCF9)
        titleBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        
        allContentView.backgroundColor = UIColor(hex: 0xF4EDE3)
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        titleBackView.layer.cornerRadius = 10
        titleBackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func scrollViewSetting() {
        commentDiaryScrollView.backgroundColor = UIColor(hex: 0xF4EDE3)
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        //토글 값으로 화면 전환 방식
        // true이면 캘린더로 pop
        if transToggle == true {
            navigationController?.popViewController(animated: true)
        }
        else if transToggle == false {
            let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
            self.changeRootViewController(mainTabBarController)
        }
        
    }
    
}


    //MARK: - Extensions
extension DetailCommentDiaryViewController {
    func commentDiaryGet(_ response: DiaryCheckResopnse) {
        dateLabel.text = response.result.date
        contentLabel.text = response.result.content
        titleLabel.text = response.result.title
    }
}
