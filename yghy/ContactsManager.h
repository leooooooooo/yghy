//
//  ContactsManager.h
//  wlkg
//
//  Created by zhangchao on 15/7/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define TableName @"Person"

@interface ContactsManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//插入数据
- (void)insertCoreData:(NSMutableArray*)dataArray;
//查询
- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)deleteData;
//更新
//- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

@end
