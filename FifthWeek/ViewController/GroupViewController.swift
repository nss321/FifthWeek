//
//  GroupViewController.swift
//  FifthWeek
//
//  Created by BAE on 1/21/25.
//

import UIKit
import Kingfisher

final class GroupViewController: UIViewController {
    
    private let firstImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    private let secondImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    private let thirdImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    private let checkButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGreen
        return btn
    }()
    
    private var firstValue = ""
    private var secondValue = ""
    private var thirdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
        //        var number = Int.random(in: 1...3)
        ////
        //        PhotoManager.shared.callRequest(api: .randomPhoto) { RandomPhoto in
        //            dump(RandomPhoto)
        //        } failHandler: {
        //
        //        }
        //
        //        PhotoManager.shared.callRequest(api: .photo(query: "hh9OkRFj-Pw")) { RandomPhoto in
        //            dump(RandomPhoto)
        //        } failHandler: {
        //
        //        }
        
        print(plus(a: 2.0, b: 3.5))
        print(plus(a: 4, b: 2))
        //        print(plus(a: "4", b: "2"))
        //        Dummy(mainContents: "23", subContents: "231", others: 23)
        //        Dummy(mainContents: "숭구리당당", subContents: 2133, others: false)
        //        example { value in
        //            print(value)
        //        }
        
        // 이렇게 쓰는데 제네릭 때문에 지정해주는 거엿슴
        /*
         1. 타입 어노테이션으로 타입 명시
         */
        
        
        //        PhotoManager.shared.example(api: .topic(id: "wallpapers")) { (value: Topic) in
        //            dump(value)
        //        } failHandler: {
        //            print("통신 실패한 경우 얼럿")
        //        }
        
        /*
         2. 매개변수에 T 타입 명시
         T.Type(메타타입)
         사실 메타타입의 self가 숨겨져잇던거임 ㄷㄷ
         self.navigationController의 self랑은 다름!
         */
        PhotoManager.self.shared.example2(
            api: .randomPhoto(),
            type: RandomPhoto.self) { value in
                dump(value)
            } failHandler: {
                print("통신 실패한 경우 얼럿")
            }
        
        var age: Int = 3
        var name: String = "고래밥"
        var test: String.Type = String.self
        
        PhotoManager.shared.test(a: Int.self                                                                                                    )
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
            
            self.navigationController?.pushViewController(SearchViewController(), animated: true)
            let group = DispatchGroup()
            
            //            group.enter()
            //            PhotoManager.shared.getRandomPhoto { [self] RandomPhoto in
            //                print(RandomPhoto.id)
            //                firstValue = RandomPhoto.urls.thumb
            //                group.leave()
            //            } failHandler: {
            //
            //            }
            //            group.enter()
            //            PhotoManager.shared.getRandomPhoto { [self] RandomPhoto in
            //                print(RandomPhoto.id)
            //                secondValue = RandomPhoto.urls.thumb
            //                group.leave()
            //            } failHandler: {
            //
            //            }
            //            group.enter()
            //            PhotoManager.shared.getRandomPhoto { [self] RandomPhoto in
            //                print(RandomPhoto.id)
            //                thirdValue = RandomPhoto.urls.thumb
            //                group.leave()
            //            } failHandler: {
            //
            //            }
            //
            //            /*
            //             끝나는 지점은 장담할 수 없음.
            //             그래도 세 통신이 모두 끝났다는 신호는 알 수 있다.
            //             보통 화면 업데이트를 하기 떄문에 main에서 노티파이를 한다.
            //             */
            //            // 네트워크 통신이 느릴 떄? Network Condition
            //            group.notify(queue: .main) { [self] in
            //                print("긋")
            //                print(Thread.isMainThread)
            //                // tableView.reloadData()
            //                self.firstImageView.kf.setImage(with: URL(string: firstValue))
            //                self.secondImageView.kf.setImage(with: URL(string: secondValue))
            //                self.thirdImageView.kf.setImage(with: URL(string: thirdValue))
            //
            //            }
            
            //            PhotoManager.shared.getRandomPhoto { RandomPhoto in
            //                let url = URL(string: RandomPhoto.urls.thumb)
            //                if let data = try? Data(contentsOf: url!) {
            //                    if let image = UIImage(data: data) {
            //                        self.firstImageView.image = image
            //                    }
            //                }
            //            }
            
        }), for: .touchUpInside)
    }
}

