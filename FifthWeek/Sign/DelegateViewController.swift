//
//  DelegateViewController.swift
//  FifthWeek
//
//  Created by BAE on 1/23/25.
//

import UIKit

class DelegateViewController: UIViewController {

    private let emailTextField = SignTextField(placeholderText: "딜리게이트를 통한 값전달")
    private let nextButton = PointButton(title: "저장하기")
    var contents: PassDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()

        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
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
    
    @objc private func nextButtonClicked() {
        
        // 동일한 인스턴스의 메인뷰컨트롤러를 어떻게 가져올가나~?
        // Property AS Type 활용
//        MainViewController().nicknameReceived()
        
        contents?.nicknameReceived(value: emailTextField.text!)
        navigationController?.popViewController(animated: true)
    }

}
