//
//  DateCommentResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/25.
//

import Foundation
struct DateCommentResponse : Decodable {
    var code : Int
    var message: String
    var result : [DateCommentResultList]
}

struct DateCommentResultList : Decodable {
    var id : Int
    var content: String
    var date: String
    var like : Bool
}
