//
//  UIPickerHelper.m
//  IphoneContactMover
//
//  Created by Все будет хорошо on 10/10/16.
//  Copyright © 2016 codelobber. All rights reserved.
//

#import "UIPickerHelper.h"

@implementation UIPickerHelper

- (id) initWithArray:(NSArray *) dataArray{
    _data = dataArray;
    return [self init];
}

- (id) initWithArray:(NSArray *) dataArray andDelegate:(NSObject<UIPickerHelperDelegate> *) delegate{
    _delegate = delegate;
    return [self initWithArray:dataArray];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _data.count+1;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(row == 0) return @"            ";
    return [_data objectAtIndex:row-1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"pick %i",row);
    if (row == 0) return;
    [_delegate pickerView:self pickerView:pickerView didSelectRow:row-1 inComponent:component];
}

- (void) destroy {
    _data = nil;
    _delegate = nil;
}


@end
