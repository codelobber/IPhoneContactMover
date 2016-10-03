//
//  ViewController.m
//  IphoneContactMover
//
//  Created by Все будет хорошо on 03/10/16.
//  Copyright © 2016 codelobber. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    //if (status == CNAuthorizationStatusNotDetermined)
    
    CNContactStore * store = [CNContactStore new];
    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(granted==YES){
            NSArray * contactGroup = [store groupsMatchingPredicate:nil error:nil];
            NSLog(@" Our groups: %@",[contactGroup componentsJoinedByString:@" "]);
        } else {
            NSLog(@"2 bad, i do not have access");
        }
    }];
    
    //NSArray * groups = [[[CNContactStore alloc] init] groupsMatchingPredicate:nil error:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
