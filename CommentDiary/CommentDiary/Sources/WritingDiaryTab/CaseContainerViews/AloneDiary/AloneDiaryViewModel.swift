//
//  AloneDiaryViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/08/01.
//

import Foundation

struct AloneDiaryModel {
    var titleValue : String = ""
    var contentValue : String = ""
    var dateValue : String = ""
    var diaryID : Int = 0
    
//    init(titleValue: String, contentValue: String, dateValue: Int, diaryID: Int) {
//        self.titleValue = titleValue
//        self.contentValue = contentValue
//        self.dateValue = dateValue
//        self.diaryID = diaryID
//    }
}


class AloneDiaryViewModel {
    var aloneDiaryModel = AloneDiaryModel()
    var diaryTitleValue : String {
        return aloneDiaryModel.titleValue
        
    }
    var titleValue = ""
    var diaryContentValue = ""
    var diaryDateValue = ""
    var diaryIDValue = 0
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadID(_:)), name: NSNotification.Name(rawValue: "SelectedID"), object: nil)
        
    }
    
    @objc func loadData(_ notification : NSNotification) {
        aloneDiaryModel.dateValue = notification.object as? String ?? ""
//        print(diaryDateValue)
    }
    
    @objc func loadTitle(_ notification: NSNotification) {
        aloneDiaryModel.titleValue = notification.object as? String ?? ""
//        print(diaryTitleValue)
        print(aloneDiaryModel.titleValue)
    }
    @objc func loadContent(_ notification: NSNotification) {
//        aloneDiaryViewModel.addMoreText(data: notification.object as? String ?? ""
        aloneDiaryModel.contentValue = notification.object as? String ?? ""
    }
    @objc func loadID(_ notification: NSNotification) {
        aloneDiaryModel.diaryID = notification.object as? Int ?? 0
//        aloneDiaryViewModel.diaryIDValue = notification.object as? Int ?? 0
    }
    
    
    
    
    
    
    
    
    
    func addMoreText(data: String) {
//        diaryContentTrans = data + "더보기"
    }
//    var diaryIDValue = 0
    lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    
    
    
}
