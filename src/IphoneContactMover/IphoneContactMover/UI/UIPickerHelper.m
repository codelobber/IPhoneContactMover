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
    NSLog(@"%lu",(unsigned long)_data.count);
    return _data.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSLog(@"Total %lu",(unsigned long)_data.count);
    return [_data objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"pick %i",row);
    [_delegate pickerView:self pickerView:pickerView didSelectRow:row inComponent:component];
}

- (void) destroy {
    _data = nil;
    _delegate = nil;
}


@end
