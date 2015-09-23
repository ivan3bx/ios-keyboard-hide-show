# Responding to keyboard hide/show events

There are several ways folks choose to respond to keyboard hide/show notifications,
some which require more boilerplate code to accomodate interface rotation events.
This project demonstrates the most straightforward way I know to do this (in Swift).

### How to use this
Check out the code and run the test; it's meant as a playground for exploring additional
transformations during keyboard show/hide transition.

### The code
This project doesn't have anything else going on outside of the contents in ViewController.

### The test case
I added a UI test (Xcode 7+).  Recording the test is easy, but assertions proved problematic in
terms of the keyboard display state.

There doesn't seem to be an easy way to assert keyboard presence aside from doing this.

```swift
private func isKeyboardHidden() -> Bool {
    let app = XCUIApplication()
    let keyboard = app.keyboards.elementBoundByIndex(0)
    
    // Keyboard element has no children when not visible
    return (keyboard.childrenMatchingType(.Any).count == 0)
}
```

The above works (as of Xcode 7.1b), but I would suspect this may fail in some unforseen cases.
