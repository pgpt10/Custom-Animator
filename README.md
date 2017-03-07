# Custom-Animator
Custom View Controller Transitioner

It handles the presenting of a view controller with custom transitions.

## Requirements

* Swift 3.0
* xcode 8

## Features

1. Transitions supported:

  1. Bottom
  2. Top
  3. Left
  4. Right
  5. Center

2. Also the following properties of the presenting controller can be modified according to the requirement:

  1. Duration
  2. Size
  3. Screen Insets
  4. Transition Type

3. Back Drop View : Greyish view between presenting controller and the presented controller. It is optional to use Back Drop View.

## How to use

To add custom animation to a controller to be presented (Eg. Controller), do the following
 
 1. Conform Controller to "UIViewControllerTransitioningDelegate" protocol
 2. Implement these methods of UIViewControllerTransitioningDelegate protocol:
    a) animationControllerForPresentedController
    b) animationControllerForDismissedController
    c) presentationControllerForPresentedViewController (optional) - For Back Drop View
 
 3. Set "transitioningDelegate" property of Controller to "self"
 4. Set "modalPresentationStyle" property of Controller to ".Custom"

### Note:
Comments are included in the project files to better understanding of the flow.
