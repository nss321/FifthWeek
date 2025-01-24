//
//  PosterCollectionViewCell.swift
//  FifthWeek
//
//  Created by BAE on 1/24/25.
//

import UIKit

final class PosterCollectionViewCell: UICollectionViewCell {
    static let id = "PosterCollectionViewCell"
    private let imageView = UIImage()
    
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        posterImageView.backgroundColor = .systemMint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(item: RandomPhoto) {
        let urls = URL(string: item.urls.thumb)
        posterImageView.kf.setImage(with: urls)
    }
}
