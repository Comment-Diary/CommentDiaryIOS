//
//  AllCommentResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/25.
//

import Foundation
struct AllCommentResponse : Decodable {
    var code : Int
    var message: String
    var result : [AllCommentResultList]
}

struct AllCommentResultList : Decodable {
    var id: Int
    var content: String
    var date: String
    var like : Bool
}
