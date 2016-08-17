//
//  JYMagicPopTransion.swift
//  JYMagicMove
//
//  Created by 杨勇 on 16/8/16.
//  Copyright © 2016年 JackYang. All rights reserved.
//

import UIKit

class JYMagicPopTransion: NSObject ,UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //拿到 fromVC 和 toVC 以及 容器
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! JYDetailController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        let container = transitionContext.containerView()
        
        //拿到快照
        let snapshotView = fromVC.avaterImageView.snapshotViewAfterScreenUpdates(false)
        snapshotView.frame = container!.convertRect(fromVC.avaterImageView.frame, fromView: fromVC.avaterImageView.superview)
        fromVC.avaterImageView.hidden = true
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.selectCell.imageView.hidden = true
        
        container?.insertSubview(toVC.view, belowSubview: fromVC.view)
        container?.addSubview(snapshotView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { 
            () -> Void in
            snapshotView.frame = container!.convertRect(toVC.selectCell.imageView.frame, fromView: toVC.selectCell.imageView.superview)
            fromVC.view.alpha = 0
        }) { (finish: Bool) -> Void in
            toVC.selectCell.imageView.hidden = false
            snapshotView.removeFromSuperview()
            fromVC.avaterImageView.hidden = false
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }
}
