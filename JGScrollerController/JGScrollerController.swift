//
//  JGVCScrollerController.swift
//
//  Created by Jeff on 1/26/16.
//  Copyright © 2016 Jeff Greenberg. All rights reserved.
//

import UIKit

/// adopt this to recieve scroller status
@objc public protocol JGScrollPage {
    func scrollerDidScroll(positionX: CGFloat, offset: CGFloat)
    // user pages should adopt this
    optional func scrollerDidEndAtPage(currentPage: Int, pageIndexNumber: Int)
    // controls, e.g. ScrollerMenu adopt this
    optional func scrollerDidEndAtPage(currentPage: Int)
}

/// pages that want to call-back to the scroller's controls should adopt this
public protocol JGScrollerControlLink {
    var delegateScrollerControl: JGScrollerControlDelegate? { get set }
}

/// implemented interface controls
public protocol JGScrollerControlDelegate {
    func close()
    func nextPage()
    func previousPage()
    func gotoPageNumber(pageNumber: Int)
    func gotoPageID(pageID: String)
}

/// main class that defines the scroller
public class JGScrollerController: UIViewController, UIScrollViewDelegate, JGScrollerControlDelegate {
    
    public var delegateScroll: JGScrollPage!
    
    private var scrollerConfig: JGScrollerControllerConfig!
    
    private var scrollerControls: ScrollerControls!
    
    private var scrollerMenu: ScrollerMenu!
    
    private let pageControl =  UIPageControl()
    private var scrollview = UIScrollView()
    private var controllers = [UIViewController]()
    
    private let pageControlColor = UIColor.grayColor()
    private let pageControlHighlightColor = UIColor.redColor()
    
    /// index of the current page
    public var currentPage: Int {
        get {
            return Int((scrollview.contentOffset.x / view.bounds.size.width))
        }
    }
    
    public func initScrollerController(scrollerConfig: JGScrollerControllerConfig) {
        self.scrollerConfig = scrollerConfig
        
        let storyboard = UIStoryboard(name: scrollerConfig.storyboardName, bundle: nil)
        
        for vcID in scrollerConfig.viewControllerPageIdentifiers {
            addViewController(storyboard.instantiateViewControllerWithIdentifier(vcID))
        }
        
        buildConstraints()
        
        if (scrollerConfig.showNextAndPreviousControls || scrollerConfig.showCloseControl) {
            scrollerControls = ScrollerControls()
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        createScrollerControls()
        createPageControl()
        createMenu()
        setPage(currentPage)
    }
    
    private func createMenu() {
        guard scrollerConfig.showMenu else { return }
        
        var imageNames = scrollerConfig.menuImages
        
        // if there's no menu images then send array of empty strings
        //  & ScrollerMenu will use page numbers for items
        if imageNames.isEmpty {
            imageNames = scrollerConfig.viewControllerPageIdentifiers.map {_ in return "" }
        }
        
        scrollerMenu = ScrollerMenu(parent: self, imageNames: imageNames, height: scrollerConfig.menuHeight, orientaion: scrollerConfig.menuOrientation)
    }
    
    private func setupScrollView() {
        
        scrollview.delegate = self
        
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.pagingEnabled = true
        
        view.insertSubview(scrollview, atIndex: 0) // scrollview must be first subview
        
        // Set initial scrollview constraints
        scrollview.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        scrollview.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        scrollview.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        scrollview.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
    }
    
    public func addViewController(vc:UIViewController) {
        controllers.append(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        scrollview.addSubview(vc.view)
        
        if var vcWantsControlLink = vc as? JGScrollerControlLink {
            vcWantsControlLink.delegateScrollerControl = self
        }
    }
    
    private func createPageControl() {
        guard scrollerConfig.showPageControl else { return }
        
        pageControl.pageIndicatorTintColor = pageControlColor
        pageControl.currentPageIndicatorTintColor = pageControlHighlightColor
        view.addSubview(pageControl)
        pageControl.addTarget(self, action: "pageControlDidTouch", forControlEvents: UIControlEvents.TouchUpInside)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        pageControl.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    private func createScrollerControls() {
        if let cbs = scrollerControls {
            
            cbs.delegateScrollerControl = self
            
            if scrollerConfig.showNextAndPreviousControls {
                cbs.createNextAndPreviousControlAndAddToSubview(self)
            }
            
            if scrollerConfig.showCloseControl {
                cbs.createCloseControlAndAddToSubview(self)
            }
        }
    }
    
    public func buildConstraints() {
        guard controllers.count > 0 else { return }
        
        var previousView = controllers.first!.view
        
        for vc in controllers {
            
            let newView = vc.view
            
            newView.topAnchor.constraintEqualToAnchor(scrollview.topAnchor).active = true
            newView.heightAnchor.constraintEqualToAnchor(scrollview.heightAnchor).active = true
            newView.widthAnchor.constraintEqualToAnchor(scrollview.widthAnchor).active = true
            
            // skip the first
            if (newView != previousView) {
                newView.leadingAnchor.constraintEqualToAnchor(previousView!.trailingAnchor).active = true
                previousView = newView
            }
        }
        
        scrollview.leadingAnchor.constraintEqualToAnchor(controllers.first!.view.leadingAnchor).active = true
        scrollview.trailingAnchor.constraintEqualToAnchor(controllers.last!.view.trailingAnchor).active = true
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) { setPage(currentPage) }
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) { setPage(currentPage) }
    
    private func setPage(currentPage: Int) {
        
        pageControl.currentPage = currentPage
        
        scrollViewDidEndScroll(currentPage)
        
        if scrollerConfig.showNextAndPreviousControls {
            scrollerControls!.hideNextControl(currentPage == controllers.count - 1 ? true : false)
            scrollerControls!.hidePrevControl(currentPage == 0 ? true : false)
        }
    }
    
    // MARK: Page Controls
    public func nextPage() {
        if (currentPage + 1) < controllers.count {
            gotoPageNumber(currentPage + 1)
        }
    }
    
    public func previousPage() {
        if currentPage > 0 {
            gotoPageNumber(currentPage - 1)
        }
    }
    
    public func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    public func gotoPageNumber(pageNumber: Int) {
        if pageNumber < controllers.count {
            let originX = CGFloat(pageNumber) * view.frame.width
            scrollview.setContentOffset(CGPoint(x: originX, y: 0), animated: true)
        }
    }
    
    public func gotoPageID(pageID: String) {
        gotoPageNumber( scrollerConfig.viewControllerPageIdentifiers.indexOf(pageID) ?? 0 )
    }
    
    internal func pageControlDidTouch() {
        gotoPageNumber(pageControl.currentPage)
    }
    
    // MARK: view display overrides
    
    override public  func viewWillAppear(animated: Bool) {
        pageControl.numberOfPages = controllers.count
        pageControl.currentPage = 0
    }
    
    override public func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        let originX = CGFloat(currentPage) * size.width
        
        dispatch_async(dispatch_get_main_queue()) {
            self.scrollview.setContentOffset(CGPoint(x: originX, y: 0), animated: false)
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: trigger updates/delegates
    
    public func scrollViewDidScroll(sv: UIScrollView) {
        
        let contentWidth = view.bounds.size.width
        let currentPage = self.currentPage
        let positionX = sv.contentOffset.x
        let offset = (positionX / contentWidth)
        
        delegateScroll?.scrollerDidScroll(sv.contentOffset.x, offset: offset)
        
        let lookAheadAndBack = 3 // number of pages to update before & after current page
        
        for (index, value) in controllers.enumerate() {
            
            if let vcWantsScrollUpdate = value as? JGScrollPage {
                
                if (index >= currentPage - lookAheadAndBack && index <= currentPage + lookAheadAndBack) {
                    vcWantsScrollUpdate.scrollerDidScroll(positionX, offset: offset)
                }
            }
        }
    }
    
    public func scrollViewDidEndScroll(currentPage: Int) {
        
        // pageNumber is only used by pages
        delegateScroll?.scrollerDidEndAtPage!(currentPage)
        
        let lookAheadAndBack = 5 // number of pages to update before & after current page
        
        for (index, value) in controllers.enumerate() {
            
            if let vcWantsScrollUpdate = value as? JGScrollPage {
                
                if (index >= currentPage - lookAheadAndBack && index <= currentPage + lookAheadAndBack) {
                    vcWantsScrollUpdate.scrollerDidEndAtPage!(currentPage, pageIndexNumber: index)
                }
            }
        }
    }
    
}

