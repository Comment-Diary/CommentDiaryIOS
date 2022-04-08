//
//  ReadCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit
class ReadCommentViewController: UIViewController {
    var diaryIDValue: Int = 0
    //true 이면 코멘트 쓰러가기 false 이면 코멘트 보러가기
    var myCommentBool : Bool = false
    //true이면 현재 false이면 과거
    var pastOrNow : Bool = true
    
    lazy var detailDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy.MM.dd"
        return df
    }()
    //yyyy.mm.dd 에 쓰일 변수
    var fullDate = ""
    //MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    @IBOutlet weak var allLookButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var topBackVIew: UIView!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var contentView: UILabel!
    
    @IBOutlet weak var contentBackView: UIView!
    
    @IBOutlet weak var bottomBackView: UIView!
    
    @IBOutlet weak var readCommentLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        buttonSetting()
        viewSetting()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadDate(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadID(_:)), name: NSNotification.Name(rawValue: "SelectedID"), object: nil)
        //yyyy.mm.dd
        NotificationCenter.default.addObserver(self, selector: #selector(loadFullDate(_:)), name: NSNotification.Name(rawValue: "FullSelectedDate"), object: nil)
    }
    
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        contentView.textColor = UIColor(hex: 0x4E4C49)
        contentView.font = UIFont.AppleSDGothic(.medium, size: 15)
        readCommentLabel.text = "코멘트가 도착했어요. 확인해주세요!"
        readCommentLabel.textColor = UIColor(hex: 0xFDFCF9)
        readCommentLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
    }
    
    func buttonSetting() {
        allLookButton.setTitle("전체보기", for: .normal)
        allLookButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        allLookButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    func viewSetting() {
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        topBackVIew.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        bottomBackView.backgroundColor = UIColor(hex: 0x73BF90)
        
    }
    
    @objc func loadDate(_ notification: NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
    }
    
    @objc func loadFullDate(_ notification: NSNotification) {
        fullDate = notification.object as? String ?? ""
    }
    
    @objc func loadTitle(_ notification: NSNotification) {
        titleLabel.text = notification.object as? String ?? ""
    }
    @objc func loadContent(_ notification: NSNotification) {
        contentView.text = notification.object as? String ?? ""
    }
    
    @objc func loadID(_ notification: NSNotification) {
        diaryIDValue = notification.object as? Int ?? 0
    }
    
    
    //MARK: - Actions
    
    @IBAction func allLookButtonTap(_ sender: Any) {
//        let yReadCommentVC = UIStoryboard(name: "YReadComment", bundle: nil).instantiateViewController(withIdentifier: "YReadCommentViewController") as! YReadCommentViewController
//        yReadCommentVC.diaryId = diaryIDValue
//        yReadCommentVC.completion = {
//            self.tabBarController?.selectedIndex = 1
//        }
//        self.navigationController?.pushViewController(yReadCommentVC, animated: true)
        
        
//        self.showIndicator()
//        ReadCommentAllButtonTapDataManager().allbuttonTapData(diaryID: diaryIDValue, self)
        
        
        
    }
    
    @IBAction func allButtonTap(_ sender: Any) {
        self.showIndicator()
        ReadCommentAllButtonTapDataManager().allbuttonTapData(diaryID: diaryIDValue, self)
    }
    
    
    
}


    //MARK: - Extensions

extension ReadCommentViewController {
    func checkCommentBool(_ response: DiaryCheckResopnse) {
        self.dismissIndicator()
        
        
        //일기 날짜
        let commentDate = detailDayDateFormatter.date(from: fullDate)
        
        //일기 날짜 + 1
        let datePlus = Calendar.current.date(byAdding: .day, value: 1, to: commentDate!)
        //일기 날짜 +1 string
        let datePlusString = detailDayDateFormatter.string(from: datePlus!)
        print(datePlusString, "하루 더한 날짜")
        
        
        print(detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)), "오늘")
        
        if datePlusString == detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)) {
            pastOrNow = true //현재
        }
        else if datePlusString != detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)) {
            pastOrNow = false //과거
        }
        self.showIndicator()
        CompareDataManager().dateCommentData(self, dateValue: datePlusString)
    
        
        
    }
}


extension ReadCommentViewController {
    func countMyCommentResponse(_ response: DateCommentResponse) {
        if response.result.count == 0 {
            //유저가 코멘트 안씀
            myCommentBool = false
        }
        else if response.result.count != 0 {
            //유저가 코멘트 씀
            myCommentBool = true
        }
        
        
        
        
        if myCommentBool == true {
            //코멘트 보러가기
            let gatherLookDetailVC = UIStoryboard(name: "GatherLookDetail", bundle: nil).instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
            gatherLookDetailVC.diaryID = self.diaryIDValue
            self.navigationController?.pushViewController(gatherLookDetailVC, animated: true)
        }
        else if myCommentBool == false && pastOrNow == true {
            //코멘트 안씀, 현재 -> 쓰러가기
            let yReadCommentVC = UIStoryboard(name: "YReadComment", bundle: nil).instantiateViewController(withIdentifier: "YReadCommentViewController") as! YReadCommentViewController
            yReadCommentVC.diaryId = self.diaryIDValue
            yReadCommentVC.completion = {
                self.tabBarController?.selectedIndex = 1
            }
            self.navigationController?.pushViewController(yReadCommentVC, animated: true)
            
        }
        else if myCommentBool == false && pastOrNow == false {
            //코멘트 안씀, 과거 -> 못보는 안내 페이지
            print("못보낸 안내 페이지")
            let yNotWriteCommentVC = UIStoryboard(name: "YNotWriteComment", bundle: nil).instantiateViewController(withIdentifier: "YNotWriteCommentViewController") as! YNotWriteCommentViewController
            yNotWriteCommentVC.diaryID = self.diaryIDValue
            self.navigationController?.pushViewController(yNotWriteCommentVC, animated: true)
        }
        self.dismissIndicator()
    }
}
