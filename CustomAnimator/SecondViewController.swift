//
//  SecondViewController.swift
//  CustomAnimator
//
//  Created by Payal Gupta on 3/7/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController
{
    //MARK: Private Properties
    fileprivate let animator = Animator()
    
    //MARK: Internal Properties
    var transitionType : TransitionType = .pushFromBottom
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }

    //MARK: Button Action Methods
    @IBAction func dismissController(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate Methods
extension SecondViewController : UIViewControllerTransitioningDelegate
{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        self.animator.transitionType = self.transitionType
        self.animator.insets = UIEdgeInsets.init(top: 30, left: 30, bottom: 30, right: 30)
        self.animator.duration = 0.3
        return self.animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self.animator
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let presentationController = NNBackDropController(presentedViewController: presented, presentingViewController: source, dismissPresentedControllerOnTap : true)
        return presentationController
    }
}
