//
//  GatherDiaryDateResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import Foundation
struct GatherDiaryDateResponse: Decodable {
    var code: Int?
    var message: String?
    var result : [GatherDiaryDateListResult]?
}

struct GatherDiaryDateListResult : Decodable {
    var id: Int?
    var title: String?
    var content: String?
    var date: String?
    var deliveryYn: String?
    var commentCnt : Int?
    var commentResponseList : [commentResponseList]?
}

struct commentResponseList : Decodable {
    var id: Int?
    var content: String?
    var date: String?
    var like: Bool?
}
