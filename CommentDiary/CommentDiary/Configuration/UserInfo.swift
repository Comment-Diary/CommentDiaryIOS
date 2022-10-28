//
//  UserInfo.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/29.
//

import Foundation
class UserInfo {
    static let shared = UserInfo()
    var email : String?
    var password: String?
    var passwordCheck: String?
    private init() {
        
    }
}
