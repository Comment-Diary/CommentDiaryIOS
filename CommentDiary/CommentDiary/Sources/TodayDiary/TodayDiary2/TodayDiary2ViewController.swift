//
//  TodayDiary2ViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/06/28.
//

import Foundation
import UIKit

class TodayDiary2ViewController : UIViewController, DiaryType {
    func diaryTypeString(data: String) {
        getDiaryType(diaryType: data)
    }
    var canSendCommentDiary : Bool = false
    
    //키보드 노티피케이션
    var textViewYValue = CGFloat(0)
    
    var todayDiary = TodayDiaryModel()
    var commentDiaryType = true
    var diaryTypeButtonText = "코멘트 받는 일기"
    var dateString = ""
    var diaryTypeColor = hexColor.dateGreenColor.getHexColor()
    var diaryTypeCountText = 0
    
    
    enum diaryTypeText {
        case commemtDiary
        case aloneDiary
        
        func getDiaryText() -> String {
            switch self {
            case .commemtDiary:
                return "코멘트 받는 일기"
            case .aloneDiary:
                return "혼자 쓰는 일기"
            }
        }
    }
    
    func getDiaryType(diaryType : String) {
        switch diaryType {
        case "코멘트 받는 일기":
            diaryTypeButtonText = diaryTypeText.commemtDiary.getDiaryText()
            dateLabel.textColor = hexColor.dateGreenColor.getHexColor()
            diaryTypeButton.setTitle(diaryTypeButtonText, for: .normal)
            diaryTypeButton.setTitle(diaryTypeButtonText, for: .highlighted)
            sendButton.backgroundColor = hexColor.sendButtonBackgroundColor.getHexColor()
            sendButton.setTitleColor(hexColor.sendButtonTitleColor.getHexColor(), for: .normal)
            sendButton.setTitleColor(hexColor.sendButtonTitleColor.getHexColor(), for: .highlighted)
        case "혼자 쓰는 일기":
            diaryTypeButtonText = diaryTypeText.aloneDiary.getDiaryText()
            dateLabel.textColor = hexColor.dateOrangeColor.getHexColor()
            diaryTypeButton.setTitle(diaryTypeButtonText, for: .normal)
            diaryTypeButton.setTitle(diaryTypeButtonText, for: .highlighted)
            sendButton.backgroundColor = .clear
            sendButton.setTitleColor(hexColor.sendButtonBackgroundColor.getHexColor(), for: .normal)
            sendButton.setTitleColor(hexColor.sendButtonBackgroundColor.getHexColor(), for: .highlighted)
        default:
            break
        }
    }
    
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
        keyboardCheck()
    }
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.addKeyboardNotification()
        print("rrrr")
//        addKeyboardNotification()
        keyboardWillShowFunc()
    }
    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.removeKeyboardNotification()
        keyboardWillHideFunc()
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
        dateLabel.text = dateString
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
        diaryTypeButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        diaryTypeButton.setTitleColor(hexColor.diaryTypeButtonColor.getHexColor(), for: .normal)
        diaryTypeButton.setTitleColor(hexColor.diaryTypeButtonColor.getHexColor(), for: .highlighted)
        diaryTypeButton.setTitle(diaryTypeButtonText, for: .normal)
        diaryTypeButton.setTitle(diaryTypeButtonText, for: .highlighted)
        sendButton.setTitleColor(hexColor.sendButtonTitleColor.getHexColor(), for: .normal)
        sendButton.setTitleColor(hexColor.sendButtonTitleColor.getHexColor(), for: .highlighted)
        sendButton.setTitle("전송", for: .normal)
        sendButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 13)
        sendButton.backgroundColor = hexColor.sendButtonBackgroundColor.getHexColor()
        sendButton.layer.cornerRadius = 10
        
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
        if diaryTypeButtonText == diaryTypeText.commemtDiary.getDiaryText() {
            //저장
        }
        else if diaryTypeButtonText == diaryTypeText.aloneDiary.getDiaryText()  {
            let vc = UIStoryboard(name: "WritingDiaryCancel", bundle: nil).instantiateViewController(withIdentifier: "WritingDiaryCancelAlertViewController") as! WritingDiaryCancelAlertViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func diaryTypeButtonClicked(_ sender: UIButton) {
        guard let topSheetVC = UIStoryboard(name: "TopSheet", bundle: nil).instantiateViewController(withIdentifier: "TopSheetViewController") as? TopSheetViewController else { return }
        topSheetVC.modalPresentationStyle = .overFullScreen
        topSheetVC.modalTransitionStyle = .crossDissolve
        topSheetVC.diaryTypeDelegate = self
        if diaryTypeButtonText == diaryTypeText.commemtDiary.getDiaryText() {
            topSheetVC.commentDiary = true
        }
        else {
            topSheetVC.commentDiary = false
        }
        self.present(topSheetVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveDiaryButtonClicked(_ sender: UIButton) {
        if diaryTypeButtonText == diaryTypeText.commemtDiary.getDiaryText() {
            
        }
        else if diaryTypeButtonText == diaryTypeText.aloneDiary.getDiaryText() {
            
        }
    }
}















    //MARK: - Extensions
extension TodayDiary2ViewController {
////    스크롤시 키보드 내리기
    func keyboardCheck() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
    }
    func keyboardWillShowFunc() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    func keyboardWillHideFunc() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func keyboardDidShowFunc() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("키보드 will show")
            if textViewYValue == 0 {
                textViewYValue = self.diaryCountView.frame.origin.y
            }
            if self.diaryCountView.frame.origin.y == textViewYValue {
                textViewYValue = self.diaryCountView.frame.origin.y
                self.diaryCountView.frame.origin.y -= keyboardSize.height - UIApplication.shared.windows.first!.safeAreaInsets.bottom
            }
//            if self.diaryCountView.frame.origin.y == 0 {
//                self.diaryCountView.frame.origin.y += keyboardSize.height + UIApplication.shared.windows.first!.safeAreaInsets.bottom
//            }
        }
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("키보드 did show")
            if textViewYValue == 0 {
                textViewYValue = self.diaryCountView.frame.origin.y
            }
            if self.diaryCountView.frame.origin.y == textViewYValue {
                textViewYValue = self.diaryCountView.frame.origin.y
                self.diaryCountView.frame.origin.y -= keyboardSize.height - UIApplication.shared.windows.first!.safeAreaInsets.bottom
            }
//            if self.diaryCountView.frame.origin.y == 0 {
//                self.diaryCountView.frame.origin.y += keyboardSize.height + UIApplication.shared.windows.first!.safeAreaInsets.bottom
//            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {

        print("키보드 will hide")
        if self.diaryCountView.frame.origin.y != textViewYValue {
            self.diaryCountView.frame.origin.y = textViewYValue
        }
//        if self.diaryCountView.frame.origin.y != 0 {
//            self.diaryCountView.frame.origin.y = 0
//        }
    }
    
}




extension TodayDiary2ViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textviewdidendEditing")
        if titleTextView.text.isEmpty {
            titleTextView.text = textViewPlaceholder.title.getPlaceholderString()
            titleTextView.textColor = hexColor.placeholderColor.getHexColor()
        }
        else if contentTextView.text.isEmpty {
            contentTextView.text = textViewPlaceholder.content.getPlaceholderString()
            contentTextView.textColor = hexColor.placeholderColor.getHexColor()
        }
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == hexColor.placeholderColor.getHexColor() {
            textView.text = nil
            textView.textColor = hexColor.textviewStringColor.getHexColor()
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == hexColor.placeholderColor.getHexColor() {
            textView.text = nil
            textView.textColor = hexColor.textviewStringColor.getHexColor()
        }
            print("textviewDidBeginEditing")
            if textView == titleTextView && titleTextView.textColor == hexColor.placeholderColor.getHexColor() {
                titleTextView.text = nil
                titleTextView.textColor = hexColor.textviewStringColor.getHexColor()
            }
            if textView == contentTextView && contentTextView.textColor == hexColor.placeholderColor.getHexColor() {
                contentTextView.text = nil
                contentTextView.textColor = hexColor.textviewStringColor.getHexColor()
            }

    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == contentTextView {
            let currentText = contentTextView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            let changedText = currentText.replacingCharacters(in: stringRange, with: text)
            if diaryTypeButtonText == diaryTypeText.commemtDiary.getDiaryText() {
                if changedText.count < 100 {
                    canSendCommentDiary = false
                }
                else {
                    canSendCommentDiary = true
                }

            }
            
            
        }
        return true
    }


}
