//
//  NSaveViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/01.
//

import Foundation
import UIKit

class NSaveViewController: UIViewController {
    var dateString = ""
    var titleString = ""
    var contentString = ""
    
    
    //MARK: - Properties
    
    @IBOutlet weak var buttonBackView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var barView: UIView!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var diaryScrollView: UIScrollView!
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        buttonSetting()
        labelSetting()
    }
    
    func detailSetting() {
        
    }
    
    func viewSetting() {
        buttonBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        diaryScrollView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryScrollView.layer.cornerRadius = 10
        titleBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        barView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    func buttonSetting() {
        
    }
    
    func labelSetting() {
        dateLabel.text = dateString
        titleLabel.text = titleString
        contentLabel.text = contentString
    }
    
    
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteButtonTap(_ sender: Any) {
        let deleteCheckVC = UIStoryboard(name: "DeleteCheck", bundle: nil).instantiateViewController(withIdentifier: "DeleteCheckAlertViewController") as! DeleteCheckAlertViewController
        self.present(deleteCheckVC, animated: true)
        

    }
    
    @IBAction func editButtonTap(_ sender: Any) {
        let nEditVC = UIStoryboard(name: "NEdit", bundle: nil).instantiateViewController(withIdentifier: "NEidtViewController") as! NEidtViewController
        nEditVC.dateString = dateLabel.text ?? ""
        nEditVC.titleString = titleLabel.text ?? ""
        nEditVC.contentString = contentLabel.text ?? ""

        self.navigationController?.pushViewController(nEditVC, animated: true)

    }
    
}
//let viewControllers: [UIViewController] = self.navigationController!.viewControllers
//for aViewController in viewControllers {
//    if aViewController is GoodsRegisterViewController {
//        self.navigationController!.popToViewController(aViewController, animated: true)
//    }
