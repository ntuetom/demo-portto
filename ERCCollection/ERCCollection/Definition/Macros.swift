//
//  Macros.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

// MARK: - 螢幕配置
let kScreenH: CGFloat = UIScreen.main.bounds.size.height
let kScreenW: CGFloat = UIScreen.main.bounds.size.width
@available(iOS 11.0, *)
let kInset: UIEdgeInsets?  = UIApplication.shared.windows.first?.safeAreaInsets

var kSafeAreaStatusHeight: CGFloat {
    if #available(iOS 11.0, *) {
        return kInset?.top ?? 44
    } else {
        return 20
    }
}
var kSafeAreaBottomHeight: CGFloat {
    if #available(iOS 11.0, *) {
        return kInset?.bottom ?? 34
    } else {
        return 0
    }
}
let kNavigationbarHeight:  CGFloat = 44.0
let kSafeAreaTopHeight:    CGFloat = kSafeAreaStatusHeight + kNavigationbarHeight
let kSafeAreaHeight:       CGFloat = kSafeAreaStatusHeight + kSafeAreaBottomHeight

// MARK: - 畫面變數
let kOffset: CGFloat = 10
