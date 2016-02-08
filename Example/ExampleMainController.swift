//
//  ViewController.swift
//  JGVCScroller
//
//  Created by Jeff on 1/27/16.
//  Copyright © 2016 Jeff Greenberg. All rights reserved.
//

import JGScrollerController

class ExampleMainController: UIViewController, ScrollerPrensenter {
    
    @IBAction func ExampleAll() {
        presentScroller(ExampleConfigAll())
    }
    
    @IBAction func ExampleControls() {
        presentScroller(ExampleConfigControls())
    }
    
    @IBAction func ExampleMenu() {
        presentScroller(ExampleConfigMenu())
    }
    
    @IBAction func ExampleMenuPages() {
        presentScroller(ExampleConfigMenuPages())
    }
    
    @IBAction func ExampleNoControls() {
        presentScroller(ExampleConfigNoControls())
    }
    
    internal func presentScroller(scrollerConfig: JGScrollerControllerConfig) {
        
        var scrollerController: JGScrollerController!

        let storyboard = UIStoryboard(name: scrollerConfig.storyboardName, bundle: nil)
            
        scrollerController = storyboard.instantiateViewControllerWithIdentifier(scrollerConfig.scrollerControllerIdentifier) as! JGScrollerController
            
        scrollerController.initScrollerController(scrollerConfig)
        
        self.presentViewController(scrollerController, animated: true, completion: nil)
    }
        
}
