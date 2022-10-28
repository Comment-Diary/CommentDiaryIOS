//
//  EmailAuthenficationResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/10/29.
//

import Foundation
struct EmailAuthenficationResponse: Decodable {
    var code: Int
    var message: String
}
