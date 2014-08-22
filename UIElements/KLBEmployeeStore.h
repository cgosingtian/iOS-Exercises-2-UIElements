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
- (void)addSection:(id)object forKey:(NSString *)key;
- (void)removeSectionWithKey:(NSString *)key;
- (NSString *)keyFromSectionIndex:(NSInteger)index;
- (NSMutableDictionary *)employeeWithName:(NSString *)name section:(NSString *)section;
- (NSMutableDictionary *)employeeWithSection:(NSString *)section index:(NSInteger)index;
- (void)setEmployeeWithDictionary:(NSMutableDictionary *)employee section:(NSString *)section index:(NSInteger)index;

@end
