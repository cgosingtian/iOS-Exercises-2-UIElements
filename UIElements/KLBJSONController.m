//
//  KLBJSONController.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBJSONController.h"
#import "KLBConstants.h"

@implementation KLBJSONController

- (NSDictionary *) loadJSONfromFile:(NSString *)file {
    NSLog(@"%@",file);
    NSString *strippedExtension = [file stringByDeletingPathExtension];
    NSLog(@"%@",strippedExtension);
    NSString *filename = [[NSBundle mainBundle] pathForResource:strippedExtension ofType:@"json"];
    NSLog(@"%@",filename);
    NSURL *fileURL = [NSURL fileURLWithPath:filename];
    NSLog(@"%@",fileURL);
    
    NSData *JSONData = [[NSData alloc] initWithContentsOfURL:fileURL];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    [JSONData release];
    return dictionary;
}

@end
