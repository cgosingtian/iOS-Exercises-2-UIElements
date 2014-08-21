//
//  KLBEmployeeStore.h
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLBEmployeeStore : NSObject

+(instancetype)sharedStore;
- (NSDictionary *)allItems;
- (void)setAllItems:(NSMutableDictionary *)dictionary;
- (void)addItem:(id)object forKey:(NSString *)key;
- (void)removeItemWithKey:(NSString *)key;
- (NSDictionary *)employeeWithName:(NSString *)name section:(NSString *)section;

@end
