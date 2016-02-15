//
//  CloseViewController.swift
//  JGScroller
//
//  Created by Jeff on 2/4/16.
//
//

import JGScrollerController

public class CloseViewController: UIViewController, JGScrollerControlLink, JGScrollPage {
    
    public var delegateScrollerControl: JGScrollerControlDelegate?

    @IBAction func CloseScroller() {
        delegateScrollerControl?.close()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func scrollerDidScroll(positionX: CGFloat, offset: CGFloat) {
        print("positionX: \(positionX) offset: \(offset)")
    }
    
    public func scrollerDidEndAtPage(currentPage: Int, pageIndexNumber: Int) {
        print(currentPage)
    }
}
