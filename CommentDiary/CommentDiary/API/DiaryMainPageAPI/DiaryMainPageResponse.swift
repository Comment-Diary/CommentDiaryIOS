//
//  AllDiaryResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/04.
//

import Foundation

struct DiaryMainPageResponse: Decodable {
//    var code: Int?
    var message: String
    var result: [diaryMainPageResult]
}

// MARK: - Result
struct diaryMainPageResult: Decodable {
    var id: Int
    var title: String
    var content: String
    var date: String
    var deliveryYn: String
    var tempYn : String
    var commentCnt: Int
    var commentResponseList: [CommentResponseList]?
}

// MARK: - CommentResponseList
struct CommentResponseList: Decodable {
    var id: Int
    var content: String
    var like: Bool
    var date: String
}
