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
#include <Contacts/CNSaveRequest.h>
#include <UIKit/UIViewPropertyAnimator.h>



#include "UIPickerHelper.h"

@interface ViewController : UIViewController <UIPickerHelperDelegate>

@property (nonnull,nonatomic,strong) NSArray * containersArray;
@property (nullable,weak, nonatomic) IBOutlet UIButton *buttonFrom;
@property (nullable,weak, nonatomic) IBOutlet UIButton *buttonTo;

@property (nullable, weak, nonatomic) IBOutlet UIStackView *firstStepControls;
@property (nullable, weak, nonatomic) IBOutlet UIStackView *secondStepControls;
@property (nullable, weak, nonatomic) IBOutlet UIStackView *thirdStepControls;

@property (nullable, weak, nonatomic) IBOutlet NSLayoutConstraint *firstStepTop;

typedef NS_ENUM(NSInteger,moverSteps){
    moverStepsSelectFrom = 0,
    moverStepsSelectTo
};

typedef NS_ENUM(NSInteger,animationSteps){
    moverStepsNothig = 0,
    moverStepsNotSelectFrom,
    moverStepsNotSelectTo,
    moverStepsAllSelected
};

@end

