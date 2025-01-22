//
//  SearchViewController.swift
//  FifthWeek
//
//  Created by BAE on 1/22/25.
//

import UIKit
import SnapKit
import Then

final class SearchViewController: UIViewController {
    
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.height.equalTo(44)
        }
        textField.do {
            $0.delegate = self
            $0.backgroundColor = .systemYellow
            $0.leftViewMode = .always
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function, "키보드 리턴 잉")
        // 키보드 내리는 기능은 아님. responder를 resign 시키면서 자연스레 키보드가 내려가는 것.
        // firstResponder를 준게 아니면 의미없음.
        textField.resignFirstResponder()
        return true
    }
}
