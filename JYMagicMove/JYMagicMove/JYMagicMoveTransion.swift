//
//  JYMagicMoveTransion.swift
//  JYMagicMove
//
//  Created by 杨勇 on 16/8/16.
//  Copyright © 2016年 JackYang. All rights reserved.
//

import UIKit

class JYMagicMoveTransion: NSObject ,UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //拿到 fromVC 和 toVC 以及 容器
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! JYDetailController
        let container = transitionContext.containerView();
        
        //拿到 cell上的 imageView的快照 隐藏 cell上的imageView
        let snapshotView = fromVC.selectCell.imageView.snapshotViewAfterScreenUpdates(false)
        //设置快照的frame
        snapshotView.frame = container!.convertRect(fromVC.selectCell.imageView.frame, fromView: fromVC.selectCell.imageView.superview)
        //隐藏
        fromVC.selectCell.imageView.hidden = true
        
        //设置toVC 的位置 并设置为透明
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.view.alpha = 0
        toVC.avaterImageView.hidden = true
        
        //把 toVC的 view 和 快照 加到 容器 上，顺序！
        container?.addSubview(toVC.view)
        container?.addSubview(snapshotView)
        
        //做动画前先把avaterImageView 的frame 更新一下 不然 storyboard 尺寸没有更新
//        toVC.avaterImageView.layoutIfNeeded()
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            () -> Void in
            //动画
            toVC.view.layoutIfNeeded()
            snapshotView.frame = toVC.avaterImageView.frame
            toVC.view.alpha = 1
        }) { (finish:Bool) -> Void in
            fromVC.selectCell.imageView.hidden = false // 把之前隐藏的 显示出来
            toVC.avaterImageView.hidden = false
            snapshotView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
}
