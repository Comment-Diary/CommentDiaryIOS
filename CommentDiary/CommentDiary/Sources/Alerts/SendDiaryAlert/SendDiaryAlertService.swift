//
//  SendDiaryAlertService.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/25.
//

import Foundation
import UIKit

class SendDiaryAlertService {
    func alert() -> SendDiaryAlertViewController {
        let storyboard = UIStoryboard(name: "SendDiaryAlert", bundle: .main)
        let sendDiaryAlertVC = storyboard.instantiateViewController(withIdentifier: "SendDiaryAlertViewController") as! SendDiaryAlertViewController
        return sendDiaryAlertVC
    }
}
