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
    func onCountLabelChange(data: Bool) {
        textCountLabel.isHidden = data
    }
    
    func onCommentViewChange(data: Bool) {
        saveButton.isEnabled = data
        //true 혼자보기
        //false 코멘트쓰기
    }
    
    func onButtonChange(data: Bool) {
        commentView.isHidden = data
    }
    
    //MARK: - Properties
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
    }
    
    func bottomsheetSetting() {
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
        WritingDiaryRequest.date = "2022.02.25" //수정하기
        WritingDiaryRequest.deliveryYn = "N" //수정하기
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

