//
//  UIPickerHelper.h
//  IphoneContactMover
//
//  Created by Все будет хорошо on 10/10/16.
//  Copyright © 2016 codelobber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIPickerView.h>

@protocol UIPickerHelperDelegate;

@interface UIPickerHelper : NSObject <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonnull,nonatomic,strong) NSArray * data ;
@property (nonnull,nonatomic,strong) NSObject<UIPickerHelperDelegate> * delegate;

- (id _Nonnull) initWithArray:(NSArray * _Nonnull) dataArray;
- (id _Nonnull) initWithArray:(NSArray * _Nonnull) dataArray andDelegate:(NSObject<UIPickerHelperDelegate> * _Nonnull) delegate;
- (void) destroy;

@end

@protocol UIPickerHelperDelegate<NSObject>
@optional
- (void)pickerView:(UIPickerHelper * _Nonnull )pickerHelper pickerView:(UIPickerView * _Nonnull )UIPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
