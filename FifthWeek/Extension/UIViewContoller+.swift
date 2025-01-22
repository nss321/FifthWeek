//
//  UIViewContoller+.swift
//  FifthWeek
//
//  Created by BAE on 1/22/25.
//

import UIKit

extension UIViewController {
    // 패러미터를 네모박스로 박굼
    // 네모네모± 네모네모± 싸인±
    /*
     Generic Type -> 타입에 유연하게 대응하는 타입
     
     함수를 구성할 땐 알 수 없음.
     호출 시점이 되어야만 알 수 있다.
     컴파일 타임에 어떤 타입이 들어올 지는 그래도 알아야 한다.
     
     
     */

    func plus(a: Int, b: Int) -> Int {
        a+b
    }
    func plus(a: Double, b: Double) -> Double {
        a+b
    }
    
    // 타입은 모두 같아야함.
    // 모든 타입이 들어올 수 있다.
    // 제네릭은 제약을 해주어야 안전하게 쓸 수 있음. -> +가 가능한 녀석만 다 드루와±±
    // Type Constraints 라고 함.
    // Protocol로 타입에 제약을 둠!
    // 해당 타입을 채택하는 놈은 모두 들어올 수 있다.
    func plus<T: AdditiveArithmetic>(a: T, b: T) -> T {
        return a+b
    }

    func configBorder<T:UIView>(view: T) {
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .clear
        
    }
    
    func example<T>(completion: @escaping (T) -> String) -> String {
        return "안녕하세요."
    }
}

