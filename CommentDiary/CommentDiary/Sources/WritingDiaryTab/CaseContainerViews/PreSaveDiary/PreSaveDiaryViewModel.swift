//
//  PreSaveDiaryViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/08/02.
//

import Foundation

class PreSaveDiaryViewModel {
    lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    

    var dateValue: String = ""
    var diaryTitleValue: String = ""
    var diaryContentValue: String = ""
    var diaryIDValue : Int = 0

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadDate(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
    }

    @objc func loadDate(_ notification: NSNotification) {
        dateValue = notification.object as? String ?? ""
    }
    


}
