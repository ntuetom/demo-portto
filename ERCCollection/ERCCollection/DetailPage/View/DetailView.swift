//
//  DetailView.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/9.
//

import UIKit

class DetailView: BaseView<DetailViewModel> {
    
    let title: String
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tv.estimatedRowHeight = 42
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.rowHeight = UITableView.automaticDimension
        return tv
    }()
    
    lazy var webButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("打開網頁", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.gray.cgColor
        return btn
    }()
    
    lazy var navTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = title
        return lb
    }()
    
    init(title: String, vm: DetailViewModel, owner: AnyObject) {
        self.title = title
        super.init(vm: vm, owner: owner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initSetupSubviews() {
        super.initSetupSubviews()
        backgroundColor = .white
        contenView.addSubview(tableView)
        contenView.addSubview(webButton)
    }
    
    override func makeSubviewConstraints() {
        super.makeSubviewConstraints()
        remakeConstraintsTableView()
        remakeConstraintsWebBtn()
    }
    
    override func setupOutlets(owner: AnyObject?){
        super.setupOutlets(owner: owner)
        if let vc = owner as? DetailViewControlller {
            vc.tableView = tableView
        }
    }
    
    override func setupReferencingOutlets(owner: AnyObject?){
        super.setupReferencingOutlets(owner: owner)
    }
    
    func updateTableViewConstraint(for height: CGFloat) {
        if height < contenView.frame.height - webButton.frame.height {
            remakeConstraintsTableView(height: height)
            remakeConstraintsWebBtn(bottomToHeight: false)
        }
    }
    
    private func remakeConstraintsWebBtn(bottomToHeight: Bool = true) {
        webButton.snp.remakeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalTo(tableView)
            if bottomToHeight {
                make.bottom.equalToSuperview()
            }
        }
    }
    
    private func remakeConstraintsTableView(height: CGFloat? = nil) {
        tableView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(kOffset)
            make.trailing.equalToSuperview().offset(-kOffset).priority(750)
            if let h = height{
                make.height.equalTo(h)
            }
        }
    }
    
}
