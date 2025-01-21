//
//  GroupViewController.swift
//  FifthWeek
//
//  Created by BAE on 1/21/25.
//

import UIKit

class GroupViewController: UIViewController {
    
    let firstImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    let secondImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    let thirdImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let checkButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGreen
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    

    func configView() {
        view.backgroundColor = .systemBackground
        view.addSubview(firstImageView)
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
        view.addSubview(checkButton)
        firstImageView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        secondImageView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.top.equalTo(firstImageView.snp.bottom)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        thirdImageView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.top.equalTo(secondImageView.snp.bottom)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        checkButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        checkButton.addAction(UIAction(handler: { _ in
            print("button tapped")
            
            PhotoManager.shared.getRandomPhoto()
            
        }), for: .touchUpInside)
    }
}


