//
//  YPreSaveViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/01.
//

import Foundation
import UIKit

//일기카운트 임시저장
//UserDefaults.standard.set(chagnedText.count, forKey: "contentCount")


class YPreSaveViewController: UIViewController {
    var diaryID : Int = 0
    var commentDiaryBool: Bool = false
    var commentDiaryCount: Int = 0

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
    
    @IBOutlet weak var allContentView: UIView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        buttonSetting()

        
        //API 조회
        PreSaveDiaryCheckDataManager().commentDiaryCheckData(diaryID: diaryID, self)
    }
    

    
    
    func viewSetting() {
        allContentView.layer.cornerRadius = 10
        diaryScrollView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryScrollView.layer.cornerRadius = 10
        titleBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        titleBackView.layer.cornerRadius = 10
        titleBackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentBackView.layer.cornerRadius = 10
        contentBackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        
        
    }
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        infoLabel.text = "일기전송은 다가오는 오전 7시에 종료돼요."
        infoLabel.textColor = UIColor(hex: 0x878379)
        infoLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        
        
    }
    func buttonSetting() {
        sendButton.backgroundColor = UIColor(hex: 0x73BF90)
        sendButton.setTitle("전송하기", for: .normal)
        sendButton.setTitle("전송하기", for: .highlighted)
        sendButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        sendButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        sendButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
    }
    
    //MARK: - Actions
    
    
    @IBAction func sendButtonTap(_ sender: Any) {
        //조건 달기 count수
        if commentDiaryBool == false {
            self.presentBottomAlert(message: "내용 100자 이상 입력해주세요.")
        }
        else if commentDiaryBool == true {
            self.showIndicator()

            WritingDiaryRequest.title = titleLabel.text ?? ""
            WritingDiaryRequest.content = contentLabel.text ?? ""
            WritingDiaryRequest.date = dateLabel.text ?? ""
            WritingDiaryRequest.deliveryYn = "Y"
        }
        

        
        

    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        //루트뷰로 화면전환
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteButtonTap(_ sender: Any) {
        //삭제, 삭제 alert

        let vc = UIStoryboard(name: "DeleteCheck", bundle: nil).instantiateViewController(withIdentifier: "DeleteCheckAlertViewController") as! DeleteCheckAlertViewController
        vc.diaryId = diaryID
        self.present(vc, animated: true)
        
    }
    
    @IBAction func editButtonTap(_ sender: Any) {
        //수정하기 화면전환
    }
    
    
}

    //MARK: - Extensions
extension YPreSaveViewController {
    func preSaveDiaryGet(_ response: DiaryCheckResopnse) {
        dateLabel.text = response.result.date
        contentLabel.text = response.result.content
        titleLabel.text = response.result.title
    }
}
