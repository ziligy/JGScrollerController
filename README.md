# ![icon](https://raw.githubusercontent.com/ziligy/JGScrollerController/master/gifs/jGScrollerController-github.png "icon") JGScrollerController

A Scrolling controller to scroll through UIViewController pages from your Storyboard. Simple config for quick and easy implementation.

## Example with menu
<img src="https://raw.githubusercontent.com/ziligy/JGScrollerController/master/gifs/example-with-menu.gif" alt="example-with-menu"/>

## Example with no menu or controls
<img src="https://raw.githubusercontent.com/ziligy/JGScrollerController/master/gifs/example-with-none.gif" alt="example-with-none"/>

## Example with controls
<img src="https://raw.githubusercontent.com/ziligy/JGScrollerController/master/gifs/example-with-controls.gif" alt="example-with-controls"/>

## Example with menu pages
<img src="https://raw.githubusercontent.com/ziligy/JGScrollerController/master/gifs/example-menu-pages.gif" alt="example-menu-pages"/>

## Example with menu & all controls
<img src="https://raw.githubusercontent.com/ziligy/JGScrollerController/master/gifs/example-all.gif" alt="example-all"/>

## Scrolling System:
* uses simple configuration protocol
* links to your storyboard's UIViewControllers by ID --> *no changes required*
* *optional* menu with live tracking
* *optional* controls for next, previous, close, and page
* pages can adopt *optional* procotol to recieve live scroller tracking

## Installation
* via Carthage: github "ziligy/JGScrollerController"
* or copy JGScrollerController folder to your project

## Usage
* Create a UIViewController in Interface Builder and assign JGScrollerController as Class and *scroller* as Storyboard ID.
* Assign a Storyboard ID for UIViewControllers (Pages) you want to scroll.
* Create a configuration struct that adopts JGScrollerControllerConfig protocol (see example struct below).
* Present the scroller (see example code below).

## Configuration via simple struct (example):
```swift
// this example will display all controls
// to turn off all controls set 'show' booleans to false
struct ExampleConfigAll: JGScrollerControllerConfig {

    let storyboardName = "Main"

    let scrollerControllerIdentifier = "scroller"

    // these are your page's Storyboard IDs
    let viewControllerPageIdentifiers = [
        "pageZero",
        "pageOne",
        "pageTwo",
        "pageThree"
    ]

    let showPageControl = true

    let showNextAndPreviousControls = true

    let showCloseControl = true

    let showMenu = true

    let menuOrientation: ViewOrientation = .TopCenter

    let menuHeight: CGFloat = 40

    // empty menuImages so page numbers will display
    let menuImages = [String]()
}
```

## Present the scroller (example):
```swift

func presentScroller(scrollerConfig: JGScrollerControllerConfig) {

        var scrollerController: JGScrollerController!

        let storyboard = UIStoryboard(name: scrollerConfig.storyboardName, bundle: nil)

        scrollerController = storyboard.instantiateViewControllerWithIdentifier(scrollerConfig.scrollerControllerIdentifier) as! JGScrollerController

        scrollerController.initScrollerController(scrollerConfig)

        self.presentViewController(scrollerController, animated: true, completion: nil)
    }
```

## Live tracking
To include live scroller tracking on your pages adopt the JGScrollPage protocol
```swift
/// adopt this to recieve scroller status
protocol JGScrollPage {
    func scrollerDidScroll(positionX positionX: CGFloat, offset: CGFloat)
    func scrollerDidEndAtPage(currentPage: Int)
}
```
## Call-back control
If you want your pages to call-back to the scroller adopt the JGScrollerControlLink protocol. Then your pages can call next, previous, gotoPage, and close methods on the scroller.


## Demo Example
***See attached Example project***

## Requirements
* Xcode 7.2
* Swift 2
* iOS 9.0+

## Attribution
* example icons: [google/material-design-icons](https://github.com/google/material-design-icons)

## Related
* [JGTapButton](https://github.com/ziligy/JGTapButton) the multi-purpose button included in the menu, controls, and example.

