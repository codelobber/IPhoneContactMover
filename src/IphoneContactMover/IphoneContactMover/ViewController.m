//
//  ViewController.m
//  IphoneContactMover
//
//  Created by Все будет хорошо on 03/10/16.
//  Copyright © 2016 codelobber. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonnull,nonatomic,strong) UIPickerHelper * pickerHelper;
@property (nullable,nonatomic,strong) CNContainer * containerForCopy;
@property (nullable,nonatomic,strong) CNContainer * containerDestanetion;
@property (nullable,nonatomic,strong) NSMutableArray * contactsList;
@property (nullable,nonatomic,strong) CNContactStore * contactStore;
@property (nullable,nonatomic,strong) NSDictionary * numOfContactsinContainer;
@property (nonatomic) moverSteps currentStep;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContactStore];
    [self loadContainers];
    [self loadNumOfContacts];
}
- (IBAction)TapOnContanerChooserFrom:(id)sender {
    _currentStep = moverStepsSelectFrom;
    UIPickerView * containeirPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width , 250)];
    _pickerHelper = [[UIPickerHelper alloc] initWithArray:[self getContainersList] andDelegate:self];
    containeirPicker.delegate = _pickerHelper;
    containeirPicker.dataSource = _pickerHelper;
    [self.view addSubview:containeirPicker];
    
}
- (IBAction)tapOnContainerChooserTo:(id)sender {
    _currentStep = moverStepsSelectTo;
    UIPickerView * containeirPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width , 250)];
    _pickerHelper = [[UIPickerHelper alloc] initWithArray:[self getContainersList] andDelegate:self];
    containeirPicker.delegate = _pickerHelper;
    containeirPicker.dataSource = _pickerHelper;
    [self.view addSubview:containeirPicker];
}
- (IBAction)tapOnStartCopy:(id)sender {
    [self getPhonesList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadContainers{
    // TODO: addPreloader
    _containersArray = [_contactStore containersMatchingPredicate:nil error:nil];
}

- (void) loadNumOfContacts{
    NSArray *keys = @[CNContactIdentifierKey];
    NSPredicate * containerPredicate;
    CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    NSError *error;
    NSMutableDictionary * tempNumOfContactsInContainer = [NSMutableDictionary new];
    for (CNContainer * container in _containersArray) {
        containerPredicate = [CNContact predicateForContactsInContainerWithIdentifier:container.identifier];
        request.predicate = containerPredicate;
        __block int i=0;
        [_contactStore enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            if(error){
                NSLog(@"Error fetching contacts %@", error);
            } else {
                i++;
            }
        }];
        [tempNumOfContactsInContainer setObject:[NSNumber numberWithInteger:i] forKey:container.identifier];
    }
    _numOfContactsinContainer = [[NSDictionary alloc] initWithDictionary:tempNumOfContactsInContainer];
}

- (void) initContactStore {
    if(_contactStore == nil){
        _contactStore = [CNContactStore new];
        [_contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted){
                
            } else {
                NSLog(@"2 bad, i do not have access");
            }
        }];
    }
}

- (NSArray *) getContainersList{
    
    NSMutableArray * tempArray = [NSMutableArray new];
    int i = 1;
    for (CNContainer * container in _containersArray) {
        NSString * name = container.name == nil ? @"default" : container.name ;
        [tempArray addObject:[NSString stringWithFormat:@"%i. %@ (%@)", i++, name, [_numOfContactsinContainer objectForKey:container.identifier] ]];
    }
    NSLog(@" Containers: %lu", (unsigned long)_containersArray.count);
    return tempArray;
}

- (void) getPhonesList{
    //NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey,CNGroupNameKey];
    NSArray *keys = @[CNContactIdentifierKey,CNContactNamePrefixKey,CNContactGivenNameKey,CNContactMiddleNameKey,CNContactFamilyNameKey,CNContactPreviousFamilyNameKey,CNContactNameSuffixKey,CNContactNicknameKey,CNContactOrganizationNameKey,CNContactDepartmentNameKey,CNContactJobTitleKey,CNContactPhoneticGivenNameKey,CNContactPhoneticMiddleNameKey,CNContactPhoneticFamilyNameKey,CNContactPhoneticOrganizationNameKey,CNContactBirthdayKey,CNContactNonGregorianBirthdayKey,CNContactNoteKey,CNContactImageDataKey,CNContactThumbnailImageDataKey,CNContactImageDataAvailableKey,CNContactTypeKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey,CNContactPostalAddressesKey,CNContactDatesKey,CNContactUrlAddressesKey,CNContactRelationsKey,CNContactSocialProfilesKey,CNContactInstantMessageAddressesKey];
    NSPredicate * containersPreicate = [CNContact predicateForContactsInContainerWithIdentifier:_containerForCopy.identifier];
            
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    [request setUnifyResults:NO];
    [request setMutableObjects:YES];
    request.predicate = containersPreicate;

    NSError *error;

    __block NSMutableArray * ar = [NSMutableArray new];
    
    [_contactStore enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop) {
        if (error) {
            NSLog(@"Error fetching contacts %@", error);
        } else {
            CNMutableContact * mutableContact = contact.mutableCopy;
            [ar addObject:mutableContact];
            NSLog(@"Contacts: %@ id: %@", contact.givenName, contact.identifier);
        }
    }];
    NSError *errorSave;
    CNSaveRequest * saveRequest =  [CNSaveRequest new];
    CNSaveRequest * deleteRquest = [CNSaveRequest new];

    for (CNMutableContact * contact in ar) {
        [deleteRquest deleteContact:contact];
        [saveRequest addContact:contact toContainerWithIdentifier:_containerDestanetion.identifier ];
        
        [_contactStore executeSaveRequest:deleteRquest error:&errorSave];
        //[_contactStore executeSaveRequest:_saveRequest error:&errorSave];
        if(errorSave){
            NSLog(@"Error on delete Contacts: %@",errorSave);
        } else {
            [_contactStore executeSaveRequest:saveRequest error:&errorSave];
            if(errorSave){
                NSLog(@"Error on save Contacts: %@",errorSave);
            } else {
                NSLog(@"Save complete");
            }
        }
        NSLog(@"check: %@",errorSave);
    }
}




- (void)pickerView:(UIPickerHelper *)pickerHelper pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString * name;
    switch (_currentStep) {
        case moverStepsSelectFrom:
            _containerForCopy = [_containersArray objectAtIndex:row];
            name = _containerForCopy.name == nil ? @"default" : _containerForCopy.name;
            [_buttonFrom setTitle:[NSString stringWithFormat:@"Container: %@", name] forState:UIControlStateNormal];
            break;
        case moverStepsSelectTo:
            _containerDestanetion = [_containersArray objectAtIndex:row];
            name = _containerDestanetion.name == nil ? @"default" : _containerDestanetion.name;
            [_buttonTo setTitle:[NSString stringWithFormat:@"Container: %@", name] forState:UIControlStateNormal];
            break;
    }
    [pickerView removeFromSuperview];
    [pickerHelper destroy];
    pickerHelper = nil;
    pickerView = nil;
}

@end
