//
//  Date.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/12.
//

import Foundation
import UIKit

extension Date {
    init(year: Int, month: Int, day: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd"
        self = dateFormatter.date(from: "\(year):\(month):\(day)") ?? Date()
    }
    
    var text: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var detailText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    // MARK: 이미지 파일을 저장할 때 마땅한 이름이 없는 경우 현재 일시를 파일 이름으로 사용하기도 합니다.
    var fileName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmssSSS"
        return dateFormatter.string(from: self)
    }
}

//extension Date {
//
//    /**
//     # dateCompare
//     - Parameters:
//        - fromDate: 비교 대상 Date
//     - Note: 두 날짜간 비교해서 과거(Future)/현재(Same)/미래(Past) 반환
//    */
//    public func dateCompare(fromDate: Date) -> String {
//        var strDateMessage:String = ""
//        let result:ComparisonResult = self.compare(fromDate)
//        switch result {
//        case .orderedAscending:
//            strDateMessage = "Future"
//            break
//        case .orderedDescending:
//            strDateMessage = "Past"
//            break
//        case .orderedSame:
//            strDateMessage = "Same"
//            break
//        default:
//            strDateMessage = "Error"
//            break
//        }
//        return strDateMessage
//    }
//}


extension Date {

    /**
     # dateCompare
     - Parameters:
        - fromDate: 비교 대상 Date
     - Note: 두 날짜간 비교해서 과거(Future)/현재(Same)/미래(Past) 반환
    */
    public func dateCompare(fromDate: Date) -> String {
        var strDateMessage:String = ""
        let result:ComparisonResult = self.compare(fromDate)
        switch result {
        case .orderedAscending:
            strDateMessage = "Future"
            print("미래")
            NotificationCenter.default.post(name: NSNotification.Name("compareDate"), object: "미래")
            
            break
        case .orderedDescending:
            strDateMessage = "Past"
            NotificationCenter.default.post(name: NSNotification.Name("compareDate"), object: "과거")
            break
        case .orderedSame:
            strDateMessage = "Same"
            NotificationCenter.default.post(name: NSNotification.Name("compareDate"), object: "미래")
            break
        default:
            strDateMessage = "Error"
            break
        }
        return strDateMessage
    }
}


//NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name(rawValue: "presentDate"), object: nil)
//@objc func loadData(_ notification : NSNotification) {
//    dateLabel.text = notification.object as? String ?? ""
//}
