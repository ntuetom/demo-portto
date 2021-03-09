//
//  ViewController.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import RxDataSources

class CollectionViewController: BaseViewController {

    let viewModel = CollectionViewModel()
    weak var collectionView: UICollectionView!
    weak var refreshFooter: MJRefreshBackNormalFooter!
    
    override func loadView() {
        super.loadView()
        _ = CollectionView(vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        viewModel.fetchAsset()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func binding() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.zip(collectionView.rx.itemSelected,
                       collectionView.rx.modelSelected(CollectionData.self))
                    .bind{ [unowned self] indexPath, model in
                        let detailVC = DetailViewControlller(data: model)
                        navigationController?.pushViewController(detailVC, animated: true)
                    }
                    .disposed(by: disposeBag)
        
        viewModel.cellSource.subscribe { [weak self] _ in
            self?.collectionView.mj_footer?.endRefreshing()
        }.disposed(by: disposeBag)
        
        let dataSource = getDataSource()

        viewModel.cellSource
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func getDataSource() -> RxCollectionViewSectionedReloadDataSource<CustomSectionDataType> {
        return RxCollectionViewSectionedReloadDataSource<CustomSectionDataType>(
            configureCell: { (dataSource, cv, indexPath, item) in
              if let cell = cv.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
                  cell.setup(data: item)
                  return cell
              }
              return UICollectionViewCell()
          })
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

