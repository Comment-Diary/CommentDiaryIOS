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
    
    var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy.MM.dd"
        return df
    }()
    

    
    //일기쓰기API
    var dateText: String = ""
    var deliveryToggle : String = ""
    
    
    func onPreSaveButtonChange(data: Bool) {
        preSaveButton.isHidden = data
    }


    func onCountLabelChange(data: Bool) {
        textCountLabel.isHidden = data

        
        //일기 혼자쓰기 or 코멘트받기
        if textCountLabel.isHidden == true {
            //혼자보기
            deliveryToggle = "N"
        } else {
            //코멘트 받기
            deliveryToggle = "Y"
            print(deliveryToggle, "????")
        }
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
    
    
    @IBOutlet weak var preSaveButton: UIButton!
    
    
    @IBOutlet weak var diaryDate: UILabel!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var diaryScrollView: UIScrollView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
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
        preSaveButtonSetting()
        
        
        dateLabelSetting()
        
        self.diaryDate.text = self.dateFormatter.string(from: Date())
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDayDate"), object: nil)


    }

    
    func dateLabelSetting() {

        
    }
    @objc func loadData(_ notification : NSNotification) {
        diaryDate.text = notification.object as? String ?? ""
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
        //API 일기 작성
        self.showIndicator()
        
        WritingDiaryRequest.title = titleTextView.text ?? ""
        WritingDiaryRequest.content = contentTextView.text ?? ""
        WritingDiaryRequest.date = dateText // or diaryText
        WritingDiaryRequest.deliveryYn = deliveryToggle
        WritingDiaryDataManager().writingDiaryPostData(self)
        
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func preSaveButtonTap(_ sender: Any) {
        //제목 임시저장
        UserDefaults.standard.set(titleTextView.text!, forKey: "diaryTitle")
        //내용 임시저장
        UserDefaults.standard.set(contentTextView.text!, forKey: "diaryContent")
        //날짜 임시저장
        UserDefaults.standard.set(diaryDate.text!, forKey: "diaryDate")
        let vc = UIStoryboard(name: "YPreSave", bundle: nil).instantiateViewController(withIdentifier: "YPreSaveViewController") as! YPreSaveViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
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
//조건 만들기 혼자 쓰는 일기 or 코멘트 일기에 따라 화면 전환이 다름
        if deliveryToggle == "Y" { //보여주기
            let yPreSaveVC = UIStoryboard(name: "YPreSave", bundle: nil).instantiateViewController(withIdentifier: "YPreSaveViewController") as! YPreSaveViewController
            self.navigationController?.pushViewController(yPreSaveVC, animated: true)
        } else if deliveryToggle == "N" { //혼자쓰기
            let nSaveVC = UIStoryboard(name: "NSave", bundle: nil).instantiateViewController(withIdentifier: "NSaveViewController") as! NSaveViewController
            nSaveVC.dateString = diaryDate.text ?? ""
            nSaveVC.titleString = titleTextView.text
            nSaveVC.contentString = contentTextView.text
            self.navigationController?.pushViewController(nSaveVC, animated: true)
        }
        

        
    }
}

extension UINavigationController {
    func popViewControllerWithHandler(animated:Bool = true, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }

    func pushViewController(viewController: UIViewController, animated:Bool = true,  completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
