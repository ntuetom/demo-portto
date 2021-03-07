//
//  ViewController.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import UIKit

class CollectionViewController: UIViewController {

    weak var collectionView: UICollectionView!
    
    let viewModel = CollectionViewModel()
    override func loadView() {
        super.loadView()
        _ = CollectionView(vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.fetchAsset()
    }


}

