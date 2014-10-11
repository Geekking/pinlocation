//
//  AppDelegate.swift
//  PinLocation
//
//  Created by apple on 10/8/14.
//  Copyright (c) 2014 SYSU. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var drawerViewController:PLDrawerViewController?
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        
        //self.window!.backgroundColor = UIColor.whiteColor()
        
        self.drawerViewController = PLDrawerViewController()
        
        var homeViewController:HomePageTableViewController = HomePageTableViewController()
        
        var navCtl:UINavigationController = UINavigationController(rootViewController: homeViewController)
        
        
        var drawerContent:DrawerContentTableViewController = DrawerContentTableViewController()
        
        drawerViewController!.centerViewController = navCtl
        drawerViewController!.contentViewController = drawerContent
        
        //添加导航栏按钮
        var image  = UIImage(named:"hamburger.png");
        
        var button  =  UIButton.buttonWithType(UIButtonType.System) as? UIButton
        
        button!.frame =  CGRectMake(0, 0, 44.0, 44.0)
        
        button!.addTarget(self,action:"tappedButton:",
            forControlEvents:UIControlEvents.TouchUpInside)
        
        button!.setImage(image,forState:UIControlState.Normal)
        
        
        var barButton =  UIBarButtonItem(customView: button)
        
        //为什么不能是navCtrl
        homeViewController.navigationItem.leftBarButtonItem = barButton
        
        self.window!.rootViewController = drawerViewController
        
        self.window!.makeKeyAndVisible()
        
        return true
        
    }
    
    //导航栏按钮事件
    func tappedButton(button : UIButton){
        if (drawerViewController!.drawerState == DrawerState.DrawerStateOpening){
            drawerViewController!.didClose()
        }else{
            drawerViewController!.didOpen()
        }
    }
    
    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

