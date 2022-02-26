//
//  SuccessPasswordSentAlertService.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/27.
//

import Foundation
import UIKit

class SuccessFindPasswordSentAlertService {
    func alert() -> SuccessFindPasswordViewController {
        let storyboard = UIStoryboard(name: "SuccessFindPassword", bundle: .main)
        let successFindPasswordVC = storyboard.instantiateViewController(withIdentifier: "SuccessFindPasswordViewController") as! SuccessFindPasswordViewController
        return successFindPasswordVC
    }
}
