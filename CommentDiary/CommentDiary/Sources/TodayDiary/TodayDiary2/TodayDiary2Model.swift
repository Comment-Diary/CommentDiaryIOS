//
//  TodayDiary2Model.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/07/10.
//

import Foundation
struct TodayDiaryModel {
    var titleTextCount = 0
    var contentTextCount = 0
    
//일기 작성 type topsheet
    // true: 보이기, false, 숨기기
    var isTopSheetShown : Bool = false
}
//if (todayDiary.isTopSheetShown) {
//    //topsheet 숨기기
//    UIView.animate(withDuration: 0.3, animations: {
//        self.topSheetViewHeightConstraint.constant = 0
////                self.topSheetViewtrailingConstraint.constant = self.view.frame.width
//        self.view.layoutIfNeeded()
//    }) { (status) in
//        self.todayDiary.isTopSheetShown = true
//    }
//} else {
//    //bottomsheet 보이기
//    UIView.animate(withDuration: 0.3, animations: {
//        self.topSheetViewHeightConstraint.constant = 166
//        self.view.layoutIfNeeded()
//    }) { (status) in
//        //completion code
//        self.todayDiary.isTopSheetShown = true
//        UIView.animate(withDuration: 0.3, animations: {
//            self.topSheetViewHeightConstraint.constant = 180
//        })
//    }
//}
