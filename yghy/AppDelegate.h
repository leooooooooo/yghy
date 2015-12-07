//
//  AppDelegate.h
//  yghy
//
//  Created by zhangchao on 15/4/18.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(retain,nonatomic) NSString *UserName;
@property(retain,nonatomic) NSString *Update;
@property(retain,nonatomic) NSString *Version;
@property(retain,nonatomic) NSString *Url;
@property(retain,nonatomic) NSArray *FunctionList;
@property(retain,nonatomic) NSString *Password;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

