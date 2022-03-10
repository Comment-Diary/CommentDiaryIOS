//
//  CommentReport.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
struct CommentReportResponse : Decodable {
    var diaryId: Int
    var content: String
}
