//
//  NSaveViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/01.
//

import Foundation
import UIKit

class NSaveViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var buttonBackView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var barView: UIView!
    
    @IBOutlet weak var titleBackView: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        buttonSetting()
        labelSetting()
    }
    
    func viewSetting() {
        
    }
    
    func buttonSetting() {
        
    }
    
    func labelSetting() {
        
    }
    
    
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: Any) {
    }
    
    @IBAction func deleteButtonTap(_ sender: Any) {
        let deleteCheckVC = UIStoryboard(name: "DeleteCheck", bundle: nil).instantiateViewController(withIdentifier: "DeleteCheckAlertViewController") as! DeleteCheckAlertViewController
        self.present(deleteCheckVC, animated: true)
        

    }
    
    @IBAction func editButtonTap(_ sender: Any) {

    }
    
}
//let viewControllers: [UIViewController] = self.navigationController!.viewControllers
//for aViewController in viewControllers {
//    if aViewController is GoodsRegisterViewController {
//        self.navigationController!.popToViewController(aViewController, animated: true)
//    }
