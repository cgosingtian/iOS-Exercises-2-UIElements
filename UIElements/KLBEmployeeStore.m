//
//  KLBEmployeeStore.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBEmployeeStore.h"
#import "KLBConstants.h"

@interface KLBEmployeeStore ()

@property (nonatomic,retain) NSMutableDictionary *employeeSections;

@end

@implementation KLBEmployeeStore

+ (instancetype) sharedStore {
    static KLBEmployeeStore *sharedStore;
    if (!sharedStore) {
        sharedStore = [[KLBEmployeeStore alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype) init {
    [NSException raise:@"Singleton" format:@"Use +[KLBEmployeeStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _employeeSections = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSDictionary *)allItems {
    return _employeeSections;
}

- (void)setAllItems:(NSMutableDictionary *)dictionary {
    if (_employeeSections.count != 0) {
        [_employeeSections removeAllObjects];
    }
    _employeeSections = [dictionary copy];
}

- (void)addSection:(id)object forKey:(NSString *)key {
    [_employeeSections setObject:object forKey:key];
}

- (void)removeSectionWithKey:(NSString *)key {
    [_employeeSections removeObjectForKey:key];
}

- (NSMutableDictionary *)employeeWithName:(NSString *)name section:(NSString *)section {
    for (NSString *key in _employeeSections) {
        if ([section isEqualToString:key]) {
            for (NSMutableDictionary *employee in [_employeeSections objectForKey:key]) {
                if ([name isEqualToString:[employee objectForKey:KLB_NAME_KEY]]) {
                    return employee;
                }
            }
        }
    }
    return nil;
}

- (NSMutableDictionary *)employeeWithSection:(NSString *)section index:(NSInteger)index {
    for (NSString *key in _employeeSections) {
        if ([section isEqualToString:key]) {
            return [[_employeeSections objectForKey:key] objectAtIndex:index];
        }
    }
    return nil;
}

- (void)setEmployeeWithDictionary:(NSDictionary *)employee section:(NSString *)section index:(NSInteger)index {
    @try {
    [[_employeeSections objectForKey:section] setObject:employee atIndex:index];
    }
    @catch(NSException *e) { NSLog(@"%@",e); }
}
@end
