//
//  Animator.swift
//
//
//  Created by Payal Gupta on 8/19/16.
//  Copyright © 2016 Info Edge India Ltd. All rights reserved.
//

/**
 READ ME: How to use Animator to add custom animations.
 
 To add custom animation to a controller to be presented (Eg. Controller), do the following
 
 1. Conform Controller to "UIViewControllerTransitioningDelegate" protocol
 2. Implement these methods of UIViewControllerTransitioningDelegate protocol:
    a) animationControllerForPresentedController
    b) animationControllerForDismissedController
    c) presentationControllerForPresentedViewController
 
 3. Set "transitioningDelegate" property of NNController to "self"
 4. Set "modalPresentationStyle" property of NNController to ".Custom"
 */

import UIKit

//MARK: Enums
enum TransitionType
{
    case pushFromBottom
    case pushFromTop
    case pushFromRight
    case pushFromLeft
    case zoom
}

final class Animator: NSObject
{
    //MARK: Private Properties
    fileprivate var presenting : Bool = true

    //MARK: Internal Properties..You have the option to set any of these properties while creating the object of Animator type. If you set none of these properties you will get the behavior as per the default values
    var duration : Double = 0.4
    var transitionType : TransitionType = .pushFromBottom
    //You can set any one out size/inset according to your requirement
    var size : CGSize = UIScreen.main.bounds.size
    var roundedCorners:Bool = false
    var insets : UIEdgeInsets{
        set{
            self.size = CGSize(width: UIScreen.main.bounds.width - newValue.left - newValue.right, height: UIScreen.main.bounds.height - newValue.top - newValue.bottom)
        }
        get{
            return UIEdgeInsets.zero
        }
    }
    
    //MARK: Private Methods
    /**
     This method gives the center position from where we have to present the controller initially and then where to dismiss the controller
     
     - parameter containerView: the view on which the controller is added as a subview. Center is calculated w.r.t this containter view
     
     - returns: returns the center position
     */
    fileprivate func getCenter(_ containerView : UIView) -> CGPoint
    {
        let center : CGPoint
        
        switch self.transitionType
        {
        case .pushFromBottom: center = CGPoint(x: containerView.center.x, y: 3 * containerView.center.y)
        case .pushFromTop: center = CGPoint(x: containerView.center.x, y: -3 * containerView.center.y)
        case .pushFromRight: center = CGPoint(x: 3 * containerView.center.x, y: containerView.center.y)
        case .pushFromLeft: center = CGPoint(x: -3 * containerView.center.x, y: containerView.center.y)
        case .zoom: center = containerView.center
        }
        return center
    }
}

// MARK: - UIViewControllerAnimatedTransitioning Methods
extension Animator : UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let animatingView = self.presenting ? toViewController.view : fromViewController.view
        animatingView?.frame.size = self.size
        
        if self.presenting
        {
            if roundedCorners {
                animatingView?.layer.cornerRadius = 0.5
                animatingView?.layer.masksToBounds = true
            }
            animatingView?.center = self.getCenter(containerView)
            containerView.addSubview(animatingView!)
        }

        if self.transitionType == .zoom
        {
            animatingView?.transform = self.presenting ? CGAffineTransform(scaleX: 0.01, y: 0.01) : CGAffineTransform.identity
        }
       
        UIView.animate(withDuration: self.duration, animations: {[unowned self] in
            animatingView?.center = self.presenting ? containerView.center : self.getCenter(containerView)
            if self.transitionType == .zoom
            {
                animatingView?.transform = self.presenting ? CGAffineTransform.identity : CGAffineTransform(scaleX: 0.01, y: 0.01)
            }
            }, completion: {(finished) in
                self.presenting = !self.presenting
                transitionContext.completeTransition(finished)
        })
    }
}

/*******************************************************************************************************/
// MARK: - NNBackDropController Class
class NNBackDropController: UIPresentationController
{
    //MARK: Private properties
    fileprivate var backDropView: UIView!
    
    //MARK: Initializer
    init(presentedViewController: UIViewController, presentingViewController: UIViewController, dismissPresentedControllerOnTap : Bool)
    {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.setupBackDropView(dismissPresentedControllerOnTap)
    }
    
    //MARK: Private methods
    /**
     This method create a view with black background that is initially transparent. It also adds a tap gesture to the view
     */
    fileprivate func setupBackDropView(_ dismissPresentedControllerOnTap : Bool)
    {
        self.backDropView = UIView(frame: UIScreen.main.bounds)
        self.backDropView.backgroundColor = UIColor.black
        self.backDropView.alpha = 0.0
        
        if dismissPresentedControllerOnTap
        {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backDropViewTapped))
            self.backDropView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    /**
     This method handles the tap gesture of the backDropView. It dismiss the presented view controller
     */
    @objc fileprivate func backDropViewTapped()
    {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Overridden methods of UIPresentationController
    override func presentationTransitionWillBegin()
    {
        self.containerView?.addSubview(self.backDropView)
        
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
            self.backDropView.alpha = 0.5
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin()
    {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
            self.backDropView.alpha = 0.0
            }, completion: nil)
    }
}
