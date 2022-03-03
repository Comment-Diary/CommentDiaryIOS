//
//  WritingDiaryResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/28.
//

import Foundation
struct WritingDiaryResponse: Decodable {
    var code: Int
    var message: String
    var result: result
}

struct result : Decodable {
    var id: Int
}
