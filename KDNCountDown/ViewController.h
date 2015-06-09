//
//  ViewController.h
//  KDNCountDown
//
//  Created by kaden Chiang on 2015/6/7.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UILabel *countDownDisplaylabel;
    IBOutlet UIButton *changeCountDownButton;
    IBOutlet UIButton *setTimeButton;
    IBOutlet UIPickerView *pickerView;
}

@end

