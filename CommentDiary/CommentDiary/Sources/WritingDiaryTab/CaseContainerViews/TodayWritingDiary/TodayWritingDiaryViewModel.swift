//
//  TodayWritingDiaryViewModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/08/01.
//

import Foundation

class TodayWritingDiaryViewModel {
    lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    // MARK: - 삭제?
//    var selectedDateString = ""
//    var todayDateString = ""

}
