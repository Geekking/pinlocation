//
//  DrawerViewController.swift
//  PinLocation
//
//  Created by apple on 10/10/14.
//  Copyright (c) 2014 SYSU. All rights reserved.
//

import UIKit
let DrawerLeftViewInitialOffset:CGFloat = 60.0
let DrawerControllerDepth:CGFloat = 200.0

enum DrawerState: Int {
    case DrawerStateOpening
    case DrawerStateClosing
}

class PLDrawerViewController: UIViewController {
    
    var tapGestureRecognizer:UITapGestureRecognizer! = nil
    
    var panGestureRecognizer:UIPanGestureRecognizer! = nil
    var panGestureStatLocation: CGPoint! = nil
    
    var contentViewController: UIViewController! = nil
    var centerViewController: UIViewController!  = nil
    
    var drawerState:DrawerState! = DrawerState.DrawerStateClosing
    
    //    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    //        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    //        // Custom initialization
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //        将左边控制器加入导航栏中。
        
        if self.contentViewController != nil{
            if (self.contentViewController.view.superview == nil){
                
                self.addChildViewController(self.contentViewController)
                
                self.view.insertSubview(self.contentViewController.view, atIndex:0)
                
            }
            
        }
        if self.centerViewController != nil{
            if (self.centerViewController.view.superview == nil){
                
                self.addChildViewController(self.centerViewController)
                
                self.view.addSubview(self.centerViewController.view)
                
            }
        }
        
        //        添加用户拖动事件。
        self.panGestureRecognizer = UIPanGestureRecognizer()
        self.panGestureRecognizer.addTarget(self,action:"panGestureRecognized:");
        self.centerViewController.view.addGestureRecognizer(self.panGestureRecognizer)
    }
    
    
    //    用户拖动视图调用代理方法。
    func panGestureRecognized(panGestureRecognizer:UIPanGestureRecognizer){
        var state = self.panGestureRecognizer.state
        
        var location = self.panGestureRecognizer.locationInView(self.view)
        var velocity = self.panGestureRecognizer.velocityInView(self.view)
        
        switch(state){
        case UIGestureRecognizerState.Began:
            self.panGestureStatLocation = location
            println("Began")
            break
        case UIGestureRecognizerState.Changed:
            var c = self.centerViewController.view.frame
            if self.panGestureRecognizer.translationInView(self.centerViewController.view).x > 0{
                if self.drawerState == DrawerState.DrawerStateClosing{
                    c.origin.x = location.x - self.panGestureStatLocation.x
                }
            }else if self.panGestureRecognizer.translationInView(self.centerViewController.view).x > -DrawerControllerDepth {
                if self.drawerState == DrawerState.DrawerStateOpening {
                    c.origin.x = self.panGestureRecognizer.translationInView(self.centerViewController.view).x + DrawerControllerDepth
                    
                }
            }
            self.centerViewController.view.frame = c
            break
        case UIGestureRecognizerState.Ended:
            var c = self.centerViewController.view.frame
            // 表示用户想打开
            if location.x - self.panGestureStatLocation.x > DrawerLeftViewInitialOffset{
                self.didOpen()
            }else {
                if c.origin.x < DrawerControllerDepth - 40 {
                    self.didClose()
                }else {
                    self.didOpen()
                }
            }
            break
        default:
            break
        }
        
    }
    
    //    移除点击事件，添加拖动事件
    func tapGestureRecognized(tapGestureRecognizer : UITapGestureRecognizer){
        self.didClose();
    }
    
    func didOpen(){
        var c = self.centerViewController.view.frame
        
        c.origin.x = DrawerControllerDepth
        
        UIView.animateWithDuration(0.7,delay:0,usingSpringWithDamping:0.5,initialSpringVelocity:1.0,options:UIViewAnimationOptions.AllowUserInteraction,animations:{
            self.centerViewController.view.frame = c ;
            },completion: { (finished: Bool) -> Void in
                
            })
        self.drawerState = DrawerState.DrawerStateOpening
        
        //增加点击事件
        if (self.tapGestureRecognizer == nil){
            
            self.tapGestureRecognizer  = UITapGestureRecognizer()
            self.tapGestureRecognizer.addTarget(self,action:"tapGestureRecognized:");
            
        }
        self.centerViewController.view.addGestureRecognizer(self.tapGestureRecognizer)
        
    }
    
    func didClose(){
        if self.drawerState == DrawerState.DrawerStateOpening{
            self.drawerState = DrawerState.DrawerStateClosing
            self.centerViewController.view.removeGestureRecognizer(self.tapGestureRecognizer)
            
            
        }
        var c = self.centerViewController.view.frame
        c.origin.x = 0
        UIView.animateWithDuration(0.5,delay:0,usingSpringWithDamping:0.9,initialSpringVelocity:1.0,options:UIViewAnimationOptions.AllowUserInteraction,animations:{
            self.centerViewController.view.frame = c ;
            },completion: { (finished: Bool) -> Void in
                
            })
        
    }
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
