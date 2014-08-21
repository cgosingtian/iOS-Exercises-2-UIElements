//
//  KLBEmployeeStore.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBEmployeeStore.h"

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

- (void)addItem:(id)object forKey:(NSString *)key {
    [_employeeSections setObject:object forKey:key];
}

- (void)removeItemWithKey:(NSString *)key {
    [_employeeSections removeObjectForKey:key];
}

@end
