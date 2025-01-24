//
//  NicknameViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(seanReceivedNotification),
            name: NSNotification.Name("Sean"),
            object: nil)
    }
    
    deinit {
        print(#function, "emailvc deinit")
    }
    
    
    @objc func nextButtonClicked() {
//        UIApplication.shared.windows.first deprecated after iOS 15
        // TODO: Extension으로 분리
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else {
//            // early exit
//            return
//        }
//        
//        window.rootViewController = UINavigationController(rootViewController: MainViewController())
//        window.makeKeyAndVisible()
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
            
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    @objc func seanReceivedNotification(notification: NSNotification) {
        print(#function, "신호받음")
        if let name = notification.userInfo!["value"] as? String {
            print(self, name)
        } else {
            print(self, "데타업다")
        }
    }
}

