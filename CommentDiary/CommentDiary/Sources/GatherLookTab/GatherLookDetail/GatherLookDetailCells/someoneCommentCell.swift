//
//  someoneCommentCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/19.
//

import UIKit

protocol ReportDelegate: AnyObject {
    func reportButtonTapped(_ index : Int)
}
protocol HeartDelegate: AnyObject {
    func heartButtonTapped(_ index: Int)
}

class someoneCommentCell: UITableViewCell {
    var reportDelegate: ReportDelegate?
    var heartDelegate: HeartDelegate?
    

    var index = 0
    
    var heartIndex = 0
    
    var isenabled: Bool = false
    
    
    static let identifier = "someoneCommentCell"
    static func nib() -> UINib {
        return UINib(nibName: "someoneCommentCell", bundle: nil)
    }
    
    @IBOutlet weak var bakcView: UIView!
    
    @IBOutlet weak var someoneLabel: UILabel!
    
    @IBOutlet weak var someoneComment: UILabel!
    
    @IBOutlet weak var reportButton: UIButton!
    
    @IBOutlet weak var heartButton: UIButton!
    
    //정대리님 강의
    @IBOutlet var btns: [UIButton]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        someoneLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
        someoneLabel.textColor = UIColor(hex: 0x73BF90)
        someoneComment.font = UIFont.AppleSDGothic(.medium, size: 15)
        someoneComment.textColor = UIColor(hex: 0x4E4C49)
        reportButton.setTitle("신고하기", for: .normal)
        reportButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        reportButton.setTitleColor(UIColor(hex: 0x878379), for: .highlighted)
        reportButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
        bakcView.backgroundColor = UIColor(hex: 0xFDFCF9)
        bakcView.layer.cornerRadius = 8
        
        
        //버튼
        self.heartButton.addTarget(self, action: #selector(heartClicked), for: .touchUpInside)
        self.reportButton.addTarget(self, action: #selector(reportClicked), for: .touchUpInside)
    }
    
    func heartDate(heartIndex: Int) {
        self.heartIndex = heartIndex
    }
    
    
    
    @objc func heartClicked() {
//        print("하트 버튼 눌림")
//        reportDelegate?.reportButtonTapped()
        heartDelegate?.heartButtonTapped(self.index)
//        heartButton.isEnabled = false
        heartButton.setImage(UIImage(named: "customHeartFill"), for: .normal)

        
        
    }
    
    @objc func reportClicked() {
//        print("신고 버튼 눌림")
        reportDelegate?.reportButtonTapped(self.index)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor(hex: 0xF4EDE3)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .clear
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)) /
        
    }
    
}
