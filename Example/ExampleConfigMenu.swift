//
//  ExampleConfig.swift
//  JGScroller
//
//  Created by Jeff on 2/4/16.
//
//

import JGScrollerController

/// see ScrollerControllerConfig protocol for documention
struct ExampleConfigMenu: JGScrollerControllerConfig {
    
    let storyboardName = "Main"
    
    let scrollerControllerIdentifier = "scroller"
    
    let viewControllerPageIdentifiers = [
        "pageZero",
        "pageOne",
        "pageTwo",
        "pageThree"
    ]
    
    let showPageControl = false
    
    let showNextAndPreviousControls = false
    
    let showCloseControl = true
    
    let showMenu = true
    
    let menuOrientation: ViewOrientation = .TopCenter
    
    let menuHeight: CGFloat = 55
    
    let menuImages = [
        "ic_home_white_36pt.png",
        "ic_camera_alt_white_36dp.png",
        "ic_favorite_white_36pt.png",
        "ic_timeline_white_36pt.png"
    ]
}
