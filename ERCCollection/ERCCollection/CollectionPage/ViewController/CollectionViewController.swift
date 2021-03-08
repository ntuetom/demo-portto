//
//  ViewController.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import UIKit
import RxCocoa

class CollectionViewController: BaseViewController {

    let viewModel = CollectionViewModel()
    weak var collectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        _ = CollectionView(vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        binding()
        viewModel.fetchAsset()
    }
    
    func binding() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel
            .collectionDatas
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: "CollectionViewCell", cellType: CollectionViewCell.self)) {  _, repo, cell in
                cell.setup(data: repo)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func onRefresh() {
        viewModel.fetchAsset()
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize
    }
}

