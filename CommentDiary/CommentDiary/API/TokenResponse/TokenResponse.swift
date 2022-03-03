//
//  TokenResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
struct TokenResponse: Codable {
    let code: Int
    let message: String
    let result: TokenData
}
