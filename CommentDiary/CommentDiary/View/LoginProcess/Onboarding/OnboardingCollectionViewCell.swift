//
//  OnboardingCollectionViewCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/12/22.
//

import Foundation
import UIKit


struct OnboardingSlide {
    let image: UIImage
}


class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    @IBOutlet weak var slideImageView: UIImageView!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
    }
}
