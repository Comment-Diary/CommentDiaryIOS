//
//  ReceivedDiaryResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/22.
//

import Foundation
struct ReceivedDiaryResponse : Decodable {
    var code: Int
    var message: String?
    var result: ReceivedDiaryResult
}


struct ReceivedDiaryResult : Decodable {
    var diaryId: Int
    var title : String
    var content: String
    var date: String
    var myCommentResponse : [myCommentResponse]
}
struct myCommentResponse : Decodable {
    var id : Int
    var content: String
    var date: String
    var like : Bool
}
