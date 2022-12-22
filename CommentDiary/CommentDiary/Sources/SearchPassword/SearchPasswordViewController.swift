//
//  SearchPasswordViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/09/25.
//

//import Foundation
//import UIKit
//import Then
//import SnapKit
//import RxSwift
//import RxCocoa
//import RxKeyboard
//
//class SearchPasswordViewController : UIViewController {
//    let disposeBag = DisposeBag()
//    var viewModel = SearchPasswordViewModel()
//    
//    // MARK: - PROPERTIES
//    private let backButton = UIButton().then {
//        $0.setImage(UIImage(named: "arrowLeft.png"), for: .normal)
//    }
//    private let mainTitleLabel = UILabel().then {
//        $0.text = "비밀번호 찾기"
//        $0.textColor = HexColor.textColor.getHexColor()
//        $0.font = UIFont.AppleSDGothic(.extraBold, size: 30)
//    }
//    private let infoLabel = UILabel().then {
//        $0.text = "코다 가입시 사용했던 \n아이디(이메일)을 입력해주세요"
//        $0.numberOfLines = 2
//        $0.textColor = HexColor.textColor.getHexColor()
//        $0.font =  UIFont.AppleSDGothic(.medium, size: 14)
//    }
//    private let emailTextField = UITextField().then {
//        $0.placeholder = "coda@coda.com"
//        $0.layer.borderWidth = 2
//        $0.layer.borderColor = HexColor.mainGreenColor.getHexColor().cgColor
//        $0.borderStyle = .roundedRect
//        $0.layer.cornerRadius = 4
//        $0.backgroundColor = HexColor.backgroundColor.getHexColor()
//    }
//    private let warningAlertLabel = UILabel().then {
//        $0.text = ""
//        $0.textColor = HexColor.warning.getHexColor()
//        $0.font = UIFont.AppleSDGothic(.medium, size: 12)
//    }
//    private let sendPasswordButton = UIButton().then {
//        $0.setTitle("비밀번호 전송하기", for: .normal)
//        $0.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
//        $0.setTitleColor(HexColor.whiteColor.getHexColor(), for: .normal)
//        $0.backgroundColor = HexColor.mainGreenColor.getHexColor()
//        $0.layer.cornerRadius = 10
//
//    }
//
//
//    // MARK: - LIFECYCLE
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//        actions()
//        emailFormCheck()
//        searchButtonClicked()
//        keyboardSetting()
//    }
//    // MARK: - 키보드 올라가며 버튼 올리기
//    private func keyboardSetting() {
//        RxKeyboard.instance.visibleHeight
//            .drive(onNext: { keyboardVisibleHeight in
//                let height = keyboardVisibleHeight > 0 ? -keyboardVisibleHeight + self.view.safeAreaInsets.bottom - 16 : -88
//                self.sendPasswordButton.snp.updateConstraints { make in
//                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(height)
//                }
//                self.view.layoutIfNeeded()
//            }).disposed(by: disposeBag)
//    }
//    private func emailFormCheck() {
//        emailTextField.rx.text
//            .orEmpty
//            .asDriver(onErrorJustReturn: "")
//            .drive(viewModel.emailTextFieldSubject)
//            .disposed(by: disposeBag)
//
//        viewModel.idFormCheck
//            .subscribe(onNext: { value in
//                print(value)
//                if value {
//                    self.warningAlertLabel.text = ""
//                    self.sendPasswordButton.isEnabled = true
//                    self.sendPasswordButton.alpha = 1.0
//                }
//                else {
//                    self.warningAlertLabel.text = "이메일 양식에 맞춰주세요."
//                    self.warningAlertLabel.textColor = HexColor.warning.getHexColor()
//                    self.sendPasswordButton.isEnabled = false
//                    self.sendPasswordButton.alpha = 0.4
//                }
//            }).disposed(by: disposeBag)
//    }
//    func searchButtonClicked() {
//        sendPasswordButton.rx.tap
//            .bind {
//                self.showIndicator()
//                self.viewModel.buttonTapped(self.emailTextField.text ?? "", completion: { result in
//                    self.dismissIndicator()
//                    switch result {
//                    case 200:
//                        self.warningAlertLabel.text = "비밀번호를 전송했어요. 알림을 확인해주세요"
//                        self.warningAlertLabel.textColor = HexColor.mainGreenColor.getHexColor()
//                    case 404:
//                        self.warningAlertLabel.text = "해당 이메일을 가지고 있는 사용자가 없어요"
//                        self.warningAlertLabel.textColor = HexColor.warning.getHexColor()
//                    default:
//                        self.warningAlertLabel.text = "네트워크 오류가 발생했습니다."
//                        self.warningAlertLabel.textColor = HexColor.warning.getHexColor()
//                    }
//                })
//            }
//            .disposed(by: disposeBag)
//    }
//
//    private func actions() {
//        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//    }
//
//    // MARK: - ACTIONS
//    @objc func backButtonTapped() {
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//extension SearchPasswordViewController {
//    enum HexColor {
//        case backgroundColor
//        case textColor
//        case warning
//        case mainGreenColor
//        case whiteColor
//
//        func getHexColor() -> UIColor {
//            switch self {
//            case .backgroundColor:
//                return UIColor(hex: 0xFDFCF9)
//            case .textColor:
//                return UIColor(hex: 0x5F5D59)
//            case .warning:
//                return UIColor(hex: 0xF83C32)
//            case .mainGreenColor:
//                return UIColor(hex: 0x5ABD80)
//            case .whiteColor:
//                return UIColor(hex: 0xFDFCF9)
//            }
//        }
//    }
//
//
//    private func configureUI() {
//        [backButton, mainTitleLabel, infoLabel, emailTextField, warningAlertLabel, sendPasswordButton].forEach {
//            view.addSubview($0)
//        }
//        backButton.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(3)
//            make.leading.equalToSuperview().offset(7)
//        }
//        mainTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
//            make.leading.equalToSuperview().offset(52)
//        }
//        infoLabel.snp.makeConstraints { make in
//            make.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
//            make.leading.equalToSuperview().offset(52)
//        }
//        emailTextField.snp.makeConstraints { make in
//            make.top.equalTo(infoLabel.snp.bottom).offset(12)
//            make.centerX.equalToSuperview()
//            make.leading.equalToSuperview().offset(52)
//            make.height.equalTo(40)
//        }
//        warningAlertLabel.snp.makeConstraints { make in
//            make.top.equalTo(emailTextField.snp.bottom).offset(4)
//            make.leading.equalToSuperview().offset(52)
//        }
//        sendPasswordButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.leading.equalToSuperview().offset(16)
//            make.height.equalTo(56)
//            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-88)
//        }
//
//        view.backgroundColor = HexColor.backgroundColor.getHexColor()
//        sendPasswordButton.isEnabled = false
//        sendPasswordButton.alpha = 0.4
//
//    }
//}
