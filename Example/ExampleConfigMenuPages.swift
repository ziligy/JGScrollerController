//
//  ExampleConfig.swift
//  JGScroller
//
//  Created by Jeff on 2/4/16.
//
//

import JGScrollerController

/// see ScrollerControllerConfig protocol for documention
struct ExampleConfigMenuPages: JGScrollerControllerConfig {
    
    let storyboardName = "Main"
    
    let scrollerControllerIdentifier = "scroller"
    
    let viewControllerPageIdentifiers = [
        "pageZero",
        "pageOne",
        "pageTwo",
        "pageThree"
    ]
    
    let showMenu = true
    
    let menuOrientation: ViewOrientation = .BottomCenter
    
    let menuHeight: CGFloat = 40
    
    let menuImages = [String]()
    
    let showPageControl = false
    
    let showNextAndPreviousControls = false
    
    let showCloseControl = true
}
