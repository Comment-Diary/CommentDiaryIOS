//
//  NEditViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/05.
//

import Foundation
import UIKit

//let diaryID =  UserDefaults.standard.value(forKey: "DiaryID") ?? ""

class NEidtViewController: UIViewController, UITextViewDelegate {
    var dateString = ""
    var titleString = ""
    var contentString = ""
    //MARK: - Properties
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var diartScrollView: UIScrollView!
    
    @IBOutlet weak var diaryTitleView: UIView!
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var diaryContentView: UIView!
    
    @IBOutlet weak var dairyContentTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        buttonSetting()
        
        dateLabel.text = dateString
        titleTextView.text = titleString
        dairyContentTextView.text = contentString
        
        titleTextView.delegate = self
        dairyContentTextView.delegate = self
    }
    
    

    
    func viewSetting() {
        self.topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        self.separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        self.diartScrollView.backgroundColor = UIColor(hex: 0xFDFCF9)
        self.diartScrollView.layer.cornerRadius = 10
        self.diaryTitleView.backgroundColor = UIColor(hex: 0xFDFCF9)
        self.titleTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        self.diaryContentView.backgroundColor = UIColor(hex: 0xFDFCF9)

        self.dairyContentTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        
        
        
    }
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleTextView.textColor = UIColor(hex: 0x4E4C49)
        titleTextView.font = UIFont.AppleSDGothic(.bold, size: 21)
        dairyContentTextView.textColor = UIColor(hex: 0x4E4C49)
        dairyContentTextView.font = UIFont.AppleSDGothic(.medium, size: 15)
        
    }
    
    func buttonSetting() {
        saveButton.backgroundColor = UIColor(hex: 0x73BF90)
        
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        saveButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        saveButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if titleTextView.text.isEmpty && dairyContentTextView.text.isEmpty {
            titleTextView.text = "제목을 입력해주세요."
            titleTextView.textColor = UIColor(hex: 0xE2DFD7)
            dairyContentTextView.text = "내용을 입력해주세요."
            dairyContentTextView.textColor = UIColor(hex: 0xE2DFD7)
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if titleTextView.textColor == UIColor(hex: 0xE2DFD7) {
            titleTextView.text = nil
            titleTextView.textColor = UIColor.black
        }
        if dairyContentTextView.textColor == UIColor(hex: 0xE2DFD7) {
            dairyContentTextView.text = nil
            dairyContentTextView.textColor = UIColor.black
        }
    }


    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        //이전 화면으로 돌아가기
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        if titleTextView.text.count == 0 || dairyContentTextView.text == "제목을 입력해주세요." || dairyContentTextView.text.count == 0 || dairyContentTextView.text == "내용을 입력해주세요." {
            self.presentBottomAlert(message: "제목과 내용을 입력해주세요")
        } else {
            //        API 일기 수정
            self.showIndicator()
            
            ModifyDiaryRequest.title = titleTextView.text
            ModifyDiaryRequest.content = dairyContentTextView.text
            
            ModifyDiaryDataManager().modifyDiaryPostData(self)
            
        }
        
    }
    
    
}

    //MARK: - Extensions
extension NEidtViewController {
    func editDiarySuccessResponse(_ response: ModifyDiaryResopnse) {
        self.dismissIndicator()
        
        self.presentBottomAlert(message: "수정이 완료되었어요.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.navigationController?.popToRootViewController(animated: true)
            UserDefaults.standard.removeObject(forKey: "DiaryID")
        })

    }
}
