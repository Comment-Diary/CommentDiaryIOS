//
//  YPreSaveViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/01.
//

import Foundation
import UIKit

//일기카운트 임시저장
//UserDefaults.standard.set(chagnedText.count, forKey: "contentCount")


class YPreSaveViewController: UIViewController, UIScrollViewDelegate {
    var diaryID : Int = 0
    var commentDiaryBool: Bool = false
    var diaryCount: Int = 0
    var commentDiaryCount: String = ""

    //MARK: - Properties
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    
    @IBOutlet weak var separateView: UIView!
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var scrollBackView: UIView!
    
    
    @IBOutlet weak var allBackView: UIView!
    
    @IBOutlet weak var contentAllBackView: UIView!
    
    @IBOutlet weak var diaryScrollView: UIScrollView!
    

    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.isEditable = false
        contentTextView.isEditable = false
        viewSetting()
        labelSetting()
        buttonSetting()
        textViewSetting()
        diaryScrollView.delegate = self
        
        //API 조회
        PreSaveDiaryCheckDataManager().commentDiaryCheckData(diaryID: diaryID, self)
//        countLabel.text = commentDiaryCount
        navigationBackSwipeMotion()
    }
    func navigationBackSwipeMotion() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    
    func textViewSetting() {
        titleTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        titleTextView.textColor = UIColor(hex: 0x4E4C49)
        titleTextView.font = UIFont.AppleSDGothic(.bold, size: 21)
        contentTextView.textColor = UIColor(hex: 0x4E4C49)
        contentTextView.font = UIFont.AppleSDGothic(.medium, size: 15)
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
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        infoLabel.text = "일기전송은 다가오는 오전 7시에 종료돼요."
        infoLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        infoLabel.textColor = UIColor(hex: 0x5F5D59)
        countLabel.textColor = UIColor(hex: 0x878379)
        countLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        
        
    }
    func buttonSetting() {
        sendButton.backgroundColor = UIColor(hex: 0x73BF90)
        sendButton.setTitle("전송하기", for: .normal)
        sendButton.setTitle("전송하기", for: .highlighted)
        sendButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        sendButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        sendButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
    }
    
    //MARK: - Actions
    
    
    @IBAction func sendButtonTap(_ sender: Any) {
        //조건 달기 count수
        if diaryCount < 100 {
            self.presentBottomAlert(message: "내용 100자 이상 입력해주세요.")
        }
        else if diaryCount >= 100 {
            let modifySendDiaryVC = UIStoryboard(name: "ModifySendDiaryAlert", bundle: nil).instantiateViewController(withIdentifier: "ModifySendDiaryAlertViewController") as! ModifySendDiaryAlertViewController
            modifySendDiaryVC.commentDiaryID = self.diaryID
            print(modifySendDiaryVC.commentDiaryID, "보내는 id 값")
            modifySendDiaryVC.commentDiaryTitle = self.titleTextView.text ?? ""
            print(modifySendDiaryVC.commentDiaryTitle, "보내는 제목")
            modifySendDiaryVC.commentDiaryContent = self.contentTextView.text ?? ""
            print(modifySendDiaryVC.commentDiaryContent, "보내는 내용")
            modifySendDiaryVC.commentDiaryDate = self.dateLabel.text ?? ""
            present(modifySendDiaryVC, animated: true, completion: nil)
            

//            WritingDiaryRequest.title = titleTextView.text ?? ""
//            WritingDiaryRequest.content = contentTextView.text ?? ""
//            WritingDiaryRequest.date = dateLabel.text ?? ""
//            WritingDiaryRequest.deliveryYn = "Y"
        }
        

        
        

    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        //루트뷰로 화면전환
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteButtonTap(_ sender: Any) {
        //삭제, 삭제 alert

        let vc = UIStoryboard(name: "DeleteCheck", bundle: nil).instantiateViewController(withIdentifier: "DeleteCheckAlertViewController") as! DeleteCheckAlertViewController
        vc.diaryId = diaryID
        self.present(vc, animated: true)
        
    }
    
    @IBAction func editButtonTap(_ sender: Any) {
        //수정하기 화면전환
        let yEditVC = UIStoryboard(name: "YEdit", bundle: nil).instantiateViewController(withIdentifier: "YEditViewController") as! YEditViewController
        yEditVC.dateString = self.dateLabel.text ?? ""
        print(yEditVC.dateString, "날짜")
        yEditVC.titleString = self.titleTextView.text ?? ""
        print(yEditVC.titleString, "제목")
        yEditVC.contentString = self.contentTextView.text ?? ""
        print(yEditVC.contentString, "내용")
        yEditVC.diaryID = self.diaryID
        print(yEditVC.diaryID, "id값")
        navigationController?.pushViewController(yEditVC, animated: true)
    }
    
    
}

    //MARK: - Extensions
extension YPreSaveViewController {
    func preSaveDiaryGet(_ response: DiaryCheckResopnse) {
        dateLabel.text = response.result.date
        contentTextView.text = response.result.content
        titleTextView.text = response.result.title
        countLabel.text =  "\(response.result.content.count)/100"
        diaryCount = response.result.content.count
        
    }
}

