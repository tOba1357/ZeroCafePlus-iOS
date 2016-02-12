//
//  Extension.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2016/02/12.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

extension UITextField {
    func addUnderline(width: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
        border.backgroundColor = color.CGColor
        self.layer.addSublayer(border)
    }
}