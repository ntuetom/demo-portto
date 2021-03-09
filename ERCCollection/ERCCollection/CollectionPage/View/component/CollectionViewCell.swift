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
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .gray
        lb.numberOfLines = 0
        return lb
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
        imageView.kf.setImage(with: data.image_preview_url)
    }
    
    func setupView() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraint() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(kOffset)
            make.centerX.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(kOffset)
        }
    }
}
