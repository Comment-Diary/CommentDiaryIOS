//
//  SendDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/25.
//

import Foundation
import UIKit

class SendDiaryAlertViewController: UIViewController {
    //코멘트 일기 전송 프로퍼티
    var commentDiaryDate = ""
    var commentDiaryContent = ""
    var commentDiaryTitle = ""
    var commentDiaryDeliveryYn = ""
    var commentDiaryTemyYn = ""
    //MARK: - Properties
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var textBackView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var middleTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    @IBOutlet weak var sendDiaryView: CornerView!
    
    @IBOutlet weak var airplaneImg: UIImageView!
    
    @IBOutlet weak var sendTopLabel: UILabel!
    @IBOutlet weak var sendBottomLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.clipsToBounds = true
        alertView.layer.cornerRadius = 10
        buttonSetting()
        labelSetting()
        viewSetting()
        
        
        //전송 완료 view Hidden
        sendDiaryView.isHidden = true
    }
    
    func buttonSetting() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        cancelButton.backgroundColor = UIColor(hex: 0xE2DFD7)
        
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        okButton.backgroundColor = UIColor(hex: 0x73BF90)
        
    }
    
    func labelSetting() {
        topTextLabel.text = "다른 누군가에게 일기가 전송됩니다."
        middleTextLabel.text = "전송 후에는 수정 및 삭제가 어렵습니다."
        bottomTextLabel.text = "전송하시겠습니까?"
        topTextLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        middleTextLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        bottomTextLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        topTextLabel.textColor = UIColor(hex: 0x5F5D59)
        middleTextLabel.textColor = UIColor(hex: 0x5F5D59)
        bottomTextLabel.textColor = UIColor(hex: 0x5F5D59)
    }
    
    func viewSetting() {
        alertView.backgroundColor = UIColor(hex: 0xFDFDF9)
        textBackView.backgroundColor = UIColor(hex: 0xFDFDF9)
    }
    
    //MARK: - Actions
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTap(_ sender: Any) {
        //코멘트 일기 전송 API
        self.showIndicator()
        WritingDiaryRequest.title = commentDiaryTitle
        WritingDiaryRequest.content = commentDiaryContent
        WritingDiaryRequest.date = commentDiaryDate
        WritingDiaryRequest.deliveryYn = commentDiaryDeliveryYn
        WritingDiaryRequest.tempYn = commentDiaryTemyYn
        WritingCommentDiaryDataManager().writingCommentDiaryPostData(self)
    }
    
    
}

    //MARK: - Extenstions
extension SendDiaryAlertViewController {
    func writingCommentDiarySuccessResponse(_ response: WritingDiaryResponse) {
        self.dismissIndicator()
        alertView.isHidden = true
        sendDiaryView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
            self.dismiss(animated: true) {
                guard let vc = UIStoryboard(name: "DetailCommentDiary", bundle: nil).instantiateViewController(withIdentifier: "DetailCommentDiaryViewController") as? DetailCommentDiaryViewController else { return }
                presentingVC.pushViewController(vc, animated: true)
            }
        })
        
    }
}
