//
//  GetDiaryAllResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import Foundation
struct GatherDiaryAllResponse: Decodable {
    var code: Int
    var message: String
    var result : [GatherDiaryAllListResult]
}

struct GatherDiaryAllListResult : Decodable {
    var id: Int
    var title: String
    var content: String
    var date: String
    var deliveryYn: String
    var commentCnt : Int
}
