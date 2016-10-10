//
//  ViewController.h
//  IphoneContactMover
//
//  Created by Все будет хорошо on 03/10/16.
//  Copyright © 2016 codelobber. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <Contacts/CNContactStore.h>
#include <Contacts/CNGroup.h>
#include <Contacts/CNContainer.h>
#include <Contacts/CNContactFetchRequest.h>
#include <Contacts/CNContact+Predicates.h>
#include <UIKit/UIPickerView.h>
#include "UIPickerHelper.h"

@interface ViewController : UIViewController <UIPickerHelperDelegate>

@property (nullable,nonatomic,weak) NSArray * containersArray;

@end

