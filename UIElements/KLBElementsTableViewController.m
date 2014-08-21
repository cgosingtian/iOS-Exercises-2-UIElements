//
//  KLBElementsTableViewController.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBElementsTableViewController.h"
#import "KLBJSONController.h"
#import "KLBEmployeeStore.h"
#import "KLBEmployeeViewController.h"
#import "KLBConstants.h"

@interface KLBElementsTableViewController ()

@property (nonatomic,retain) NSMutableArray *viewList;

@end

@implementation KLBElementsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_viewList) {
        _viewList = [[NSMutableArray alloc] init];
    }
    
    [self setTitle:@"Employee Records"];
    
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //load JSON
    KLBJSONController *jsonController = [[KLBJSONController alloc] init];
    NSDictionary *loadedDictionary = [jsonController loadJSONfromFile:@"tc"];
    [[KLBEmployeeStore sharedStore] setAllItems:[loadedDictionary mutableCopy]];
    
    //just use loadedDictionary for convenience
    for (NSString *key in loadedDictionary) {
        for (NSDictionary *employee in [loadedDictionary objectForKey:key]) {
            //Create KLBEmployeeViewController for each employee
            NSString *empDesc = [employee objectForKey:KLB_DESCRIPTION_KEY];
            NSString *empImageString = [employee objectForKey:KLB_IMAGE_KEY];
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:empImageString options:0];
            UIImage *empImage = [[UIImage alloc] initWithData:imageData];
            NSNumber *isTraineeNum = [employee objectForKey:KLB_ISTRAINEE_KEY];
            bool isTrainee = [isTraineeNum boolValue];
            NSString *empName = [employee objectForKey:KLB_NAME_KEY];
            float empRating = [[employee objectForKey:KLB_RATING_KEY] floatValue];
            
            KLBEmployeeViewController *evc = [[KLBEmployeeViewController alloc] initWithNibName:nil bundle:nil employeeImage:empImage employeeName:empName employeeTrainee:isTrainee employeeRating:empRating employeeDescription:empDesc];
            [evc setTitle:empName];
            NSLog(@"EVC TITLE: %@", [evc title]);
            if (!evc) NSLog(@"EVC NIL :(");
            [_viewList addObject:evc];
            [evc release];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _viewList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
 
    KLBElementsTableViewController *evc = [_viewList objectAtIndex:indexPath.row];
    cell.textLabel.text = [evc title];
//    [evc release];
 
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate
 
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLBEmployeeViewController *evc = [_viewList objectAtIndex:indexPath.row];
 
    [self.navigationController pushViewController:evc animated:YES];
}


@end
