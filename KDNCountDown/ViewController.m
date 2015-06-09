//
//  ViewController.m
//  KDNCountDown
//
//  Created by kaden Chiang on 2015/6/7.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@property NSInteger countDownSecond;
@property NSInteger baseUnixTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countDownSecond = 0;
    [pickerView setHidden:YES];
    [setTimeButton setHidden: YES];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger num = 0;
    switch (component) {
        case 0:
            num = 24;
            break;
        case 1:
            num = 61;
            break;
        case 2:
            num = 61;
            break;
        default:
            break;
    }
    return num;
}

-(void)pickerView:(UIPickerView *)aPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0) {
        [pickerView selectRow:1 inComponent:component animated:YES];
    }
    if (component != 2) {
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
}
- (IBAction)changeCountDownAction:(UIButton *)button {
    [pickerView setHidden:NO];
    [pickerView selectRow:1 inComponent:0 animated:NO];
    [pickerView selectRow:1 inComponent:1 animated:NO];
    [pickerView selectRow:2 inComponent:2 animated:NO];
    [setTimeButton setHidden: NO];
    [changeCountDownButton setHidden: YES];
}

- (IBAction)setTimeButtonAction:(UIButton *)button {
    self.countDownSecond = ([pickerView selectedRowInComponent:0] - 1) * 3600 +
    ([pickerView selectedRowInComponent:1] - 1) * 60 +
    ([pickerView selectedRowInComponent:2] - 1);
    self.baseUnixTime = [[NSDate date] timeIntervalSince1970];
    [self displayStringAndReduceTime];
    [pickerView setHidden:YES];
    [setTimeButton setHidden: YES];
    [changeCountDownButton setHidden:NO];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    if (row == 0) {
        switch (component) {
            case 0:
                title = @"Hour";
                break;
            case 1:
                title = @"Minute";
                break;
            case 2:
                title = @"Second";
                break;
            default:
                break;
        }
    } else {
        title = [NSString stringWithFormat:@"%ld", row-1];
    }
    return title;
}

- (void)displayStringAndReduceTime
{
    NSString *display = [[NSString alloc] initWithFormat:@"%02ld:%02ld:%02ld", self.countDownSecond/3600, self.countDownSecond / 60 % 60, self.countDownSecond % 60];
    self.countDownSecond--;
    countDownDisplaylabel.text = display;
    if (self.countDownSecond >= 0) {
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(displayStringAndReduceTime) userInfo:nil repeats:NO];
    } else {
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[[NSURL alloc] initWithString: @"/System/Library/Audio/UISounds/alarm.caf"], &soundID);
        AudioServicesPlaySystemSound(soundID);
        [changeCountDownButton setHidden:NO];
    }
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
