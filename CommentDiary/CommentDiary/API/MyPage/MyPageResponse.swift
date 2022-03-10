//
//  MyPageResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/11.
//

import Foundation
struct MyPageResponse: Decodable {
    var code: Int
    var message: String
    var result: myPageResult
}
struct myPageResult: Decodable {
    var email: String
    var temp: Int
}
