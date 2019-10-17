//
//  HSYAppDelegate.m
//  HSYDatabaseToolsKit
//
//  Created by 317398895@qq.com on 09/26/2019.
//  Copyright (c) 2019 317398895@qq.com. All rights reserved.
//

#import "HSYAppDelegate.h"
#import "HSYDatabaseTools.h"
#import <ReactiveObjC.h>

@implementation HSYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //创建表list1
    HSYDatabaseUnity *unity1 = [[HSYDatabaseUnity alloc] initWithName:@"name" andStateType:@"TEXT"];
    HSYDatabaseUnity *unity2 = [[HSYDatabaseUnity alloc] initWithName:@"age" andStateType:@"TEXT"];
    HSYDatabaseUnity *unity3 = [[HSYDatabaseUnity alloc] initWithName:@"nickname" andStateType:@"TEXT"];
    HSYDatabaseUnity *unity4 = [[HSYDatabaseUnity alloc] initWithName:@"id" andStateType:@"TEXT"];
    HSYDatabaseList *list = [[HSYDatabaseList alloc] initWithName:@"list1" databaseUnitys:@[unity1, unity2, unity3, unity4]];
    [[HSYDatabaseTools shareInstance] hsy_configDatabase:@"Database" listsCreated:@[list]];
    
    //在表list1中插入一条数据
//    HSYDatabaseUnity *unity5 = [[HSYDatabaseUnity alloc] initWithName:@"name" andStateType:@"TEXT" unityValue:@"赛斯4"];
//    HSYDatabaseUnity *unity6 = [[HSYDatabaseUnity alloc] initWithName:@"age" andStateType:@"TEXT" unityValue:@"25"];
//    HSYDatabaseUnity *unity7 = [[HSYDatabaseUnity alloc] initWithName:@"nickname" andStateType:@"TEXT" unityValue:@"弑君者4"];
//    HSYDatabaseUnity *unity8 = [[HSYDatabaseUnity alloc] initWithName:@"id" andStateType:@"TEXT" unityValue:@"53756561278"];
//    HSYDatabaseList *list1 = [[HSYDatabaseList alloc] initWithName:@"list1" updateUnitys:@[unity5, unity6, unity7, unity8]];
//    [[[HSYDatabaseTools shareInstance].database hsy_insertDatas:@[list1]] subscribeNext:^(NSNumber * _Nullable x) {
//        NSLog(@"插入结果: %@", x);
//        [self.class query:unity7];
//    }];

    [self.class delete];
    return YES;
}

+ (void)query:(HSYDatabaseUnity *)unity7
{
    //在表list1中搜索所有数据
    HSYDatabaseList *list2 = [[HSYDatabaseList alloc] initWithName:@"list1" unityNames:@[@"name", @"age", @"nickname", @"id"]];
    [[[HSYDatabaseTools shareInstance].database hsy_queryAllDatas:list2] subscribeNext:^(NSMutableArray<NSDictionary *> * _Nullable x) {
        NSLog(@"查询整张表的结果: %@", x);
        //在表list1中搜索name=hate的数据
        HSYDatabaseUnity *unity9 = unity7;
        HSYDatabaseList *list3 = [[HSYDatabaseList alloc] initWithName:@"list1" unityNames:@[@"name", @"age", @"nickname", @"id"] queryUnity:unity9];
        [[[HSYDatabaseTools shareInstance].database hsy_queryDatas:list3] subscribeNext:^(NSMutableArray<NSDictionary *> * _Nullable x) {
            NSLog(@"查询结果: %@", x);
            [self.class modify:unity9];
        }];
    }];
}

+ (void)modify:(HSYDatabaseUnity *)unity7
{
    HSYDatabaseUnity *unity10 = [[HSYDatabaseUnity alloc] initWithName:@"name" andStateType:@"TEXT" unityValue:@"大锤锤死你"];
    HSYDatabaseList *list4 = [[HSYDatabaseList alloc] initWithName:@"list1" modifyUnitys:@[@{unity7 : unity10}]];
    [[[HSYDatabaseTools shareInstance].database hsy_modifyData:list4] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"修改结果: %@", x);
        [self.class delete];
    }];
}

+ (void)delete
{
    HSYDatabaseUnity *unity11 = [[HSYDatabaseUnity alloc] initWithName:@"name" andStateType:@"TEXT" unityValue:@"大锤锤死你"];
    HSYDatabaseList *list5 = [[HSYDatabaseList alloc] initWithName:@"list1" updateUnitys:@[unity11]];
    [[[HSYDatabaseTools shareInstance].database hsy_deleteData:list5] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"删除结果: %@", x);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
