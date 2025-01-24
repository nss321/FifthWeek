//
//  PosterViewController.swift
//  FifthWeek
//
//  Created by BAE on 1/24/25.
//

import UIKit

final class PosterViewController: UIViewController {

    
    lazy private var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        return view
    }()
    
    
    var list = ["test1", "test2", "test3"]
    var detailList: [[RandomPhoto]] = [
        [],
        [],
        []
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let group = DispatchGroup()
        
        group.enter()
        PhotoManager.shared.getRandomPhoto(api: .randomPhoto(count: 10)) { RandomPhoto in
            dump(RandomPhoto.count)
            self.detailList[0] = RandomPhoto
            group.leave()
        } failHandler: {
            print(self, #function, "이미지 로드 싈패")
        }
        group.enter()
        PhotoManager.shared.getRandomPhoto(api: .randomPhoto(count: 10)) { RandomPhoto in
            dump(RandomPhoto.count)
            self.detailList[1] = RandomPhoto
            group.leave()
        } failHandler: {
            print(self, #function, "이미지 로드 싈패")
        }
        group.enter()
        PhotoManager.shared.getRandomPhoto(api: .randomPhoto(count: 10)) { RandomPhoto in
            dump(RandomPhoto.count)
            self.detailList[2] = RandomPhoto
            group.leave()
        } failHandler: {
            print(self, #function, "이미지 로드 싈패")
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }

        
    }

}

extension PosterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
        
        cell.config(row: list[indexPath.row])
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        cell.collectionView.tag = indexPath.row
        
        return cell
    }
}

extension PosterViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        let item = detailList[collectionView.tag][indexPath.row]
        
//        if collectionView.tag == 0 {
//            item = detailList1[indexPath.row]
//        } else if collectionView.tag == 1 {
//            item = detailList2[indexPath.row]
//        } else if collectionView.tag == 2 {
//            item = detailList3[indexPath.row]
//        }
        
        cell.config(item: item)
        return cell
    }
    
    
}
