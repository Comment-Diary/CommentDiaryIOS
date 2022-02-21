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

class ArrivedDiaryViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var commentScrollView: UIScrollView!
    @IBOutlet weak var diaryTitleLabel: UILabel!
    @IBOutlet weak var diaryContentLabel: UILabel!
    
    @IBOutlet weak var myCommentCountLabel: UILabel!
    
    @IBOutlet weak var sendCommentButton: UIButton!
    
    @IBOutlet weak var myCommentTextView: UITextView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        myCommentTextView.delegate = self
        commentScrollView.delegate = self
        textLineSpacing()
//        scrollViewDismissKeyboard()
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
    }
    
}


    //MARK: - Extensions
extension ArrivedDiaryViewController: UITextViewDelegate {

}
