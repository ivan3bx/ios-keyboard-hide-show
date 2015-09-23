//
//  KeyboardHidingUITests.swift
//  KeyboardHidingUITests
//
//  Created by Ivan M on 9/18/15.
//  Copyright © 2015 Ivan M. All rights reserved.
//

import XCTest

class KeyboardHidingUITests: XCTestCase {
    var textView:XCUIElement!
    var tableView:XCUIElement!
    var textViewOrigin:CGPoint!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        XCUIDevice.sharedDevice().orientation = .Portrait

        let app = XCUIApplication()
        textView = app.textViews["EntryTextView"]
        tableView = app.tables["Empty list"]
        textViewOrigin = textView.frame.origin
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShowAndHide() {
        
        //
        // TextView tap raises the keyboard
        //
        textView.tap()
        
        XCTAssertFalse(isKeyboardHidden(),
            "Expected keyboard to be visible")
        XCTAssertEqualWithAccuracy(textView.frame.origin.y, textViewOrigin.y - keyboardHeight() - 4, accuracy: 0.1,
            "Expected textView to accomodate visible keyboard height")

        //
        // Tapping away from TextView hides the keyboard
        //
        tableView.tap()
        
        XCTAssertTrue(isKeyboardHidden(),
            "Expected keyboard to be hidden")

        XCTAssertEqualWithAccuracy(textView.frame.origin.y, textViewOrigin.y, accuracy: 0.1,
            "Expected textView to slide back to origin")
    }
    
    private func isKeyboardHidden() -> Bool {
        let app = XCUIApplication()
        let keyboard = app.keyboards.elementBoundByIndex(0)
        
        // Keyboard element has no children when not visible
        return (keyboard.childrenMatchingType(.Any).count == 0)
    }
    
    private func keyboardHeight() -> CGFloat {
        let app = XCUIApplication()
        let keyboard = app.keyboards.elementBoundByIndex(0)
        return keyboard.frame.height
    }
}
