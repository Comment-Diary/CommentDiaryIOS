//
//  YPreSaveDeadlineViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/23.
//

import Foundation
import UIKit

class YPreSaveDeadlineViewController : UIViewController {
    //MARK: - Properties
    //일기 제목
    var diaryTItle: String = ""
    //일기 날짜
    var diaryDate: String = ""
    //일기 내용
    var diaryContent: String = ""
    //일기 id
    var diaryId: Int = 0
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBOutlet weak var deadlineBackView: UIView!
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var diaryScrollView: UIScrollView!
    
    @IBOutlet weak var allView: UIView!
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        viewSetting()
        buttonSetting()
        navigationBackSwipeMotion()
        
        titleLabel.text = diaryTItle
        dateLabel.text = diaryDate
        contentLabel.text = diaryContent
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
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        deadlineLabel.text = "일기전송 시간이 지났어요..."
        deadlineLabel.textColor = UIColor(hex: 0x878379)
        deadlineLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        
    }
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        deadlineBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        allView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryScrollView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryScrollView.layer.cornerRadius = 10
        allView.layer.cornerRadius = 10
        titleBackView.layer.cornerRadius = 10
        titleBackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        
        
        
        
    }
    
    func buttonSetting() {
        sendButton.isEnabled = false
        sendButton.setTitle("전송하기", for: .normal)
        sendButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        sendButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        sendButton.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonTap(_ sender: Any) {
        let deleteCheckAlertVC = UIStoryboard(name: "DeleteCheck", bundle: nil).instantiateViewController(withIdentifier: "DeleteCheckAlertViewController") as! DeleteCheckAlertViewController
        deleteCheckAlertVC.diaryId = self.diaryId
        print(deleteCheckAlertVC.diaryId, "보낸 id 값")
        present(deleteCheckAlertVC, animated: true, completion: nil)
        
    }
    
}

    //MARK: - Extensions
