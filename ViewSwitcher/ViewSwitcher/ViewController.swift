//
//  ViewController.swift
//  ViewSwitcher
//
//  Created by iGuest on 10/27/15.
//  Copyright (c) 2015 iGuest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var alpha : AlphaViewController!
    private var beta : BetaViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        alphaLoader()
        alpha.view.frame = view.frame
        switchViewController(nil, to: alpha)
    }
    
    private func alphaLoader() -> () {
        if alpha == nil {
            alpha = storyboard?.instantiateViewControllerWithIdentifier("Alpha") as! AlphaViewController
        }
    }
    
    private func betaLoader() {
        if beta == nil {
            beta = storyboard?.instantiateViewControllerWithIdentifier("Beta") as! BetaViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchViews(sender: UIBarButtonItem) {
        alphaLoader()
        betaLoader()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        
        if alpha != nil && alpha?.view.superview != nil {
            // alpha is currently displayed
            UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
            beta.view.frame = view.frame
            switchViewController(alpha, to: beta)
        } else {
            // currently beta
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            alpha.view.frame = view.frame
            switchViewController(beta, to: alpha)
        }
        
        UIView.commitAnimations()
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
    }

}

