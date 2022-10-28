//
//  CheckEmailResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/20.
//

import Foundation

struct CheckEmailResponse: Decodable {
    var code: Int
    var message: String
}

struct CheckEmailSuccessReponse {
    static var ResponseState = false
}
