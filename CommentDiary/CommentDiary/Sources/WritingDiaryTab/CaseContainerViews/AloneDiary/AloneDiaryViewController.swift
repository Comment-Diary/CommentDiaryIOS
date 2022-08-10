//
//  AloneDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit

class AloneDiaryViewController: UIViewController {
    let aloneDiaryViewModel = AloneDiaryViewModel()
    
    enum hexColor {
        case backgroundColor
        case dateLabelColor
        case titleLabelColor
        case contentLabelColor
        case titleSeparateViewColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .dateLabelColor:
                return UIColor(hex: 0xFFA665)
            case .titleLabelColor:
                return UIColor(hex: 0x4E4C49)
            case .contentLabelColor:
                return UIColor(hex: 0x4E4C49)
            case .titleSeparateViewColor:
                return UIColor(hex: 0xE2DFD7)
            }
        }
    }
    
    var diaryIDValue: Int = 0
    
    //MARK: - Properties
    
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var myDiaryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabelSetting()
        viewSetting()
        
        print(aloneDiaryViewModel.titleValue, "!!!")
//        print(alone)
        print(aloneDiaryViewModel)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTodayData()
        
        titleLabel.text = aloneDiaryViewModel.diaryTitleValue
        contentLabel.text = aloneDiaryViewModel.diaryContentValue
        dateLabel.text = aloneDiaryViewModel.diaryDateValue
        print(aloneDiaryViewModel.diaryTitleValue, "??????")
    }

    
    func viewSetting() {
        topBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        view.backgroundColor = hexColor.backgroundColor.getHexColor()
        separateView.backgroundColor = hexColor.titleSeparateViewColor.getHexColor()
    }
    
    func loadTodayData() {
        NotificationCenter.default.addObserver(self, selector: #selector(todayLoadtitle(_:)), name: NSNotification.Name(rawValue: "loadTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(todayLoadContent(_:)), name: NSNotification.Name(rawValue: "loadContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(todayLoadID(_:)), name: NSNotification.Name(rawValue: "loadID"), object: nil)
    }
    @objc func todayLoadtitle(_ notification : NSNotification) {
        titleLabel.text = notification.object as? String ?? ""
    }
    @objc func todayLoadContent(_ notification : NSNotification) {
//        contentLabel.text = notification.object as? String ?? ""
//        aloneDiaryViewModel.addMoreText(data: notification.object as? String ?? "")
    }
    //아이디값 적기
    @objc func todayLoadID(_ notification : NSNotification) {
//        aloneDiaryViewModel.diaryIDValue = notification.object as? Int ?? 0
//        diaryIDValue = notification.object as? Int ?? 0
    }
    
    
    func dateLabelSetting() {
//        self.dateLabel.text = aloneDiaryViewModel.krMonthDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
        dateLabel.textColor = hexColor.dateLabelColor.getHexColor()
        myDiaryLabel.textColor = hexColor.dateLabelColor.getHexColor()
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = hexColor.titleLabelColor.getHexColor()
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        contentLabel.textColor = hexColor.contentLabelColor.getHexColor()
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
//        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(loadID(_:)), name: NSNotification.Name(rawValue: "SelectedID"), object: nil)
    }
    
    @objc func loadData(_ notification : NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
    }
    
    @objc func loadTitle(_ notification: NSNotification) {
        titleLabel.text = notification.object as? String ?? ""
    }
    @objc func loadContent(_ notification: NSNotification) {
//        aloneDiaryViewModel.addMoreText(data: notification.object as? String ?? ""
        contentLabel.text = notification.object as? String ?? ""
    }
    @objc func loadID(_ notification: NSNotification) {
        diaryIDValue = notification.object as? Int ?? 0
//        aloneDiaryViewModel.diaryIDValue = notification.object as? Int ?? 0
    }
    
    
    @IBAction func entireDiaryButtonTap(_ sender: Any) {
    }
    
    @IBAction func allButtonTap(_ sender: Any) {
        let nSaveVC = UIStoryboard(name: "NSave", bundle: nil).instantiateViewController(withIdentifier: "NSaveViewController") as! NSaveViewController
        nSaveVC.diaryCheckToggle = true
//        nSaveVC.diaryidInt = aloneDiaryViewModel.diaryIDValue
//        print(diaryIDValue, "보낸 아이디 값")
        self.navigationController?.pushViewController(nSaveVC, animated: true)
    }
    
    
}
