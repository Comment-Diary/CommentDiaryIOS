//
//  YEditViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/19.
//

import Foundation
import UIKit


class YEditViewController : UIViewController {
    var dateString = ""
    var titleString = ""
    var contentString = ""
    var diaryID : Int = 0
    var canDeliveryBool : Bool = false
    //MARK: - Properties
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var preSaveButton: UIButton!
    
    @IBOutlet weak var sendButton: CornerButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    
    @IBOutlet weak var separateView: UIView!
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var scrollBackView: UIView!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var allBackView: UIView!
    
    @IBOutlet weak var contentAllBackView: UIView!
    
    @IBOutlet weak var diaryScrollView: UIScrollView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        buttonSetting()
        labelSetting()
        textViewSetting()
        navigationBackSwipeMotion()
        
        contentTextView.delegate = self
        diaryScrollView.delegate = self
        
        

    }
    func navigationBackSwipeMotion() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextView.text = titleString
        contentTextView.text = contentString
        dateLabel.text = dateString
        countLabel.text = "\(contentTextView.text.count)/100"
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func viewSetting() {
        
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        separateView.backgroundColor =  UIColor(hex: 0xE2DFD7)
        contentAllBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentAllBackView.layer.cornerRadius = 10
        allBackView.layer.cornerRadius = 10
        allBackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        allBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        allBackView.layer.cornerRadius = 10
        scrollBackView.layer.cornerRadius = 10
        diaryScrollView.layer.cornerRadius = 10
        titleBackView.layer.cornerRadius = 10
        titleBackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        titleBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    func buttonSetting() {
        preSaveButton.setTitle("임시저장", for: .normal)
        preSaveButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .normal)
        preSaveButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .highlighted)
        preSaveButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 15)
        
        sendButton.backgroundColor = UIColor(hex: 0x73BF90)
        sendButton.setTitle("전송하기", for: .normal)
        sendButton.setTitle("전송하기", for: .highlighted)
        sendButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        sendButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        sendButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
    }
    
    func labelSetting() {

        
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        infoLabel.text = "내용을 100자 이상 입력해주세요."
        infoLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        infoLabel.textColor = UIColor(hex: 0x5F5D59)
        countLabel.textColor = UIColor(hex: 0x878379)
        countLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        
        
    }
    func textViewSetting() {
        titleTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        titleTextView.textColor = UIColor(hex: 0x4E4C49)
        titleTextView.font = UIFont.AppleSDGothic(.bold, size: 21)
        

        
        

    }
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    @IBAction func preSaveButtonTap(_ sender: Any) {
        if titleTextView.text.count == 0 || contentTextView.text.count == 0 || titleTextView.text == "제목을 입력해주세요." || contentTextView.text == "내용을 입력해주세요." {
            self.presentBottomAlert(message: "제목과 내용을 입력해주세요.")
        } else {
            self.showIndicator()
            ModifyDiaryRequest.title = titleTextView.text ?? ""
            ModifyDiaryRequest.content = contentTextView.text ?? ""
            ModifyDiaryRequest.deliveryYn = "Y"
            ModifyDiaryRequest.temyYn = "Y"
            YModifyDiaryDataManager().modifyDiaryPostData(self, diaryID)
        }
    }
    

    
    @IBAction func sendButtonTap(_ sender: Any) {
        if canDeliveryBool == false {
            self.presentBottomAlert(message: "내용을 100자 이상 입력해주세요")
        }
        else if canDeliveryBool == true {
            let modifySendDiaryVC = UIStoryboard(name: "ModifySendDiaryAlert", bundle: nil).instantiateViewController(withIdentifier: "ModifySendDiaryAlertViewController") as! ModifySendDiaryAlertViewController
            
            modifySendDiaryVC.commentDiaryID = self.diaryID
            modifySendDiaryVC.commentDiaryTitle = self.titleTextView.text ?? ""
            modifySendDiaryVC.commentDiaryContent = self.contentTextView.text ?? ""
            modifySendDiaryVC.commentDiaryDate = self.dateLabel.text ?? ""
            print(modifySendDiaryVC.commentDiaryID, "보내는 id 값")
            print(modifySendDiaryVC.commentDiaryDate, "보내는 날짜 값")
            print(modifySendDiaryVC.commentDiaryTitle, "보내는 제목")
            print(modifySendDiaryVC.commentDiaryContent, "보내는 내용")
            
            present(modifySendDiaryVC, animated: true, completion: nil)
        }
    }
    
    
}

    //MARK: - Extensions
extension YEditViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == contentTextView {
            let currentText = contentTextView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let chagnedText = currentText.replacingCharacters(in: stringRange, with: text)
            
            countLabel.text = "\(chagnedText.count)/100"
            
            if chagnedText.count < 100 {
                canDeliveryBool = false
            }
            else if chagnedText.count >= 100 {
                canDeliveryBool = true
            }
        }
        return true
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if titleTextView.text.isEmpty && contentTextView.text.isEmpty {
            titleTextView.text = "제목을 입력해주세요."
            titleTextView.textColor = UIColor(hex: 0xE2DFD7)
            contentTextView.text = "내용을 입력해주세요."
            contentTextView.textColor = UIColor(hex: 0xE2DFD7)
        }

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if titleTextView.textColor == UIColor(hex: 0xE2DFD7) {
            titleTextView.text = nil
            titleTextView.textColor = UIColor(hex: 0x4E4C49)
        }
        if contentTextView.textColor == UIColor(hex: 0xE2DFD7) {
            contentTextView.text = nil
            contentTextView.textColor = UIColor(hex: 0x4E4C49)
        }
    }
}


extension YEditViewController {
    func yEditSuccess(_ response: ModifyDiaryResopnse) {
        self.dismissIndicator()
        self.presentBottomAlert(message: "수정이 완료되었어요.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
}
