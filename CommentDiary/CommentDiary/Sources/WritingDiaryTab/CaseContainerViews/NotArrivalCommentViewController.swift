//
//  NotArrivalCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit


class NotArrivalCommentViewController: UIViewController {
    var diaryIDValue : Int = 0
    //MARK: - Properties
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var allLookButton: UIButton!
    
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var firstLabel : UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var bottomBackView: UIView!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        buttonSetting()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(loadDate(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadID(_:)), name: NSNotification.Name(rawValue: "SelectedID"), object: nil)
    }
    
    @objc func loadDate(_ notification: NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
    }
    
    @objc func loadTitle(_ notification: NSNotification) {
        titleLabel.text = notification.object as? String ?? ""
    }
    @objc func loadContent(_ notification: NSNotification) {
        contentLabel.text = notification.object as? String ?? ""
    }
    @objc func loadID(_ notification: NSNotification) {
        diaryIDValue = notification.object as? Int ?? 0
    }
    
    
    func viewSetting() {
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        bottomBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        firstLabel.text = "아쉽게도 코멘트가 도착하지 않았어요."
        secondLabel.text = "그래도 오늘의 기록은 내일의 기억이 될 거예요 :)"
        firstLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        secondLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        firstLabel.textColor = UIColor(hex: 0x878379)
        secondLabel.textColor = UIColor(hex: 0x878379)
        contentBackView.layer.cornerRadius = 10
        view.backgroundColor = UIColor(hex: 0xF4EDE3)

    }
    
    func buttonSetting() {
        allLookButton.setTitle("전체보기", for: .normal)
        allLookButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        allLookButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    //MARK: - Actions
    
    @IBAction func allLookButtonTap(_ sender: Any) {
//        let ypreSaveVC = UIStoryboard(name: "YPreSave", bundle: nil).instantiateViewController(withIdentifier: "YPreSaveViewController") as! YPreSaveViewController
//        ypreSaveVC.diaryID = diaryIDValue
//        self.navigationController?.pushViewController(ypreSaveVC, animated: true)
//        let notArrivalCommentDiaryVC = UIStoryboard(name: "NotArrivalCommentDiary", bundle: nil).instantiateViewController(withIdentifier: "NotArrivalCommentDiaryViewController") as! NotArrivalCommentDiaryViewController
//        notArrivalCommentDiaryVC.diaryDate = dateLabel.text ?? ""
//        notArrivalCommentDiaryVC.diaryTitle = titleLabel.text ?? ""
//        notArrivalCommentDiaryVC.diaryContent = contentLabel.text ?? ""
//        notArrivalCommentDiaryVC.diaryID = self.diaryIDValue
//        self.navigationController?.pushViewController(notArrivalCommentDiaryVC, animated: true)
    }
    
    
    @IBAction func allButtonTap(_ sender: Any) {
        let notArrivalCommentDiaryVC = UIStoryboard(name: "NotArrivalCommentDiary", bundle: nil).instantiateViewController(withIdentifier: "NotArrivalCommentDiaryViewController") as! NotArrivalCommentDiaryViewController
        
        
        notArrivalCommentDiaryVC.diaryID = self.diaryIDValue
        self.navigationController?.pushViewController(notArrivalCommentDiaryVC, animated: true)
        
        
    }
    
    

}

