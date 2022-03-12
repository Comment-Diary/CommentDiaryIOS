//
//  DiaryListModel.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import Foundation

class DiaryListModel {
    var diaryId: Int = 0
    var diaryTitle: String = ""
    var diaryContent: String = ""
    var diaryDate: String = ""
    var diaryDeliveryYn : String = ""
    
    
    // 코멘트
    var commentId: Int
    var commentContent: String
    var commentLike: Bool
}
