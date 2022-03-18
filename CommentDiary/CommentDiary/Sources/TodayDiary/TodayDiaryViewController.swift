//
//  TodayDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/18.
//

import Foundation
import UIKit
import PanModal

class TodayDiaryViewController: UIViewController, commentViewChangeDelegate, buttonChangeDelegate, countLabelChangeDelegate, preSaveButtonChangeDelegate {
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy.MM.dd"
        return df
    }()
    

    
    //일기쓰기API
    var dateText: String = ""
    var deliveryToggle : String = ""
    var tempToggle : String = ""
    
    
    //코멘트 일기 100자 조건
    var canSendDiaryBool : Bool = false

    
    
    func onPreSaveButtonChange(data: Bool) {
        preSaveButton.isHidden = data
    }


    func onCountLabelChange(data: Bool) {
        textCountLabel.isHidden = data

        
        //일기 혼자쓰기 or 코멘트받기
        if textCountLabel.isHidden == true {
            //혼자보기
            deliveryToggle = "N"
            tempToggle = "N"
        } else {
            //코멘트 받기
            deliveryToggle = "Y"
            tempToggle = "N"
            saveButton.setTitle("전송하기", for: .normal)
            baseBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
            print(deliveryToggle, "????")
        }
    }
    
    func onCommentViewChange(data: Bool) {
//        saveButton.isEnabled = data
//        //true 혼자보기
//        //false 코멘트쓰기
    }
    
    func onButtonChange(data: Bool) {
        commentAlertLabel.isHidden = data
    }

    //MARK: - Properties
    
    @IBOutlet weak var allBackView: UIView!
    
    @IBOutlet weak var preSaveButton: UIButton!
    
    
    @IBOutlet weak var commentAlertLabel: UILabel!
    
    @IBOutlet weak var baseBackView: UIView!
    
    @IBOutlet weak var diaryDate: UILabel!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var diaryScrollView: UIScrollView!
    @IBOutlet weak var contentTextView: UITextView!
    
//    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var separateBarView: UIView!
    
//    @IBOutlet weak var commentPickedLabel: UILabel!
//    @IBOutlet weak var commentNBackView: UIView!
    
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    @IBOutlet weak var topBackView: UIView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()


        bottomsheetSetting()
        
        titleTextView.delegate = self
        contentTextView.delegate = self
        diaryScrollView.delegate = self
        viewSetting()
        textViewPlaceholderSetting()
        countLabelSetting()
        toggleSetting()
        preSaveButtonSetting()
        buttonSetting()
        labelSetting()
        
        
        dateLabelSetting()
        textViewSetting()
        


    }
    
 
    
    func textViewSetting() {
        contentTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        titleTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    


    
    func dateLabelSetting() {
        self.diaryDate.text = self.dateFormatter.string(from: Date())
        self.diaryDate.text = dateText
        
    }
  
    
    func toggleSetting() {
        deliveryToggle = "N"
    }
    
    func preSaveButtonSetting() {
        preSaveButton.isHidden = true
    }
    
    
    func countLabelSetting() {
        textCountLabel.text = "0/100"
    }
    
    func textViewPlaceholderSetting() {
        titleTextView.text = "제목을 입력해주세요."
        titleTextView.textColor = UIColor(hex: 0xE2DFD7)
        contentTextView.text = "내용을 입력해주세요."
        contentTextView.textColor = UIColor(hex: 0xE2DFD7)
    }
    
    func labelSetting() {
        diaryDate.textColor = UIColor(hex: 0xFFAC86)
        diaryDate.font = UIFont.AppleSDGothic(.bold, size: 15)
        commentAlertLabel.textColor = UIColor(hex: 0x878379)
        commentAlertLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    func buttonSetting() {
        saveButton.backgroundColor = UIColor(hex: 0x73BF90)
        saveButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        saveButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        
        preSaveButton.setTitle("임시저장", for: .normal)
        preSaveButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .normal)
        preSaveButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .highlighted)
        preSaveButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 15)
        
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        diaryScrollView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryScrollView.layer.cornerRadius = 10
        separateBarView.backgroundColor = UIColor(hex: 0xE2DFD7)
        allBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        allBackView.layer.cornerRadius = 10
        titleBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        baseBackView.layer.cornerRadius = 10
        baseBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        
        
        
        //초기 비활성화
        commentAlertLabel.isHidden = true
        textCountLabel.isHidden = true
    }
    
    func bottomsheetSetting() {
        //조건달기
            let todayDiaryBottomVC = UIStoryboard(name: "TodayDiaryBottom", bundle: nil).instantiateViewController(withIdentifier: "TodayDiaryBottomViewController") as! TodayDiaryBottomViewController
        
        
            todayDiaryBottomVC.preSaveButtonDelegate = self
            todayDiaryBottomVC.countLabelChangeDelegate = self
            todayDiaryBottomVC.buttonChangeDelegate = self
            todayDiaryBottomVC.commentViewDelegate = self
            self.presentPanModal(todayDiaryBottomVC)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    
    
    //MARK: - Actions
    
    @IBAction func saveTapButton(_ sender: Any) {
        //혼자쓰는 일기
        if deliveryToggle == "N" {
            if titleTextView.text.count == 0 || titleTextView.text == "제목을 입력해주세요." || contentTextView.text.count == 0 || contentTextView.text == "내용을 입력해주세요." {
                self.presentBottomAlert(message: "제목과 내용을 입력해주세요.")
            } else {
                self.showIndicator()

                WritingDiaryRequest.title = titleTextView.text ?? ""
                WritingDiaryRequest.content = contentTextView.text ?? ""
                WritingDiaryRequest.date = dateText
                WritingDiaryRequest.deliveryYn = deliveryToggle
                WritingDiaryRequest.tempYn = tempToggle
                WritingDiaryDataManager().writingDiaryPostData(self)
            }
        }
        //코멘트 일기
        else if deliveryToggle == "Y" {
            //100자를 못채움, 제목 안씀
            if canSendDiaryBool == false && (titleTextView.text.count == 0 || titleTextView.text == "제목을 입력해주세요") {
                self.presentBottomAlert(message: "내용 100자 이상 입력해주세요.")
            }
            //100wk 못채움, 제목 씀
            else if canSendDiaryBool == false && titleTextView.text.count != 0 {
                self.presentBottomAlert(message: "내용 100자 이상 입력해주세요.")
            }
            //100자를 채움, 제목 안씀
            else if canSendDiaryBool == true && (titleTextView.text.count == 0 || titleTextView.text == "제목을 입력해주세요.") {
                self.presentBottomAlert(message: "제목을 입력해주세요.")
            }
            //100자 채움, 제목 채움
            else if canSendDiaryBool == true && titleTextView.text.count != 0 {
                let vc = UIStoryboard(name: "SendDiaryAlert", bundle: nil).instantiateViewController(withIdentifier: "SendDiaryAlertViewController") as! SendDiaryAlertViewController
                vc.commentDiaryDate = dateText
                vc.commentDiaryTitle = titleTextView.text ?? ""
                vc.commentDiaryContent = contentTextView.text ?? ""
                vc.commentDiaryTemyYn = tempToggle
                print(tempToggle, "코멘트 일기 쓸때 tempToggle 값 N이 나와야함")
                vc.commentDiaryDeliveryYn = deliveryToggle
                print(deliveryToggle, "코멘트 일기 쓸때 deliveryToggle값 Y나와야함")
                present(vc, animated: true, completion: nil)
            }
        }


        
        

        
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        let vc = UIStoryboard(name: "DiaryStop", bundle: nil).instantiateViewController(withIdentifier: "DiaryStopViewController") as! DiaryStopViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func preSaveButtonTap(_ sender: Any) {
//        //제목 임시저장
//        UserDefaults.standard.set(titleTextView.text!, forKey: "diaryTitle")
//        //내용 임시저장
//        UserDefaults.standard.set(contentTextView.text!, forKey: "diaryContent")
//        //날짜 임시저장
//        UserDefaults.standard.set(diaryDate.text!, forKey: "diaryDate")
//        let vc = UIStoryboard(name: "YPreSave", bundle: nil).instantiateViewController(withIdentifier: "YPreSaveViewController") as! YPreSaveViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
        if titleTextView.text.count == 0 || titleTextView.text == "제목을 입력해주세요." || contentTextView.text.count == 0 || contentTextView.text == "내용을 입력해주세요." {
            self.presentBottomAlert(message: "제목과 내용을 입력해주세요.")
        } else {
            tempToggle = "Y"
            self.showIndicator()
            
            //API 일기 작성, 임시 저장
            WritingDiaryRequest.title = titleTextView.text ?? ""
            WritingDiaryRequest.content = contentTextView.text ?? ""
            WritingDiaryRequest.date = dateText
            WritingDiaryRequest.deliveryYn = deliveryToggle
            WritingDiaryRequest.tempYn = tempToggle
            WritingDiaryDataManager().writingDiaryPostData(self)
        }
        
    }
    

    
}

    //MARK: - Extenstions
extension TodayDiaryViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == contentTextView {
            let currentText = contentTextView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let chagnedText = currentText.replacingCharacters(in: stringRange, with: text)
            //일기카운트 임시저장
            UserDefaults.standard.set(chagnedText.count, forKey: "contentCount")
            textCountLabel.text = "\(chagnedText.count)/100"
            
            // 혼자 쓰기일떄는 카운트 필요없음
            // 코멘트 받기 쓰기는 초기 button false
            if deliveryToggle == "Y" {
                if chagnedText.count < 100 {
                    canSendDiaryBool = false
                } else {
                    canSendDiaryBool = true
                }
            return true
                
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
//        if contentTextView.text.isEmpty {
//            contentTextView.text = "내용을 입력해주세요."
//            contentTextView.textColor = UIColor(hex: 0xE2DFD7)
//        }
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

//API
extension TodayDiaryViewController {
    func writingDiarySucessResponse(_ response: WritingDiaryResponse) {
        self.dismissIndicator()
//조건 만들기 혼자 쓰는 일기 or 코멘트 일기에 따라 화면 전환이 다름
        if deliveryToggle == "Y" {
            //임시저장
            if tempToggle == "Y" {
                
            }
            //코멘트 일기
            else if tempToggle == "N" {
 
            }
            
//            let yPreSaveVC = UIStoryboard(name: "YPreSave", bundle: nil).instantiateViewController(withIdentifier: "YPreSaveViewController") as! YPreSaveViewController
//            self.navigationController?.pushViewController(yPreSaveVC, animated: true)
        } else if deliveryToggle == "N" {
            //혼자쓰기
            let nSaveVC = UIStoryboard(name: "NSave", bundle: nil).instantiateViewController(withIdentifier: "NSaveViewController") as! NSaveViewController
            nSaveVC.diaryidInt = response.result.id
            nSaveVC.diaryCheckToggle = false
            nSaveVC.dateString = diaryDate.text ?? ""
            nSaveVC.titleString = titleTextView.text
            nSaveVC.contentString = contentTextView.text
            self.navigationController?.pushViewController(nSaveVC, animated: true)
        }
        

        
    }
}

