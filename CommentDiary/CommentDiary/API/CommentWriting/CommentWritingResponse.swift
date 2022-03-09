//
//  CommentWritingResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/09.
//

import Foundation
struct CommentWriteResponse: Decodable {
    var code: Int
    var message: String
    var result: commentResult
}

struct commentResult: Decodable {
    var content: String
    var date: String
}
