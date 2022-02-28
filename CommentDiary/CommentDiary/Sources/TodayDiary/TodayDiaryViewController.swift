//
//  TodayDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/18.
//

import Foundation
import UIKit
import PanModal

class TodayDiaryViewController: UIViewController, commentViewChangeDelegate, buttonChangeDelegate, countLabelChangeDelegate {

    
    //일기쓰기API
    var dateText: String = ""
    var deliveryToggle : String = ""
    
    func onToggleChange(data: String) {
        deliveryToggle = data
        print(deliveryToggle, "???")
    }
    func onCountLabelChange(data: Bool) {
        textCountLabel.isHidden = data
        print(textCountLabel.isHidden, "??")
        
        //일기 혼자쓰기 or 코멘트받기
        if textCountLabel.isHidden == true {
            deliveryToggle = "N"
        } else {
            deliveryToggle = "Y"
        }
    }
    
    func onCommentViewChange(data: Bool) {
        saveButton.isEnabled = data
        //true 혼자보기
        //false 코멘트쓰기
        print(saveButton.isEnabled, "???")
    }
    
    func onButtonChange(data: Bool) {
        commentView.isHidden = data
    }

    //MARK: - Properties
    
    @IBOutlet weak var diaryDate: UILabel!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var diaryScrollView: UIScrollView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var todayDiaryLabel: UILabel!
    
    @IBOutlet weak var trashButton: UIButton!
    
    @IBOutlet weak var fixingButton: UIButton!
    
    @IBOutlet weak var commentPickedLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.delegate = self
        contentTextView.delegate = self
        diaryScrollView.delegate = self
        viewSetting()
        bottomsheetSetting()
        textViewPlaceholderSetting()
        countLabelSetting()
        toggleSetting()
        
        
        //오늘 날짜
        self.diaryDate.text = dateText
        if self.diaryDate.text == "" {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy.MM.dd"
            diaryDate.text = dateformatter.string(from: Date())
        }

    }
    
    func toggleSetting() {
        deliveryToggle = "N"
    }
    
    
    func countLabelSetting() {
        textCountLabel.text = "0/100"
    }
    
    func textViewPlaceholderSetting() {
        titleTextView.text = "제목을 입력해주세요."
        titleTextView.textColor = UIColor.lightGray
        contentTextView.text = "내용을 입력해주세요."
        contentTextView.textColor = UIColor.lightGray
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor.red
        //초기 비활성화
        commentView.isHidden = true
        textCountLabel.isHidden = true
    }
    
    func bottomsheetSetting() {
        //조건달기
            let todayDiaryBottomVC = UIStoryboard(name: "TodayDiaryBottom", bundle: nil).instantiateViewController(withIdentifier: "TodayDiaryBottomViewController") as! TodayDiaryBottomViewController
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
        //API 일기 작성
        self.showIndicator()
        
        WritingDiaryRequest.title = titleTextView.text!
        WritingDiaryRequest.content = contentTextView.text!
        WritingDiaryRequest.date = dateText
        WritingDiaryRequest.deliveryYn = deliveryToggle
        WritingDiaryDataManager().writingDiaryPostData(self)
        
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func trashButtonTap(_ sender: Any) {
    }
    
    @IBAction func fixingButtonTap(_ sender: Any) {
    }
    
}

    //MARK: - Extenstions
extension TodayDiaryViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == contentTextView {
            let currentText = contentTextView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let chagnedText = currentText.replacingCharacters(in: stringRange, with: text)
            textCountLabel.text = "\(chagnedText.count)/100"
            
            
            
            // 혼자 쓰기일떄는 카운트 필요없음
            // 코멘트 받기 쓰기는 초기 button false
            if saveButton.isEnabled == false {
                if chagnedText.count < 10 {
                    saveButton.isEnabled = false
                } else {
                    saveButton.isEnabled = true
                }
            }
            


            return true
        }
        
        
        
        return true
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if titleTextView.text.isEmpty {
            titleTextView.text = "제목을 입력해주세요."
            titleTextView.textColor = UIColor.lightGray
        }
        if contentTextView.text.isEmpty {
            contentTextView.text = "내용을 입력해주세요."
            contentTextView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if titleTextView.textColor == UIColor.lightGray {
            titleTextView.text = nil
            titleTextView.textColor = UIColor.black
        }
        if contentTextView.textColor == UIColor.lightGray {
            contentTextView.text = nil
            contentTextView.textColor = UIColor.black
        }
    }
}

//API
extension TodayDiaryViewController {
    func writingDiarySucessResponse() {
        self.dismissIndicator()
        self.navigationController?.popViewController(animated: true)
    }
}

