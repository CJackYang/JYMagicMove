//
//  JYDetailController.swift
//  JYMagicMove
//
//  Created by 杨勇 on 16/8/16.
//  Copyright © 2016年 JackYang. All rights reserved.
//

import UIKit

class JYDetailController: UIViewController ,UINavigationControllerDelegate{

    @IBOutlet weak var avaterImageView: UIImageView!
    
    private var percentDrivenTransition :UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        let edgePan = UIScreenEdgePanGestureRecognizer.init(target: self, action:Selector("edgePanGesture:"))
        edgePan.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(edgePan)
    }
    
    func edgePanGesture(edgePan:UIScreenEdgePanGestureRecognizer){
        let progress = edgePan.translationInView(self.view).x / self.view.bounds.width
        if edgePan.state == UIGestureRecognizerState.Began {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        } else if edgePan.state == UIGestureRecognizerState.Changed {
            self.percentDrivenTransition?.updateInteractiveTransition(progress)
        } else if edgePan.state == UIGestureRecognizerState.Cancelled || edgePan.state == UIGestureRecognizerState.Ended {
            if progress > 0.5 {
                self.percentDrivenTransition?.finishInteractiveTransition()
            } else {
                self.percentDrivenTransition?.cancelInteractiveTransition()
            }
            self.percentDrivenTransition = nil
        }
    }

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Pop {
            return JYMagicPopTransion()
        } else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is JYMagicPopTransion {
            return self.percentDrivenTransition
        } else {
            return nil
        }
    }
    
}
