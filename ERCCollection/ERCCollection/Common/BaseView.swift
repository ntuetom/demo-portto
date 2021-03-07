//
//  BaseView.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit
import SnapKit

class BaseView<T: NSObject>: UIView {
    
    unowned var viewModel: T
    unowned var owner: AnyObject
    let contenView: UIView
    
    init(vm: T, owner: AnyObject, frame: CGRect? = nil) {
        self.viewModel = vm
        self.owner = owner
        if let f = frame {
            contenView = UIView(frame: f)
        } else {
            var rect = UIScreen.main.bounds
            rect.size.height -= kSafeAreaHeight
            rect.origin.y = kSafeAreaStatusHeight
            contenView = UIView(frame: rect)
        }
        super.init(frame: .zero)
        initSetupSubviews()
        makeSubviewConstraints()
        setupOutlets(owner: owner)
        setupReferencingOutlets(owner: owner)
        setupReceivedActions(owner: owner)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSetupSubviews() -> Void{
        addSubview(contenView)
    }
    
    func makeSubviewConstraints() -> Void{
        contenView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(safeAreaLayoutGuide)
            } else {
                make.edges.top.equalTo(layoutMarginsGuide)
            }
        }
    }
    
    func setupOutlets(owner: AnyObject?){
        if owner != nil && owner!.isKind(of: UIViewController.classForCoder()){
            (owner as! UIViewController).view = self
        }
    }
    
    func setupReferencingOutlets(owner: AnyObject?){
        
    }
    
    func setupReceivedActions(owner: AnyObject?){
        
    }
    
}
