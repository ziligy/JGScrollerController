//
//  ScrollerMenu.swift
//  JGScrollerController
//
//  Created by Jeff on 2/1/16.
//  Copyright © 2016 Jeff Greenberg. All rights reserved.
//

import UIKit

/// pinning options for view
public enum  ViewOrientation {
    case TopCenter
    case TopLeft
    case TopRight
    case BottomCenter
    case BottomLeft
    case BottomRight
    case RightCenter
    case RightTop
    case RightBottom
    case LeftCenter
    case LeftTop
    case LeftBottom
    case CenterCenter
}

internal class ScrollerMenu: UIStackView, JGScrollPage {
    
    internal var delegateScrollerControl: JGScrollerControlDelegate?
    
    private var currentIndex = 0
    
    private var height: CGFloat!
    private let itemSpacing: CGFloat = 5
    private let mainColor = UIColor.grayColor()
    private let highlightColor = UIColor.redColor()
    
    convenience init(parent: JGScrollerController, imageNames: [String], height: CGFloat = 50, orientaion: ViewOrientation = ViewOrientation.TopCenter) {
        self.init()
        guard (imageNames.count > 0) else { return }
        
        // exchange delegate assignments
        parent.delegateScroll = self
        self.delegateScrollerControl = parent
        
        self.height = height
        
        parent.view.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.spacing = itemSpacing

        self.axis = UILayoutConstraintAxis.Horizontal
        self.distribution = UIStackViewDistribution.Fill
        self.alignment = UIStackViewAlignment.Center

        setOrientation(parent, orientaion: orientaion)
        
        for name in imageNames {
            addMenuItem(name)
        }
        
        setHighlightColor(0)
    }
    
    private func addMenuItem(imageName: String) {
        let menuItem = JGTapButton(sideSize: height)
        menuItem.raised = false
        menuItem.round = false
        menuItem.mainColor = mainColor
        if let image = UIImage(named: imageName) {
            menuItem.imageInset = 7
            menuItem.image = image
        } else {
            menuItem.title = String(self.arrangedSubviews.count)
        }
        menuItem.tag = self.arrangedSubviews.count
        
        menuItem.addTarget(self, action: "selected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.insertArrangedSubview(menuItem, atIndex: self.arrangedSubviews.count)
    }
    
    func selected(sender: JGTapButton) {
        setHighlightColor(sender.tag)
        delegateScrollerControl?.gotoPageNumber(sender.tag)
    }
    
    private func setHighlightColor(index: Int) {
        let oldTap = arrangedSubviews[currentIndex] as! JGTapButton
        oldTap.mainColor = mainColor
        oldTap.setNeedsDisplay()
        
        let newTap = arrangedSubviews[index] as! JGTapButton
        newTap.mainColor = highlightColor
        newTap.setNeedsDisplay()

        currentIndex = index
    }
    
    func scrollerDidScroll(positionX positionX: CGFloat, offset: CGFloat) {}
    
    func scrollerDidEndAtPage(currentPage: Int) {
        setHighlightColor(currentPage)
    }
    
    private func setOrientation(parent: JGScrollerController, orientaion: ViewOrientation) {
        
        let top = self.topAnchor.constraintEqualToAnchor(parent.topLayoutGuide.bottomAnchor)
        let centerX = self.centerXAnchor.constraintEqualToAnchor(parent.view.centerXAnchor)
        let bottom = self.bottomAnchor.constraintEqualToAnchor(parent.view.bottomAnchor)
        let left = self.leadingAnchor.constraintEqualToAnchor(parent.view.leadingAnchor)
        let right = self.trailingAnchor.constraintEqualToAnchor(parent.view.trailingAnchor)
        let centerY = self.centerYAnchor.constraintEqualToAnchor(parent.view.centerYAnchor)
        
        switch orientaion {
            
        case .TopCenter: top.active = true; centerX.active = true
        case .TopRight: top.active = true; right.active = true
        case .TopLeft: top.active = true; left.active = true
        case .BottomCenter: bottom.active = true; centerX.active = true
        case .BottomLeft: bottom.active = true; left.active = true
        case .BottomRight: bottom.active = true; right.active = true
            
        case .LeftCenter: left.active = true; centerY.active = true
            self.axis = UILayoutConstraintAxis.Vertical
        case .LeftTop: left.active = true; top.active = true
            self.axis = UILayoutConstraintAxis.Vertical
        case .LeftBottom: left.active = true; bottom.active = true
            self.axis = UILayoutConstraintAxis.Vertical
        case .RightCenter: right.active = true; centerY.active = true
            self.axis = UILayoutConstraintAxis.Vertical
        case .RightTop: right.active = true; top.active = true
            self.axis = UILayoutConstraintAxis.Vertical
        case .RightBottom: right.active = true; bottom.active = true
            self.axis = UILayoutConstraintAxis.Vertical
        case .CenterCenter: centerX.active = true; centerY.active = true
        }
    }
}


