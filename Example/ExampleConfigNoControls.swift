//
//  ExampleConfig.swift
//  JGScroller
//
//  Created by Jeff on 2/4/16.
//
//

import JGScrollerController

/// see ScrollerControllerConfig protocol for documention
struct ExampleConfigNoControls: JGScrollerControllerConfig {
    
    let storyboardName = "Main"
    
    let scrollerControllerIdentifier = "scroller"
    
    let viewControllerPageIdentifiers = [
        "pageZero",
        "pageOne",
        "pageTwo",
        "pageThree",
        "close"
    ]
    
    let showPageControl = false
    
    let showNextAndPreviousControls = false
    
    let showCloseControl = false
    
    let showMenu = false
    
    let menuOrientation: ViewOrientation = .TopCenter
    
    let menuHeight: CGFloat = 0
    
    let menuImages = [String]()
}
