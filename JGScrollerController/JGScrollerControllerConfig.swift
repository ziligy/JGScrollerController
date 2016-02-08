//
//  JGScrollerControllerConfig.swift
//  JGScrollerController
//
//  Created by Jeff on 1/31/16.
//  Copyright © 2016 Jeff Greenberg. All rights reserved.
//

/// protocol required to configure JGScrollerController
/// used to assign viewControllers to be scrolled
/// & select optional menu and/or page controls
public protocol JGScrollerControllerConfig {
    
    /// the name of the storyboard in which the ViewControllers are located
    var storyboardName: String { get }
    
    /// the Storyboard ID of the scroller itself
    /// generally an empty ViewController with custom class set to JGScrollerController
    var scrollerControllerIdentifier: String { get }
    
    /// the Storyboard IDs of the ViewControllers to be scrolled
    var viewControllerPageIdentifiers: [String] { get }
    
    // MARK:  control options
    
    /// use showPageControl to display a UIPageControl
    var showPageControl: Bool{ get }
    /// use showNextAndPreviousControls to display a scroll control buttons
    var showNextAndPreviousControls: Bool{ get }
    /// use showCloseControl to display an exit/close button
    var showCloseControl: Bool{ get }

    
    // MARK: menu options
    
    /// use showMenu to display a menu
    var showMenu: Bool{ get }
    /// defines how to pin the menu
    var menuOrientation: ViewOrientation { get }
    /// defines menu button size
    var menuHeight: CGFloat { get }
    /// custom button images
    /// - if empty then menu defaults to page numbers
    var menuImages: [String] { get }
    
    }

/// adopt this to initialize & present the main scroller controller e.g:
/// ```swift
///    internal func presentScroller(scrollerConfig: JGScrollerControllerConfig) {
///
///        var scrollerController: JGScrollerController!
///
///        let storyboard = UIStoryboard(name: scrollerConfig.storyboardName, bundle: nil)
///
///        scrollerController = storyboard.instantiateViewControllerWithIdentifier(scrollerConfig.scrollerControllerIdentifier) as! JGScrollerController
///
///        scrollerController.initScrollerController(scrollerConfig)
///
///        self.presentViewController(scrollerController, animated: true, completion: nil)
///    }
/// ```
public protocol ScrollerPrensenter {
    func presentScroller(scrollerConfig: JGScrollerControllerConfig)
}

