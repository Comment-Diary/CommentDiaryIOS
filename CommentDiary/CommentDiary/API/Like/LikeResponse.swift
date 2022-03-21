//
//  LikeResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/22.
//

import Foundation
struct LikeResponse : Decodable {
    var code: Int
    var message: String
    var result : likeResult
}

struct likeResult: Decodable {
    var id: Int
    var like : Bool
}
