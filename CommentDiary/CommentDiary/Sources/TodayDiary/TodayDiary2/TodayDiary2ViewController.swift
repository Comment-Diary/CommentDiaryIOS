//
//  TodayDiary2ViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/06/28.
//

import Foundation
import UIKit

class TodayDiary2ViewController : UIViewController {
    //MARK: - PROPERTIES
    
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //MARK: - ACTIONS
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "WritingDiaryCancel", bundle: nil).instantiateViewController(withIdentifier: "WritingDiaryCancelAlertViewController") as! WritingDiaryCancelAlertViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func diaryTypeButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func saveDiaryButtonClicked(_ sender: UIButton) {
    }
    
    
    
}


    //MARK: - Extensions
