//
//  SplashViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/12.
//

//import Foundation
//import UIKit
//
//class OnboardingViewCOntroller : ViewController {
//    var slides: [OnboardingSlide] = []
//    var currentPage = 0 {
//        didSet {
//            pageControl.currentPage = currentPage
//            if currentPage == slides.count - 1 {
//                self.nextBtn.setTitle("시작하기", for: .normal)
//                self.nextBtn.backgroundColor = UIColor(hex: 0x73BF90)
//                self.nextBtn.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
//                self.nextBtn.titleLabel?.font = .AppleSDGothic(.bold, size: 18)
//            } else {
//                self.nextBtn.setTitle("넘어가기", for: .normal)
//                self.nextBtn.backgroundColor = UIColor(hex: 0xF4EDE3)
//                self.nextBtn.setTitleColor(UIColor(hex: 0x878379), for: .normal)
//                self.nextBtn.titleLabel?.font = .AppleSDGothic(.bold, size: 18)
//
//
//            }
//        }
//    }
//    
//    
//    //MARK: - Properties
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var nextBtn: UIButton!
//    @IBOutlet var pageControl: UIPageControl!
//    
//    
//
//    
//
//    
//    
//
//    
//    //MARK: - LifeCycle
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//        //자동 로그인
//        self.autoLogin()
//        
//        //버튼
//        self.nextBtn.setTitle("넘어가기", for: .normal)
//        self.nextBtn.titleLabel?.font = .AppleSDGothic(.bold, size: 18)
//        self.nextBtn.setTitleColor(UIColor(hex: 0x878379), for: .normal)
//        self.nextBtn.backgroundColor = UIColor(hex: 0xF4EDE3)
//        
//        
//        
//        
//        //pageControl
//        self.pageControl.currentPageIndicatorTintColor = UIColor(hex: 0xF7BC86)
//        self.pageControl.pageIndicatorTintColor = UIColor(hex: 0xF5CDA9)
//        slides = [OnboardingSlide(image: UIImage(named: "onboard1.png")!),
//        OnboardingSlide(image: UIImage(named: "onboard2.png")!),
//        OnboardingSlide(image: UIImage(named: "onboard3.png")!)]
//        
//        
//        view.backgroundColor = UIColor(hex: 0xFDFCF9)
//        
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        
//
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
//    
//    func autoLogin() {
//
//            TokenRefreshDataManager().tokenRefreshPostData { result in
//                guard result else {
//                    print("테스트")
//                    return
//                }
//                if UserDefaults.standard.bool(forKey: "login_save") == true {
//                let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
//                mainTabBarController.modalPresentationStyle = .fullScreen
//                mainTabBarController.modalTransitionStyle = .crossDissolve
//                self.present(mainTabBarController, animated: true, completion: nil)
//                } else {
//                    let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                    loginVC.modalPresentationStyle = .fullScreen
//                    loginVC.modalTransitionStyle = .crossDissolve
//                }
//            }
//    }
//
//    
//    
//    
//    //MARK: - Actions
//    
//
//    @IBAction func nextBtnClicked(_ sender: Any) {
//        if currentPage == slides.count - 1 {
////            print("Go to the next page")
////            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
//////            navigationController?.pushViewController(vc, animated: true)
////            vc.modalTransitionStyle = .crossDissolve
////            vc.modalPresentationStyle = .fullScreen
////            self.present(vc, animated: true, completion: nil)
//            let loginCaseVC = LoginCaseViewController()
//            loginCaseVC.modalTransitionStyle = .crossDissolve
//            loginCaseVC.modalPresentationStyle = .fullScreen
//            present(loginCaseVC, animated: true, completion: nil)
//        } else {
//            currentPage += 1
//            let indexPath = IndexPath(item: currentPage, section: 0)
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
//
//    }
//    
//
//
//}
//
//
//    //MARK: - Extension
//
//extension OnboardingViewCOntroller: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return slides.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
//        cell.setup(slides[indexPath.row])
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let width = scrollView.frame.width
//        currentPage = Int(scrollView.contentOffset.x / width)
//        pageControl.currentPage = currentPage
//        
//    }
//}
