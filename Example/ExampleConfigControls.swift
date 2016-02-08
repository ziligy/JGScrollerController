//
//  ExampleConfig.swift
//  JGScroller
//
//  Created by Jeff on 2/4/16.
//
//

import JGScrollerController

/// see ScrollerControllerConfig protocol for documention
struct ExampleConfigControls: JGScrollerControllerConfig {
    
    let storyboardName = "Main"
    
    let scrollerControllerIdentifier = "scroller"
    
    let viewControllerPageIdentifiers = [
        "pageZero",
        "pageOne",
        "pageTwo",
        "pageThree"
    ]
    
    let showPageControl = false
    
    let showNextAndPreviousControls = true
    
    let showCloseControl = true
    
    let showMenu = false
    
    let menuOrientation: ViewOrientation = .TopCenter
    
    let menuHeight: CGFloat = 0
    
    let menuImages = [String]()
}
