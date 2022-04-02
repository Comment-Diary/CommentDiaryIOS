//
//  SendCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/23.
//

import Foundation
import UIKit



class SendCommentAlertViewController : UIViewController {
    
    //MARK: - Properties
    var diaryID: Int = 0
    var diaryDate: String = ""
    var diaryContent: String = ""

    @IBOutlet weak var cancelButton: CornerButton!
    
    @IBOutlet weak var okayButton: CornerButton!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var alertView: UIView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        buttonSetting()
        viewSetting()
        
        print(diaryID, "보낼 id")
        print(diaryDate, "보낼 날짜")
        print(diaryContent, "보낼 내용")
    }
    
    func labelSetting() {

        firstLabel.text = "코멘트를 전송합니다."
        secondLabel.text = "전송 후에는 수정과 삭제가 어렵습니다."
        thirdLabel.text = "전송하시겠어요?"
        firstLabel.textColor = UIColor(hex: 0x5F5D59)
        secondLabel.textColor = UIColor(hex: 0x5F5D59)
        thirdLabel.textColor = UIColor(hex: 0x5F5D59)
        firstLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        secondLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        thirdLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    
    func buttonSetting() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(UIColor(hex: 0x878379), for: .highlighted)
        cancelButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        cancelButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        cancelButton.backgroundColor = UIColor(hex: 0xE2DFD7)
        okayButton.setTitle("확인", for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        okayButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        okayButton.backgroundColor = UIColor(hex: 0x73BF90)
    }
    func viewSetting() {
        alertView.backgroundColor = UIColor(hex: 0xFDFCF9)
        alertView.layer.cornerRadius = 10
        topBackView.layer.cornerRadius = 10
    }
    
    
    //MARK: - Actions
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func okayButtonTap(_ sender: Any) {
        self.showIndicator()
        CommentWritingRequest.diaryId = diaryID
        CommentWritingRequest.content = diaryContent
        CommentWritingRequest.date = diaryDate
        CommentWritingDataManager().commentWritingPostData(self)
        
    }
    
    
}

    //MARK: - Extensions
extension SendCommentAlertViewController {
    func sendCommentSuccess(_ response: CommentWriteResponse) {
        dismissIndicator()
//        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
//        self.changeRootViewController(mainTabBarController)
        guard let pvc = self.presentingViewController else { return }
        dismiss(animated:true) {
            pvc.viewWillAppear(true)
            
        }
        
    }
}
