//
//  SignUpResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/24.
//

import Foundation
struct SignUpResponse: Decodable {
    var code: Int
    var message: String
}

struct SignUpSuccessReponse {
    static var ResponseState = false
}
