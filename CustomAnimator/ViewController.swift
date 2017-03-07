//
//  ViewController.swift
//  CustomAnimator
//
//  Created by Payal Gupta on 3/7/17.
//  Copyright © 2017 Infoedge Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //MARK: Private Properties
    fileprivate var secondController : SecondViewController = {
       return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"SecondController") as! SecondViewController
    }()

    //MARK: View Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //MARK: Button Action Methods
    @IBAction func presentFromBottom(_ sender: UIButton)
    {
        secondController.transitionType = .pushFromBottom
        self.present(secondController, animated: true, completion: nil)
    }
    
    @IBAction func presentFromTop(_ sender: UIButton)
    {
        secondController.transitionType = .pushFromTop
        self.present(secondController, animated: true, completion: nil)
    }
    
    @IBAction func presentFromLeft(_ sender: UIButton)
    {
        secondController.transitionType = .pushFromLeft
        self.present(secondController, animated: true, completion: nil)
    }
    
    @IBAction func presentFromRight(_ sender: UIButton)
    {
        secondController.transitionType = .pushFromRight
        self.present(secondController, animated: true, completion: nil)
    }
    
    @IBAction func presentFromCenter(_ sender: UIButton)
    {
        secondController.transitionType = .zoom
        self.present(secondController, animated: true, completion: nil)
    }
}
