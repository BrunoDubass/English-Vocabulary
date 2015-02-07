//
//  AppDelegate.m
//  English Vocabulary
//
//  Created by Bruno Domínguez on 16/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "AppDelegate.h"
#import "BDBWordsModel.h"
#import "BDBWordsTableViewController.h"
#import "BDBDefinitionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self configureForPad];
    }else{
        [self configureForPhone];
    }
    
    
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CONFIGURATION

-(void)configureForPad{
    
    //MODELO
    
    BDBWordsModel* model = [[BDBWordsModel alloc]init];

    //CONTROLADOR
    
    BDBWordsTableViewController* tableVC = [[BDBWordsTableViewController alloc]initWithModel:model];
    
    BDBDefinitionViewController* def = [[BDBDefinitionViewController alloc]initWithModel:[tableVC lastSelectedWord]];
    
    //NAVIGATOR
    
    UINavigationController* navTableVC = [[UINavigationController alloc]initWithRootViewController:tableVC];
    UINavigationController* navDefVC = [[UINavigationController alloc]initWithRootViewController:def];
    
    
    //SPLIT VIEW CONTROLLER
    
    UISplitViewController* splitVC = [[UISplitViewController alloc]initWithNibName:nil bundle:nil];
    splitVC.viewControllers = @[navTableVC, navDefVC];
    def.navigationItem.rightBarButtonItem = splitVC.displayModeButtonItem;
    //DELEGATES
    
    tableVC.delegate = def;
    splitVC.delegate = def;
    
    //ROOT
    
    self.window.rootViewController = splitVC;
}

-(void)configureForPhone{
    
    //MODELO
    
    BDBWordsModel* model = [[BDBWordsModel alloc]init];
    //NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    //CONTROLADOR
    
    BDBWordsTableViewController* tableVC = [[BDBWordsTableViewController alloc]initWithModel:model];
    
    //NAVIGATOR
    
    UINavigationController* navTableVC = [[UINavigationController alloc]initWithRootViewController:tableVC];
    
    //DELEGATES
    
    tableVC.delegate = tableVC;
    
    //ROOT
    
    self.window.rootViewController = navTableVC;
}

@end
