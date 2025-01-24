//
//  EmailViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class EmailViewController: UIViewController {
   
    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
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
        navigationController?.pushViewController(PhoneViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(nextButton)
         
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
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
