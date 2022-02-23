//
//  CommentReportAlertService.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/23.
//

import Foundation
import UIKit

class CommentReportAlertService {
    func alert() -> CommentReportViewController {
        let storyboard = UIStoryboard(name: "CommentReportAlert", bundle: .main)
        let commentReportVC = storyboard.instantiateViewController(withIdentifier: "CommentReportViewController") as! CommentReportViewController
        return commentReportVC
    }
}
