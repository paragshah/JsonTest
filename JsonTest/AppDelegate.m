//
//  AppDelegate.m
//  JsonTest
//
//  Created by Parag Shah on 7/11/14.
//  Copyright (c) 2014 Parag Shah. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  MainViewController *vc = [MainViewController new];
  self.window.rootViewController = vc;

  [self.window makeKeyAndVisible];
  return YES;
}

@end
