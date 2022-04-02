//
//  TermsViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import UIKit
import SafariServices

class TermsViewController : UIViewController {
    let infoURL = NSURL(string: "https://www.notion.so/59a704f6702f4382b9398fa3b4a0d780")
    let usageURL = NSURL(string: "https://glittery-silk-987.notion.site/fb0c6c765a7a411c9362dc8d102c95e0")
    //MARK: - Properties
    
    @IBOutlet weak var termsBackView: UIView!
    
    @IBOutlet weak var termsLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var firstSeparateView: UIView!
    @IBOutlet weak var usageLabel: UILabel!
    
    @IBOutlet weak var usageView: UIView!
    
    @IBOutlet weak var secondSeparateView: UIView!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var thirdSeparateView: UIView!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        navigationBackSwipeMotion()
    }
    
    func navigationBackSwipeMotion() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        termsBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        usageView.backgroundColor = UIColor(hex: 0xFDFCF9)
        infoView.backgroundColor = UIColor(hex: 0xFDFCF9)
        firstSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        secondSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        thirdSeparateView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    func labelSetting() {
        termsLabel.text = "약관 및 정책"
        termsLabel.textColor = UIColor(hex: 0x4E4C49)
        termsLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        usageLabel.text = "이용 약관"
        usageLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        usageLabel.textColor = UIColor(hex: 0x4E4C49)
        infoLabel.textColor = UIColor(hex: 0x4E4C49)
        infoLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        infoLabel.text = "개인정보 처리 방침"
    }
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func usageButtonTap(_ sender: Any) {
        let webView : SFSafariViewController = SFSafariViewController(url: usageURL! as URL)
        present(webView, animated: true, completion: nil)
    }
    @IBAction func infoButtonTap(_ sender: Any) {
        let notionView : SFSafariViewController = SFSafariViewController(url: infoURL! as URL)
        present(notionView, animated: true, completion: nil)
    }
    
}


    //MARK: - Extensions
//let blogUrl = NSURL(string: "https://mobile.galleria.co.kr/goods/initDetailGoods.action?goods_no=2110272505&channel_code=VC010001&disp_lctg_no=1910020224&nv_ad=pla&n_media=98128&n_query=%EA%B2%A8%EC%9A%B8%EC%BD%94%ED%8A%B8&n_rank=1&n_ad_group=grp-a001-02-000000021780344&n_ad=nad-a001-02-000000159000327&n_campaign_type=2&n_mall_id=galleria&n_mall_pid=2110272505&n_ad_group_type=2&NaPm=ct%3Dkx9nlp1s%7Cci%3D0zC0003-QpHvG13bGfnp%7Ctr%3Dpla%7Chk%3D91b054974df9179ab06df40322e9aeba97fb4ca8")
//let blogView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
//self.present(blogView, animated: true, completion: nil)
