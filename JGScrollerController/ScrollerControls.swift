//
//  ScrollerControls.swift
//  JGScrollerController
//
//  Created by Jeff on 1/30/16.
//  Copyright © 2016 Jeff Greenberg. All rights reserved.
//

import UIKit

protocol JGScrollerControlInterface {
    func createNextAndPreviousControlAndAddToSubview(vc: UIViewController)
    func createCloseControlAndAddToSubview(vc: UIViewController)
    func hideNextControl(hidden: Bool)
    func hidePrevControl(hidden: Bool)
    
    var delegateScrollerControl: JGScrollerControlDelegate? { get set }
}

internal class ScrollerControls: NSObject, JGScrollerControlInterface {
    
    internal var delegateScrollerControl: JGScrollerControlDelegate?
    
    private let bundle = NSBundle(forClass: JGScrollerController.self)
    
    private var nextButton: JGTapButton!
    private var prevButton: JGTapButton!
    private var closeButton: JGTapButton!
    
    private let buttonColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.75)
    private let largeButtonSize: CGFloat = 48
    private let smallButtonSize: CGFloat = 30
    
    private let nextButtonImage = "ic_chevron_right_white_48pt.png"
    private let prevButtonImage = "ic_chevron_left_white_48pt.png"
    private let closeButtonImage = "ic_close_white_12pt_2x.png"
    
    // MARK: create buttons
    
    internal func createNextAndPreviousControlAndAddToSubview(vc: UIViewController) {
        
        let nextButton = JGTapButton(sideSize: largeButtonSize)
        nextButton.mainColor = buttonColor
        
        if let image = UIImage(named: nextButtonImage, inBundle: bundle, compatibleWithTraitCollection: nil) {
            nextButton.image = image
        } else {
            nextButton.title = ">"
        }
        
        nextButton.addTarget(self, action: "next", forControlEvents: UIControlEvents.TouchUpInside)
        vc.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerYAnchor.constraintEqualToAnchor(vc.view.centerYAnchor).active = true
        nextButton.trailingAnchor.constraintEqualToAnchor(vc.view.trailingAnchor, constant: -6).active = true
        nextButton.widthAnchor.constraintEqualToConstant(largeButtonSize).active = true
        nextButton.heightAnchor.constraintEqualToConstant(largeButtonSize).active = true
        
        let prevButton = JGTapButton(sideSize: largeButtonSize)
        prevButton.mainColor = buttonColor
        
        if let image = UIImage(named: prevButtonImage, inBundle: bundle, compatibleWithTraitCollection: nil) {
            prevButton.image = image
        } else {
            prevButton.title = "<"
        }
        
        prevButton.addTarget(self, action: "previous", forControlEvents: UIControlEvents.TouchUpInside)
        vc.view.addSubview(prevButton)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.centerYAnchor.constraintEqualToAnchor(vc.view.centerYAnchor).active = true
        prevButton.leadingAnchor.constraintEqualToAnchor(vc.view.leadingAnchor, constant: 6).active = true
        prevButton.widthAnchor.constraintEqualToConstant(largeButtonSize).active = true
        prevButton.heightAnchor.constraintEqualToConstant(largeButtonSize).active = true
        
        self.nextButton = nextButton
        self.prevButton = prevButton
    }
    
    internal func createCloseControlAndAddToSubview(vc: UIViewController) {
        
        let closeButton = JGTapButton(sideSize: smallButtonSize)
        closeButton.mainColor = buttonColor
        
        if let image = UIImage(named: closeButtonImage, inBundle: bundle, compatibleWithTraitCollection: nil) {
            closeButton.image = image
        } else {
            closeButton.title = "X"
        }
        closeButton.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
        vc.view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraintEqualToAnchor(vc.topLayoutGuide.bottomAnchor, constant: 6).active = true
        closeButton.trailingAnchor.constraintEqualToAnchor(vc.view.trailingAnchor, constant: -6).active = true
        closeButton.widthAnchor.constraintEqualToConstant(smallButtonSize).active = true
        closeButton.heightAnchor.constraintEqualToConstant(smallButtonSize).active = true
        
        self.closeButton = closeButton
    }
    
    // MARK: hide functions
    
    internal func hideNextControl(hidden: Bool) {
        nextButton.hidden = hidden
    }
    
    internal func hidePrevControl(hidden: Bool) {
        prevButton.hidden = hidden
    }
    
    // MARK: trigger the delegates
    
    internal func close() { delegateScrollerControl?.close() }
    
    internal func next() { delegateScrollerControl?.nextPage() }
    
    internal func previous() { delegateScrollerControl?.previousPage() }
}
