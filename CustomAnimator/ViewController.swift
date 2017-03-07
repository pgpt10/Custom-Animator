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
        sender.backgroundColor = UIColor.red
        self.present(secondController, animated: true, completion: {
            sender.backgroundColor = UIColor.lightGray
        })
    }
    
    @IBAction func presentFromTop(_ sender: UIButton)
    {
        secondController.transitionType = .pushFromTop
        sender.backgroundColor = UIColor.red
        self.present(secondController, animated: true, completion: {
            sender.backgroundColor = UIColor.lightGray
        })    }
    
    @IBAction func presentFromLeft(_ sender: UIButton)
    {
        secondController.transitionType = .pushFromLeft
        sender.backgroundColor = UIColor.red
        self.present(secondController, animated: true, completion: {
            sender.backgroundColor = UIColor.lightGray
        })    }
    
    @IBAction func presentFromRight(_ sender: UIButton)
    {
        secondController.transitionType = .pushFromRight
        sender.backgroundColor = UIColor.red
        self.present(secondController, animated: true, completion: {
            sender.backgroundColor = UIColor.lightGray
        })    }
    
    @IBAction func presentFromCenter(_ sender: UIButton)
    {
        secondController.transitionType = .zoom
        sender.backgroundColor = UIColor.red
        self.present(secondController, animated: true, completion: {
            sender.backgroundColor = UIColor.lightGray
        })    }
}
