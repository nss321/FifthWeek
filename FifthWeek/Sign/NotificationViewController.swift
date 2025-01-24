//
//  NotificationViewController.swift
//  FifthWeek
//
//  Created by BAE on 1/23/25.
//

import UIKit

class NotificationViewController: UIViewController {
    
    let emailTextField = SignTextField(placeholderText: "노티피케이션을 통한 값전달")
    let nextButton = PointButton(title: "저장하기")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLayout()
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        
        // post 전에 observer가 먼저 등록되어 있어야 한다.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sesacReceived),
            name: NSNotification.Name("sesac"),
            object: nil)
    }
    @objc private func nextButtonClicked() {
//        navigationController?.pushViewController(PhoneViewController(), animated: true)
        navigationController?.popViewController(animated: true)
        // Notification을 통해 값을 보내고 싶엉~
        NotificationCenter.default.post(
            name: NSNotification.Name("Sean"),
            object: nil,
            userInfo: [
                "nickname" : "션배",
                "value" : emailTextField.text ?? "닉네임"
        ])
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
    
    @objc func sesacReceived() {
        print(#function, self)
    }
}
