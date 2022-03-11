//
//  ArrivedDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit

//스크롤뷰 키보드 내리기
//https://zeddios.tistory.com/309

//키보드 높이만큼 올리고 내리기
//https://icksw.tistory.com/87

class ArrivedDiaryViewController: UIViewController, UITextViewDelegate {
    //MARK: - Properties
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var arrivalDiaryLabel: UILabel!
    
    @IBOutlet weak var arrivalBackView: UIView!
    
    @IBOutlet weak var commentScrollView: UIScrollView!
    @IBOutlet weak var diaryTitleLabel: UILabel!

    @IBOutlet weak var diaryContentTextView: UITextView!
    
    
    @IBOutlet weak var sendCommentButton: UIButton!
    
    @IBOutlet weak var myCommentTextView: UITextView!
    
    
    @IBOutlet weak var mySendCommentLabel: UILabel!
    
    
    @IBOutlet weak var commentBackView: UIView!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var entireView: UIView!
    
    
    @IBOutlet weak var reportButton: UIButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        myCommentTextView.delegate = self
        commentScrollView.delegate = self
        textLineSpacing()
        viewSetting()
        labelSetting()
        buttonSetting()
        textViewPlaceholdeerSetting()
//        scrollViewDismissKeyboard()
    }
    
    func viewSetting() {
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        commentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        arrivalBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryContentTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        entireView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        
    }
    func labelSetting() {
        commentCountLabel.text = "0/50"
        commentCountLabel.isHidden = false
    }
    func buttonSetting() {
        self.sendCommentButton.isEnabled = false
        self.sendCommentButton.backgroundColor = UIColor(hex: 0x73BF90)
    }
    
    func textViewPlaceholdeerSetting() {
        myCommentTextView.text = "일기를 읽고 따뜻한 코멘트를 달아주세요."
        myCommentTextView.textColor = UIColor(hex: 0xD2D2D2)
    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.addKeyboardNotification()
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        self.removeKeyboardNotification()
//    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        myCommentTextView.resignFirstResponder()
//
//    }
    
//    func scrollViewDismissKeyboard() {
//        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
//        singleTapGestureRecognizer.numberOfTapsRequired = 1
//        singleTapGestureRecognizer.isEnabled = true
//        singleTapGestureRecognizer.cancelsTouchesInView = false
////        commentScrollView.addGestureRecognizer(singleTapGestureRecognizer)
//
//    }
//    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//
//    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    //텍스트 간 간격 조정
    func textLineSpacing() {
        let attrString = NSMutableAttributedString(string: diaryTitleLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        diaryTitleLabel.attributedText = attrString
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if myCommentTextView.text.isEmpty {
            myCommentTextView.text = "일기를 읽고 따뜻한 코멘트를 달아주세요."
            myCommentTextView.textColor = UIColor(hex: 0xD2D2D2)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if myCommentTextView.textColor == UIColor(hex: 0xD2D2D2) {
            myCommentTextView.text = nil
            myCommentTextView.textColor = UIColor(hex: 0x4E4C49)
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == myCommentTextView {
            let currentText = myCommentTextView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let changedText = currentText.replacingCharacters(in: stringRange, with: text)
            commentCountLabel.text = "\(changedText.count)/50"
            if changedText.count >= 1 {
                commentCountLabel.isHidden = false
            }
            
            if changedText.count < 10 {
                sendCommentButton.isEnabled = false
            } else if changedText.count >= 10 {
                sendCommentButton.isEnabled = true
            }
            return true
        }
        return true
    }
    
    
//    //코멘트 쓸 때 뷰 위로 올리기
//    //노티피케이션 추가하는 메서드
//    func addKeyboardNotification() {
//        //키보드가 나타날 때 앱에게 알리는 메서드
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        //키보드가 사라질 때 앱에게 알리는 매서드
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    //키보드 나타났다가는 알림을 받으면 실행할 메서드
//    @objc func keyboardWillShow(_ noti: NSNotification) {
//        //키보드의 높이만큼 화면을 올려줌
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y -= (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!)
//        }
//    }
//    //키보드 사라졌다는 알림을 받으면 실행할 메서드
//    @objc func keyboardWillHide(_ noti: NSNotification) {
//        //키보드의 높이만큼 화면을 내려줌
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y += (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!)
//        }
//    }
//    
//    //노티피케이션 제거하는 메서드
//    func removeKeyboardNotification() {
//        //키보드 나타날 때 앱에게 알리는 메서드 제거
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        //키보드 사라질 때 앱에게 알리는 메서드 제거
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
    //MARK: - Actions
    @IBAction func sendCommentButtonTap(_ sender: UIButton) {
        
        
//        CommentWritingRequest.diaryId
//        CommentWritingRequest.content
//        CommentWritingRequest.date
        
        CommentWritingDataManager().commentWritingPostData(self)
        
    }
    
    @IBAction func reportButtonTap(_ sender: Any) {
        //알람 띄우기
//        DiaryReportRequest.diaryId
//        DiaryReportRequest.content
    }
    
    
}


    //MARK: - Extensions
