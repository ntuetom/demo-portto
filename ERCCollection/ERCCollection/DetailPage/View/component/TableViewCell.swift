//
//  TableViewCell.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/9.
//

import UIKit

protocol TableViewCellDelegate: NSObjectProtocol {
    func updateCellHeight(for height: CGFloat)
}

class TableViewCell: UITableViewCell {
    
    lazy var collectionImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let lb = makeLabel()
        return lb
    }()
    
    lazy var descLabel: UILabel = {
        let lb = makeLabel()
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(delegate: TableViewCellDelegate, data: TableViewCellData) {
        nameLabel.text = data.name
        descLabel.text = data.desc
        collectionImageView.kf.setImage(with: data.imageURL){ [unowned self] response in
            switch response {
            case .success(let img):
                let ratio = img.image.size.height/img.image.size.width
                self.collectionImageView.snp.remakeConstraints { make in
                    make.top.leading.trailing.equalToSuperview()
                    make.height.equalTo(self.collectionImageView.snp.width).multipliedBy(ratio).priority(750)
                }
                contentView.layoutIfNeeded()
                let imageHeight = collectionImageView.frame.size.width * ratio
                let nameHeight = nameLabel.intrinsicContentSize.height
                let descHeight = descLabel.intrinsicContentSize.height
                let totalHeigt = imageHeight + descHeight + nameHeight + 2*kOffset
                delegate.updateCellHeight(for: totalHeigt)
            case .failure(let error):
                print("TableViewCell LoadImage Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func makeLabel() -> UILabel {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .black
        lb.backgroundColor = .clear
        return lb
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(collectionImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
    }
    
    private func setupConstraint() {
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(collectionImageView.snp.bottom).offset(kOffset)
        }
        descLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(kOffset)
            make.bottom.equalToSuperview()
        }
    }
    
}
