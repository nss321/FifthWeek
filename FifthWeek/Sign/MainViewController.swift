//
//  MainViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

protocol PassDataDelegate {
    func nicknameReceived(value: String)
}

final class MainViewController: UIViewController {
   
    private let statusLabel = UILabel()
    private let nextButton = PointButton(title: "처음으로")
    private let profileButton = PointButton(title: "프로필법튼")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(delegateButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(seanReceivedNotification),
            name: NSNotification.Name("Sean"),
            object: nil)
        
    }
    
    deinit {
        print(self)
    }
    
    @objc private func delegateButtonClicked() {
        print(#function)
    
        let vc = DelegateViewController()
        // 별개의 MainViewController 인스턴스가 아닌 자기자신의 instance를 넣어줌
        vc.contents = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func closureButtonClicked() {
        let vc = ClosureViewController()
        
//        vc.contents = "션배 \(Int.random(in: 1...100))"
        vc.contents =  { value in
            print("테스트테스트")
            self.statusLabel.textColor = .blue
            self.statusLabel.text = value
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func sample() {
        print("테스트테스트")
        statusLabel.textColor = .blue
    }
    
    @objc private func nextButtonClicked() {
//        navigationController?.pushViewController(EmailViewController(), animated: true)
//        navigationController?.popToRootViewController(animated: true)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else {
            // early exit
            return
        }
        window.rootViewController = UINavigationController(rootViewController: EmailViewController())
        window.makeKeyAndVisible()
        
        
    }
    
    private func configureLayout() {
        view.addSubview(statusLabel)
        view.addSubview(nextButton)
        view.addSubview(profileButton)
        
        statusLabel.text = "메인 화면"
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(statusLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        profileButton.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
    
    @objc private func profileButtonClicked() {
        print(#function)
        
        NotificationCenter.default.post(
            name: NSNotification.Name("sesac"),
            object: nil,
            userInfo: [
                "myData" : statusLabel.text ?? "닉네임"
        ])
    
        let vc = NotificationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func seanReceivedNotification(notification: NSNotification) {
        print(#function, "신호받음")
        statusLabel.text = "asdsad"
        if let name = notification.userInfo!["value"] as? String {
            statusLabel.text = name
        } else {
            statusLabel.text = "data no retreive"
        }
    }
}

extension MainViewController: PassDataDelegate {
    func nicknameReceived(value: String) {
        print(#function)
        statusLabel.textColor = .red
        statusLabel.text = value
    }
}
