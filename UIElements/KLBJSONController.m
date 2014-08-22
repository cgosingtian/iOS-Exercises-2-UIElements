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

+ (NSDictionary *) loadJSONfromFile:(NSString *)file {
    NSString *strippedExtension = [file stringByDeletingPathExtension];
    NSString *filename = [[NSBundle mainBundle] pathForResource:strippedExtension ofType:@"json"];
    NSURL *fileURL = [NSURL fileURLWithPath:filename];
    
    NSData *JSONData = [[NSData alloc] initWithContentsOfURL:fileURL];
    
    NSString *existingFilename = [NSString stringWithFormat:@"%@.%@",strippedExtension,@"json"];
    NSString *existingFilePath = [self filePathInDocuments:existingFilename];
    NSURL *existingFileURL = [NSURL fileURLWithPath:existingFilePath];
    
    NSData *existingJSONData = [[NSData alloc] initWithContentsOfURL:existingFileURL];
    
    if (existingJSONData) {
        JSONData = existingJSONData;
    }
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    [JSONData release];
    return dictionary;
}

+ (void) saveJSONtoFile:(NSString *)file contents:(NSDictionary *)dictionary {
    NSString *strippedExtension = [file stringByDeletingPathExtension];
    NSString *existingFilename = [NSString stringWithFormat:@"%@.%@",strippedExtension,@"json"];
    NSString *existingFilePath = [self filePathInDocuments:existingFilename];
    NSURL *existingFileURL = [NSURL fileURLWithPath:existingFilePath];
    
//    NSLog(@"Dictionary contents: %@",dictionary);
//    
//    for (NSString *key in dictionary) {
//        for (NSDictionary *employee in [dictionary objectForKey:key]) {
//            for (NSString *key in [employee allKeys]) {
//                NSLog(@"_____%@ - %@",key,[employee[key] class]);
//            }
//        }
//    }
    
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    [JSONData writeToURL:existingFileURL atomically:YES];
}

+ (NSString *)filePathInDocuments:(NSString *)filename
{
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:filename];
}

@end
