//
//  SplashViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/12.
//

import Foundation
import UIKit
import FSPagerView

class SplashVieController : ViewController {
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                self.nextBtn.setTitle("시작하기", for: .normal)
                self.nextBtn.backgroundColor = UIColor.mainOrange
            } else {
                self.nextBtn.setTitle("넘어가기", for: .normal)
                self.nextBtn.backgroundColor = UIColor(hex: 0xF7F3D5)
            }
        }
    }
    
    
    //MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    
    
//    @IBOutlet weak var splashPageControl: FSPageControl! {
//        didSet {
//            self.splashPageControl.numberOfPages = self.imageNames.count
//            self.splashPageControl.contentHorizontalAlignment = .center
//            self.splashPageControl.setStrokeColor(UIColor(hex: 0xF5CDA9), for: .normal)
//            self.splashPageControl.setStrokeColor(UIColor(hex: 0xF7BC86), for: .selected)
//
//            self.splashPageControl.setFillColor(UIColor(hex: 0xF5CDA9), for: .normal)
//            self.splashPageControl.setFillColor(UIColor(hex: 0xF7BC86), for: .selected)
//            self.splashPageControl.itemSpacing = 15
//            self.splashPageControl.interitemSpacing = 15
//        }
//    }
    
    

    
    

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //버튼
        self.nextBtn.setTitle("넘어가기", for: .normal)
        self.nextBtn.backgroundColor = UIColor(hex: 0xF7F3D5)
        self.nextBtn.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        self.nextBtn.layer.shadowColor = UIColor.black.cgColor
        self.nextBtn.layer.shadowOpacity = 0.2
        self.nextBtn.layer.shadowRadius = 10
        self.nextBtn.layer.cornerRadius = 15 //수정하기
        
        //pageControl
        self.pageControl.currentPageIndicatorTintColor = UIColor(hex: 0xF7BC86)
        self.pageControl.pageIndicatorTintColor = UIColor(hex: 0xF5CDA9)
        slides = [OnboardingSlide(image: UIImage(named: "1.png")!),
        OnboardingSlide(image: UIImage(named: "2.png")!),
        OnboardingSlide(image: UIImage(named: "3.png")!)]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        

    }
    
    
    
    //MARK: - Actions
    

    @IBAction func nextBtnClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            print("Go to the next page")
            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
//            navigationController?.pushViewController(vc, animated: true)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

    }
    


}


    //MARK: - Extension

extension SplashVieController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
        
    }
}
