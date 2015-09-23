//
//  KeyboardHidingUITests.swift
//  KeyboardHidingUITests
//
//  Created by Ivan M on 9/18/15.
//  Copyright © 2015 Ivan M. All rights reserved.
//

import XCTest

class KeyboardHidingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        XCUIDevice.sharedDevice().orientation = .Portrait
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        let textView = app.textViews["EntryTextView"]
        let tableView = app.tables["Empty list"]
        let textViewY = textView.frame.origin.y
        
        //
        // TextView tap raises the keyboard
        //
        textView.tap()
        
        XCTAssertFalse(isKeyboardHidden(),
            "Expected keyboard to be visible")
        XCTAssertEqualWithAccuracy(textView.frame.origin.y, textViewY - keyboardHeight() - 4, accuracy: 0.1,
            "Expected textView to accomodate visible keyboard height")

        //
        // Tapping away from TextView hides the keyboard
        //
        tableView.tap()
        
        XCTAssertTrue(isKeyboardHidden(),
            "Expected keyboard to be hidden")

        XCTAssertEqualWithAccuracy(textView.frame.origin.y, textViewY, accuracy: 0.1,
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
