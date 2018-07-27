//
//  SpinnerView.h
//  SpinnerDamo
//
//  Created by Maulik on 17/07/18.
//  Copyright © 2018 ligro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView

+(SpinnerView*)SharedInstant;
+(SpinnerView*)CurrentInstant;
-(void)MakeInstansNil;
-(void)setSpinData;

@property (weak, nonatomic) IBOutlet UIButton *spinBtn;
- (IBAction)onSpinBtn:(id)sender;
@end
