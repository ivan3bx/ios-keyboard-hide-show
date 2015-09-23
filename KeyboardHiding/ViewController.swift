//
//  ViewController.swift
//  KeyboardHiding
//
//  Created by Ivan M on 9/18/15.
//  Copyright © 2015 ivan3bx All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let PADDING:CGFloat = 4
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardWillShow(notification: NSNotification) {
        let info     = notification.userInfo!
        let keyboard = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let curve    = info[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        
        adjustForKeyboardTo(keyboard.size.height + ViewController.PADDING, duration:duration, curve:curve)
    }

    func keyboardWillHide(notification: NSNotification) {
        let info     = notification.userInfo!
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let curve    = info[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber

        adjustForKeyboardTo(0, duration:duration, curve:curve)
    }
    
    func adjustForKeyboardTo(newHeight:CGFloat, duration:NSTimeInterval, curve:NSNumber) {
        
        // Adjust constraint outside of the animation block
        self.bottomConstraint.constant = newHeight
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve.integerValue)!)

            // Adjusting the layout changes inside animation block
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textView.resignFirstResponder()
    }

}
