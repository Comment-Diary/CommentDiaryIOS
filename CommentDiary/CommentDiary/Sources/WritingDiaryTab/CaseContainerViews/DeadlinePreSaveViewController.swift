//
//  DeadlinePreSaveViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/23.
//

import Foundation
import UIKit

class DeadlinePreSaveViewController : UIViewController {
    private lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    var diaryIDValue: Int = 0
    //MARK: - Properties
    
    @IBOutlet weak var entireButton: UIButton!
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var separtateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        viewSetting()
        buttonSetting()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadID(_:)), name: NSNotification.Name(rawValue: "SelectedID"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateLabel.text = self.krMonthDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
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
    }
    func viewSetting() {
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        separtateView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    func buttonSetting() {
        entireButton.setTitle("전체보기", for: .normal)
        entireButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        entireButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    @objc func loadData(_ notification : NSNotification) {
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
    
    @IBAction func entireButtonTap(_ sender: Any) {

//        let yPreSaveDeadlineVC = UIStoryboard(name: "YPreSaveDeadline", bundle: nil).instantiateViewController(withIdentifier: "YPreSaveDeadlineViewController") as! YPreSaveDeadlineViewController
//        yPreSaveDeadlineVC.diaryDate = self.dateLabel.text ?? ""
//        yPreSaveDeadlineVC.diaryContent = self.contentLabel.text ?? ""
//        yPreSaveDeadlineVC.diaryTItle = self.titleLabel.text ?? ""
//        yPreSaveDeadlineVC.diaryId = self.diaryIDValue
//        self.navigationController?.pushViewController(yPreSaveDeadlineVC, animated: true)
    }
    
    
    @IBAction func allButtonTap(_ sender: Any) {
        let yPreSaveDeadlineVC = UIStoryboard(name: "YPreSaveDeadline", bundle: nil).instantiateViewController(withIdentifier: "YPreSaveDeadlineViewController") as! YPreSaveDeadlineViewController
        yPreSaveDeadlineVC.diaryDate = self.dateLabel.text ?? ""
        yPreSaveDeadlineVC.diaryContent = self.contentLabel.text ?? ""
        yPreSaveDeadlineVC.diaryTItle = self.titleLabel.text ?? ""
        yPreSaveDeadlineVC.diaryId = self.diaryIDValue
        self.navigationController?.pushViewController(yPreSaveDeadlineVC, animated: true)
    }
    
    
    
    
    //MARK: - Actions
}

    //MARK: Extensions
