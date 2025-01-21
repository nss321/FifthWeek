//
//  ViewController.swift
//  FifthWeek
//
//  Created by BAE on 1/20/25.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
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
    
    let switcher = {
        let swt = UISwitch()
        return swt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
//        ConcurrentASync()
//        example()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    func example() {
        print("START")
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        print("====1111====")
        DispatchQueue.global(qos: .background).async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        print("====2222====")
        DispatchQueue.global().async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        print("END")
    }
    
    
    // Dispatch Group
    func example2() {
        
        let group = DispatchGroup()
        
        print("START")
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        print("====1111====")
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        print("====2222====")
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        print("END")
        
        group.notify(queue: .global()) {
            print("번호 끝!")
        }
    }
    
    
    
    func serialSync() {
        print("START", terminator: " ")
        for item in 1...100 {
            print(item, terminator: " ")
        }
        DispatchQueue.main.sync {
            for item in 101...200 {
                print(item, terminator: " ")
            }
        }
        print("END", terminator: " ")
    }
    
    func serialASync() {
        print("START", terminator: " ")
        DispatchQueue.main.async {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        for item in 101...200 {
            print(item, terminator: " ")
        }
        print("END", terminator: " ")
    }
    
    func ConcurrentSync() {
        print("START", terminator: " ")
        DispatchQueue.global().sync {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        for item in 101...200 {
            print(item, terminator: " ")
        }
        print("END", terminator: " ")
    }
    
    func ConcurrentASync() {
        print("START", terminator: " ")
        for item in 1...100 {
            DispatchQueue.global().async {
                print(item, terminator: " ")
            }
        }
        for item in 101...200 {
            
            DispatchQueue.global().async {
                print(item, terminator: " ")
            }
        }
        print("END", terminator: " ")
    }
    
    
    func configView() {
        view.backgroundColor = .systemBackground
        view.addSubview(firstImageView)
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
        view.addSubview(checkButton)
        view.addSubview(switcher)
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
        switcher.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        checkButton.addAction(UIAction(handler: { _ in
            print(#function)
            
            /*
             작업이 빠르게 끝날 수 있음.
             
             그러나, 작업의 순서도는 보장할 수 없음.
             여러 작업이 모두 종료되었다는 신호를 받기가 어려움
             */
            
            
            // 이렇게 호출을 Serialization 하면 속도는 오래걸리지만, 작업의 종료 시점을 명확히 알 수 있음.
//            NetworkManager.shared.fetchImage { image in
//                print("firstImageView Succeed")
//                self.firstImageView.image = image
//                NetworkManager.shared.fetchImage { image in
//                    print("secondImageView Succeed")
//                    self.secondImageView.image = image
//                    NetworkManager.shared.fetchImage { image in
//                        print("thirdImageView Succeed")
//                        self.thirdImageView.image = image
//                        print("Rmx!")
//                    }
//                }
//            }
            let group = DispatchGroup()
            group.enter() // +1
            NetworkManager.shared.fetchImage { [self] image in
                firstImageView.image = image
                print("firstImageView Succeed")
                group.leave() // -1
            }
            group.enter() // +1
            NetworkManager.shared.fetchImage { [self] image in
                secondImageView.image = image
                print("secondImageView Succeed")
                group.leave() // -1
            }
            group.enter() // +1
            NetworkManager.shared.fetchImage { [self] image in
                thirdImageView.image = image
                print("thirdImageView Succeed")
                group.leave() // -1
            }
            

            
            // 동기함수에서 동작함. -> main thread에서 돌아가는 녀석들에게만 효과있음
            // 메인스레드를 기다리지 않음.
            // 반복문, 동기적으로 실행되는 녀석들 외에는 그다지 적절하지 않음.
            
            // 이 외의 경우는 enter/leave를 이요함.
            // +- 0가 되면 notify! Reference Count와 유사하게 동작한다고 함!
            group.notify(queue: .main) {
                print(#function, "End")
            }

            
        }), for: .touchUpInside)
    }
    
}

