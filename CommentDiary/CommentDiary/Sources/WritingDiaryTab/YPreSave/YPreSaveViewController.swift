//
//  YPreSaveViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/01.
//

import Foundation
import UIKit

class YPreSaveViewController: UIViewController {

    //MARK: - Properties
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentBackView: UIView!
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var diaryScrollView: UIScrollView!
    
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var topBackView: UIView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        buttonSetting()
        userDefaultSetting()
    }
    
    func userDefaultSetting() {
        let titleText = UserDefaults.standard.value(forKey: "diaryTitle") ?? ""
        let contentText = UserDefaults.standard.value(forKey: "diaryContent") ?? ""
        let dateText = UserDefaults.standard.value(forKey: "diaryDate") ?? ""
        let contentTextCount = UserDefaults.standard.value(forKey: "contentCount") ?? 0
        titleLabel.text = titleText as? String
        contentLabel.text = contentText as? String
        dateLabel.text = dateText as? String
//        contentCountLabel.text = "\(contentTextCount)/100" //기준점 넘으면 버튼 활성화 비활성화
    }
    
    
    func viewSetting() {
        diaryScrollView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryScrollView.layer.cornerRadius = 10
        titleBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        
    }
    func labelSetting() {
        
    }
    func buttonSetting() {
        sendButton.backgroundColor = UIColor(hex: 0x73BF90)
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
    }
    
    //MARK: - Actions
    
    
    @IBAction func sendButtonTap(_ sender: Any) {
        //조건 달기 count수
        self.showIndicator()
        
        WritingDiaryRequest.title = titleLabel.text ?? ""
        WritingDiaryRequest.content = contentLabel.text ?? ""
        WritingDiaryRequest.date = dateLabel.text ?? ""
        WritingDiaryRequest.deliveryYn = "Y"
//        WritingDiaryEditDataManager().writingDiaryPostData(self)
        
        

    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        //루트뷰로 화면전환
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteButtonTap(_ sender: Any) {
        //삭제, 삭제 alert
        //userdefault내용 삭제
        UserDefaults.standard.removeObject(forKey: "diaryTitle")
        UserDefaults.standard.removeObject(forKey: "diaryContent")
        UserDefaults.standard.removeObject(forKey: "diaryDate")
        let vc = UIStoryboard(name: "DeleteCheck", bundle: nil).instantiateViewController(withIdentifier: "DeleteCheckAlertViewController")
        self.present(vc, animated: true)
        
    }
    
    @IBAction func editButtonTap(_ sender: Any) {
        //수정하기 화면전환
    }
    
    
}

    //MARK: - Extensions
extension YPreSaveViewController {
    
}
