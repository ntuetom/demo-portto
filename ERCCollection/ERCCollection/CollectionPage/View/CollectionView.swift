//
//  CollectionView.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import UIKit
import MJRefresh

class CollectionView: BaseView<CollectionViewModel> {
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        cv.mj_footer = refreshFooter
        return cv
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = kOffset
        layout.minimumInteritemSpacing = kOffset
        return layout
    }()
    
    lazy var refreshFooter: MJRefreshBackNormalFooter = {
        return MJRefreshBackNormalFooter()
    }()
    
    override func initSetupSubviews() {
        super.initSetupSubviews()
        contenView.addSubview(collectionView)
    }
    
    override func makeSubviewConstraints() {
        super.makeSubviewConstraints()
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(kOffset).priority(750)
            make.centerX.equalToSuperview()
        }
    }
    
    override func setupOutlets(owner: AnyObject?) {
        super.setupOutlets(owner: owner)
        if let vc = owner as? CollectionViewController {
            vc.collectionView = collectionView
        }
    }
    
    override func setupReceivedActions(owner: AnyObject?) {
        super.setupReceivedActions(owner: owner)
        if let vc = owner as? CollectionViewController {
            refreshFooter.setRefreshingTarget(vc, refreshingAction: #selector(CollectionViewController.onRefresh))
        }
    }
}
