//
//  ViewController.swift
//  UIDynamicAnimator-Gravity
//
//  Created by Nam (Nick) N. HUYNH on 3/21/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bottomBoundary = "bottomBoundary"
    var squareViews = [AnyObject]()
    var animator: UIDynamicAnimator?
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        let colors = [UIColor.redColor(), UIColor.greenColor()]
        var currentCenterPoint = view.center
        let eachViewSize = CGSize(width: 50, height: 50)
        for counter in 0 ..< 2 {
            
            let newView = UIView(frame: CGRectMake(0, 0, eachViewSize.width, eachViewSize.height))
            newView.backgroundColor = colors[counter]
            newView.center = currentCenterPoint
            currentCenterPoint.y += eachViewSize.height + 10
            squareViews.append(newView)
            view.addSubview(newView)
            
        }
        animator = UIDynamicAnimator(referenceView: view)
        let gravity = UIGravityBehavior(items: squareViews)
        animator!.addBehavior(gravity)
        let collision = UICollisionBehavior(items: squareViews)
        let startPoint = CGPoint(x: 0, y: view.bounds.size.height - 100)
        let toPoint = CGPoint(x: view.bounds.size.width, y: view.bounds.size.height - 100)
        collision.addBoundaryWithIdentifier(bottomBoundary, fromPoint: startPoint, toPoint: toPoint)
        collision.collisionDelegate = self
        collision.collisionMode = UICollisionBehaviorMode.Items
        animator!.addBehavior(collision)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UICollisionBehaviorDelegate {
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        
        if identifier as? String == bottomBoundary {
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                let view = item as UIView
                
                view.backgroundColor = UIColor.redColor()
                view.alpha = 0
                view.transform = CGAffineTransformMakeScale(4, 4)
                
            }, completion: { (finished) -> Void in
                
                let view = item as UIView
                behavior.removeItem(item)
                view.removeFromSuperview()
                
            })
            
        }
        
    }
    
}