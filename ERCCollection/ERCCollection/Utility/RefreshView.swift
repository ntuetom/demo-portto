//
//  RefreshView.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/8.
//

import UIKit

let k_RefreshView = RefreshView()
class RefreshView: UIView {
    
    lazy var loadindIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .gray)
    }()
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: kScreenW, height: kScreenH)))
        addSubview(loadindIndicator)
        loadindIndicator.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle(isOn: Bool) {
        
        if isOn {
            loadindIndicator.startAnimating()
            UIApplication.shared.keyWindow?.addSubview(self)
            UIApplication.shared.keyWindow?.bringSubviewToFront(self)
        } else {
            loadindIndicator.stopAnimating()
            removeFromSuperview()
        }
    }
}
