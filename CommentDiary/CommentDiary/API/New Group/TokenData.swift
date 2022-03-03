//
//  TokenData.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation


struct TokenResponse: Codable {
    var code: Int = 0
    var message: String = ""
    var result: TokenData
}
  
//// MARK: - Result
//struct Result: Codable {
//    var grantType: String = ""
//    let accessToken: String
//    let refreshToken: String
//    var accessTokenExpiresIn: Int = 0
//}
