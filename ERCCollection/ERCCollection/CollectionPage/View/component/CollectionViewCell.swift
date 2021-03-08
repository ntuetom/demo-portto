//
//  CollectionViewCell.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var nameLabel: UILabel = {
        return UILabel()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(data: CollectionData) {
        nameLabel.text = data.name
        imageView.kf.setImage(with: data.img_url)
        if let url = data.img_url {
            print(url.absoluteURL)
        }
    }
    
    func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraint() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(kOffset)
        }
    }
}
