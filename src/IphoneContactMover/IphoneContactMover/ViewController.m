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
    [self loadContainers];
    
}
- (IBAction)TapOnContanerChooserFrom:(id)sender {
    UIPickerView * containeirPicker = [[UIPickerView alloc] init];
    UIPickerHelper * pickerHelper = [[UIPickerHelper alloc] initWithArray:[self getContainersList] andDelegate:self];
    containeirPicker.delegate = pickerHelper;
    containeirPicker.dataSource = pickerHelper;
    containeirPicker.showsSelectionIndicator = YES;
    containeirPicker.frame = CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width , 250);
    //containeirPicker.backgroundColor = [UIColor redColor];
    [self.view addSubview:containeirPicker];
    NSLog(@"WOOO!");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadContainers{
    
    if(_containersArray == nil){
        
        // TODO: addPreloader
        __block ViewController * containerMaster = self;
        CNContactStore * store = [CNContactStore new];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted==YES){
                containerMaster.containersArray = [store containersMatchingPredicate:nil error:nil];
                NSLog(@" Containers: %lu", containerMaster.containersArray.count);
            } else {
                NSLog(@"2 bad, i do not have access");
            }
            
        }];
    }
}

- (NSArray *) getContainersList{
    
    NSMutableArray * tempArray = [NSMutableArray new];
    for (CNContainer * container in _containersArray) {
        [tempArray addObject:container.description];
    }
    NSLog(@" Containers: %lu", _containersArray.count);
    NSLog(@" Containers total: %lu", tempArray.count);
    return tempArray;
}

/*
    if(_containersArray == nil){

        CNContactStore * store = [CNContactStore new];
        
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted==YES){
                //NSArray * contactGroup = [store groupsMatchingPredicate:nil error:nil];
                NSArray * _containersArray = [store containersMatchingPredicate:nil error:nil];

//                NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey,CNGroupNameKey];
//            NSPredicate * groupPredicat = [CNContact predicateForContactsInGroupWithIdentifier :((CNGroup * )[contactGroup objectAtIndex:0]).identifier];
                
                CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
                [request setUnifyResults:NO];
                //            request.predicate = groupPredicat;
                
                NSError *error;
                BOOL success = [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop) {
                    if (error) {
                        NSLog(@"error fetching contacts %@", error);
                    } else {
                        // copy data to my custom Contact class.
                        //Contact *newContact = [[Contact alloc] init];
                        //newContact.firstName = contact.givenName;
                        //newContact.lastName = contact.familyName;
                        
                        // etc.
                        NSLog(@" Contacts: %@", contact.givenName);
                    }
                }];

            } else {
                NSLog(@"2 bad, i do not have access");
            }
    }
*/


- (void)pickerView:(UIPickerHelper *)pickerHelper pickerView:(UIPickerView *)UIPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"Select: %@ ", [[pickerHelper data] objectAtIndex:row]);
}

@end
