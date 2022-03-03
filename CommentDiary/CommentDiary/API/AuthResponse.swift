//
//  AuthResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation


struct AuthResposne: Codable {
    var code: Int
    var message: String
    var result: TokenData
}
