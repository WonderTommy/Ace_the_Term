//
//  ShowBottomMenu.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-26.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class BottomMenu: NSObject {
    private var content: UIView
    private var paddingTop: CGFloat
    private var paddingBottom: CGFloat
    private var paddingLeft: CGFloat
    private var paddingRight: CGFloat
    private var menuHeight: CGFloat
    private var dismissOnClickOff: Bool
    
    private let shadowView = UIView()
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    init(content: UIView, menuHeight: Int, paddingTop: Int, paddingBottom: Int, paddingLeft: Int, paddingRight: Int, dismissOnClickOff: Bool) {
        self.content = content
        self.menuHeight = CGFloat(menuHeight)
        self.paddingTop = CGFloat(paddingTop)
        self.paddingBottom = CGFloat(paddingBottom)
        self.paddingLeft = CGFloat(paddingLeft)
        self.paddingRight = CGFloat(paddingRight)
        self.dismissOnClickOff = dismissOnClickOff
        super.init()
        setUpLayout()
        addContentView()
    }
    
    private func setUpLayout() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            shadowView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            if self.dismissOnClickOff {
                shadowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissBottomMenu)))
            }
            
            window.addSubview(shadowView)
            shadowView.frame = window.frame
            shadowView.alpha = 0
            
            window.addSubview(baseView)
            baseView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: menuHeight)
        }
    }
    
    private func addContentView() {
        baseView.addSubview(content)
        content.free()
        content.topAnchor.constraint(equalTo: baseView.topAnchor, constant: paddingTop).isActive = true
        content.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: paddingLeft).isActive = true
        content.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: paddingRight).isActive = true
        content.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: paddingBottom).isActive = true
    }
    
    public func showBottomMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.shadowView.alpha = 1
            
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                self.baseView.frame = CGRect(x: 0, y: window.frame.height - self.menuHeight, width: self.baseView.frame.width, height: self.menuHeight)
            }
        }, completion: nil)
    }
    
    @objc public func dismissBottomMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.shadowView.alpha = 0
            
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                self.baseView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }
        }, completion: nil)
    }
}
