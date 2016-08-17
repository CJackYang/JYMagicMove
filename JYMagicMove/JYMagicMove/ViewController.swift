//
//  ViewController.swift
//  JYMagicMove
//
//  Created by 杨勇 on 16/8/16.
//  Copyright © 2016年 JackYang. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,UINavigationControllerDelegate {

    var selectCell : JYMagicCell!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation ==  UINavigationControllerOperation.Push{
            return JYMagicMoveTransion()
        }else{
            return nil
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
//            let detailVC = segue.destinationViewController as! JYDetailController
//            detailVC.image = self.selectedCell.imageView.image
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! JYMagicCell
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectCell = collectionView.cellForItemAtIndexPath(indexPath) as! JYMagicCell
        
        self.performSegueWithIdentifier("detail", sender: nil)
    }



}

