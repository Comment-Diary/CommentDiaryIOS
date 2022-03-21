//
//  DiaryCheckResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
struct DiaryCheckResopnse: Decodable {
    var code: Int
    var message: String
    var result: diaryCheckResult
}

struct diaryCheckResult: Decodable {
    var id: Int
    var title: String
    var content: String
    var date: String
    var deliveryYn: String
    var commentResponseList: [myCommentCheckResponseList]
}

struct myCommentCheckResponseList : Decodable {
    var id: Int
    var content: String
    var like: Bool
}


