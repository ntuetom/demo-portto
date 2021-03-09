//
//  DetailViewController.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/9.
//

import UIKit
import RxSwift

class DetailViewControlller: BaseViewController {
    
    let viewModel: DetailViewModel
    var detailView: DetailView!
    weak var tableView: UITableView!
    
    init(data: CollectionData) {
        viewModel = DetailViewModel(data: data)
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("DetailViewControlller deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        detailView = DetailView(title: viewModel.collectionData.collectionName, vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.titleView = detailView.navTitleLabel
        binding()
        viewModel.emitData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    func binding() {
        viewModel
            .cellSource
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)) {  _, data, cell in
                cell.setup(delegate: self, data: data)
            }
            .disposed(by: disposeBag)
        
        detailView.webButton.rx.tap.subscribe { [weak self] _ in
            if let url = self?.viewModel.collectionData.webURL {
                UIApplication.shared.openURL(url)
            }
        }.disposed(by: disposeBag)
    }
}
extension DetailViewControlller: TableViewCellDelegate {
    func updateCellHeight(for height: CGFloat) {
        if tableView.frame.height != height {
            tableView.reloadItemsAtIndexPaths([IndexPath(row: 0, section: 0)], animationStyle: .automatic)
            detailView.updateTableViewConstraint(for: height)
        }
    }
}
