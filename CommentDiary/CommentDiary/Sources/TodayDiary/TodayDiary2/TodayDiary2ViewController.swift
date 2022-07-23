//
//  TodayDiary2ViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/06/28.
//

import Foundation
import UIKit

class TodayDiary2ViewController : UIViewController {
    var todayDiary = TodayDiaryModel()
    
    
    // MARK: - DiaryType
    
    
    // MARK: - color
    enum hexColor {
        case backgroundColor
        case sendButtonBackgroundColor
        case sendButtonTitleColor
        case dateGreenColor
        case dateOrangeColor
        case topSeparateViewColor
        case placeholderColor
        case titleSeparateColor
        case contentCountLabelColor
        case textviewStringColor
        case diaryTypeButtonColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .sendButtonBackgroundColor:
                return UIColor(hex: 0x5ABD80)
            case .sendButtonTitleColor:
                return UIColor(hex: 0xFDFCF9)
            case .dateGreenColor:
                return UIColor(hex: 0x5ABD80)
            case .dateOrangeColor:
                return UIColor(hex: 0xFFA665)
            case .topSeparateViewColor:
                return UIColor(hex: 0xF4F1EB)
            case .placeholderColor:
                return UIColor(hex: 0xE2DFD7)
            case .titleSeparateColor:
                return UIColor(hex: 0xE2DFD7)
            case .contentCountLabelColor:
                return UIColor(hex: 0x878379)
            case .textviewStringColor:
                return UIColor(hex: 0x5F5D59)
            case .diaryTypeButtonColor:
                return UIColor(hex: 0x4E4C49)
            }
        }
    }
    // MARK: - textPlaceholder
    enum textViewPlaceholder {
        case title
        case content
        
        func getPlaceholderString() -> String {
            switch self {
            case .title:
                return "제목을 입력해주세요"
            case .content:
                return "내용을 입력해주세요."
            }
        }
    }
    
    
    //MARK: - PROPERTIES
    
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var diaryTypeButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var topSeparateView: UIView!
    @IBOutlet weak var scrollBackView: UIView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollSeparateView: UIView!
    @IBOutlet weak var scrollTitleView: UIView!
    @IBOutlet weak var scrollAllView: UIView!
    @IBOutlet weak var diaryCountView: UIView!
    @IBOutlet weak var diaryCountLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.delegate = self
        contentTextView.delegate = self
        viewColorSetting()
        spaceBetweenLines()
        labelSetting()
        textviewSetting()
        buttonSetting()
        
//        diaryTypeTopsheetView.isHidden = true
//        topSheetTopView.isHidden = true
//        topsheetBottomView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.addKeyboardNotification()
        print("rrrr")
        addKeyboardNotification()
    }
    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.removeKeyboardNotification()
        print("////")
    }
    
    // MARK: - Function
    func viewColorSetting() {
        topBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        self.view.backgroundColor = hexColor.backgroundColor.getHexColor()
        scrollBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        scrollContentView.backgroundColor = hexColor.backgroundColor.getHexColor()
        scrollTitleView.backgroundColor = hexColor.backgroundColor.getHexColor()
        scrollAllView.backgroundColor = hexColor.backgroundColor.getHexColor()
        diaryCountView.backgroundColor = UIColor.red
        topSeparateView.backgroundColor = hexColor.topSeparateViewColor.getHexColor()
        scrollSeparateView.backgroundColor = hexColor.titleSeparateColor.getHexColor()
        
    }
    func labelSetting() {
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        dateLabel.textColor = hexColor.dateGreenColor.getHexColor()
    }
    
    func textviewSetting() {
        titleTextView.font = UIFont.AppleSDGothic(.bold, size: 21)
        contentTextView.font = UIFont.AppleSDGothic(.medium, size: 15)
        titleTextView.text = textViewPlaceholder.title.getPlaceholderString()
        contentTextView.text = textViewPlaceholder.content.getPlaceholderString()
        titleTextView.textColor = hexColor.placeholderColor.getHexColor()
        contentTextView.textColor = hexColor.placeholderColor.getHexColor()
        titleTextView.textContainer.lineFragmentPadding = 0
        titleTextView.textContainerInset = .zero
        contentTextView.textContainer.lineFragmentPadding = 0
        contentTextView.textContainerInset = .zero
        contentTextView.backgroundColor = hexColor.backgroundColor.getHexColor()
        titleTextView.backgroundColor = hexColor.backgroundColor.getHexColor()
    }
    
    func buttonSetting() {
        diaryTypeButton.setTitleColor(hexColor.diaryTypeButtonColor.getHexColor(), for: .normal)
        diaryTypeButton.setTitleColor(hexColor.diaryTypeButtonColor.getHexColor(), for: .highlighted)
        
        sendButton.setTitleColor(hexColor.sendButtonTitleColor.getHexColor(), for: .normal)
        sendButton.setTitleColor(hexColor.sendButtonTitleColor.getHexColor(), for: .highlighted)
        sendButton.setTitle("전송", for: .normal)
        sendButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 13)
        sendButton.backgroundColor = hexColor.sendButtonBackgroundColor.getHexColor()
//        sendButton.layer.cornerRadius =
        
    }
    
    func spaceBetweenLines() {
        let paragraghStyle = NSMutableParagraphStyle()
        paragraghStyle.lineHeightMultiple = 1.23
        let titleAttrStirng = NSMutableAttributedString(string: titleTextView.text)
        let contentAttrStirng = NSMutableAttributedString(string: contentTextView.text)
        titleAttrStirng.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraghStyle, range: NSMakeRange(0, titleAttrStirng.length))
        contentAttrStirng.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraghStyle, range: NSMakeRange(0, contentAttrStirng.length))
        titleTextView.attributedText = titleAttrStirng
        contentTextView.attributedText = contentAttrStirng
        
    }
    
    
    //MARK: - ACTIONS
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "WritingDiaryCancel", bundle: nil).instantiateViewController(withIdentifier: "WritingDiaryCancelAlertViewController") as! WritingDiaryCancelAlertViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func diaryTypeButtonClicked(_ sender: UIButton) {
        guard let topSheetVC = UIStoryboard(name: "TopSheet", bundle: nil).instantiateViewController(withIdentifier: "TopSheetViewController") as? TopSheetViewController else { return }
        topSheetVC.modalPresentationStyle = .overFullScreen
        topSheetVC.modalTransitionStyle = .crossDissolve
        self.present(topSheetVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveDiaryButtonClicked(_ sender: UIButton) {
    }
    
    
    
}















    //MARK: - Extensions
extension TodayDiary2ViewController {
    //스크롤시 키보드 내리기
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        removeKeyboardNotification()
    }
    
    //노티피케이션을 추가하는 메서드
    func addKeyboardNotification() {
        //키보드가 나타날 때 앱에게 알리는 메서드
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //키보드가 사라질 때 앱에게 알리는 메서드
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //노티피케이션을 제거하는 메서드
    func removeKeyboardNotification() {
        //키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        //키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification) {
        //키보드 높이만큼 화면을 올려줌
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 1) {
                self.diaryCountView.frame.origin.y -= keyboardHeight
            }
        }
    }
    @objc func keyboardWillHide(_ noti: NSNotification) {
        //키보드의 높이만큼 화면을 내려줌
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 1) {
                self.diaryCountView.frame.origin.y += keyboardHeight
            }
        }
    }
}
extension TodayDiary2ViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        print("bbb")
        if titleTextView.text.isEmpty {
            titleTextView.text = textViewPlaceholder.title.getPlaceholderString()
            titleTextView.textColor = hexColor.placeholderColor.getHexColor()
        }
        else if contentTextView.text.isEmpty {
            contentTextView.text = textViewPlaceholder.content.getPlaceholderString()
            contentTextView.textColor = hexColor.placeholderColor.getHexColor()
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("DDD")
        if textView == titleTextView && titleTextView.textColor == hexColor.placeholderColor.getHexColor() {
            titleTextView.text = nil
            titleTextView.textColor = hexColor.textviewStringColor.getHexColor()
        }
        else if textView == contentTextView && contentTextView.textColor == hexColor.placeholderColor.getHexColor() {
            contentTextView.text = nil
            contentTextView.textColor = hexColor.textviewStringColor.getHexColor()
        }
    }
}
//extension TodayDiaryViewController: UITextViewDelegate {
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//
//        if textView == contentTextView {
//            let currentText = contentTextView.text ?? ""
//            guard let stringRange = Range(range, in: currentText) else { return false }
//            let chagnedText = currentText.replacingCharacters(in: stringRange, with: text)
//            //일기카운트 임시저장
//            UserDefaults.standard.set(chagnedText.count, forKey: "contentCount")
//            textCountLabel.text = "\(chagnedText.count)/100자 이상 작성"
//
//            // 혼자 쓰기일떄는 카운트 필요없음
//            // 코멘트 받기 쓰기는 초기 button false
//            if deliveryToggle == "Y" {
//                if chagnedText.count < 100 {
//                    canSendDiaryBool = false
//                } else {
//                    canSendDiaryBool = true
//                }
//            return true
//
//            }
//        }
