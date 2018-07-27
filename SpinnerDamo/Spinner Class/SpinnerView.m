//
//  SpinnerView.m
//  SpinnerDamo
//
//  Created by Maulik on 17/07/18.
//  Copyright © 2018 ligro. All rights reserved.
//

#import "SpinnerView.h"

static SpinnerView *SV = nil;

@implementation SpinnerView
{
    int NoOfItem;
    float anglePerItem;
    UIImageView *wheelImg;
    int WheelArea;
}

+(SpinnerView*)SharedInstant
{
    if(SV == nil)
    {
        SV = [[[NSBundle mainBundle] loadNibNamed:@"SpinnerView" owner:self options:nil] objectAtIndex:0];
    }
    return SV;
}
+(SpinnerView*)CurrentInstant
{
    return SV;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // You can change size of Spin from here...
    WheelArea = 700;
    
    // Spinner Image
    wheelImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WheelArea, WheelArea)];
    wheelImg.center = self.center;
    wheelImg.image = [UIImage imageNamed:@"wheel.png"];
    [self addSubview:wheelImg];
    
    // Pointer Image
    UIImageView *pointerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WheelArea/10, WheelArea/10)];
    pointerImg.center = CGPointMake(wheelImg.center.x, wheelImg.frame.origin.y);
    pointerImg.image = [UIImage imageNamed:@"spin_pointer"];
    [self addSubview:pointerImg];
    
    _spinBtn.layer.cornerRadius = _spinBtn.frame.size.width/2;
    
    [self setSpinData];
}
-(void)MakeInstansNil
{
    SV = nil;
    [self removeFromSuperview];
}
-(void)setSpinData
{
    NoOfItem = 24;
    anglePerItem = M_PI/NoOfItem;
    
    // Remove Previous Data
    for(UIView *view in wheelImg.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Setup Spinner Data
    for(int i = 0; i < NoOfItem; i++)
    {
        // View
        UIImageView *itemView = [[UIImageView alloc] init];
        itemView.frame = CGRectMake(0, 0, WheelArea/2, WheelArea/NoOfItem*3);
        itemView.center = CGPointMake(wheelImg.frame.size.width/2, wheelImg.frame.size.height/2);
        itemView.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        
        // Index Lbl
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, itemView.frame.size.width/2, itemView.frame.size.height/4)];
        lbl.text = [NSString stringWithFormat:@"%d Chips", i];
        lbl.textAlignment = NSTextAlignmentCenter;
        [itemView addSubview:lbl];
        
        float angle = (anglePerItem*i*2);
        itemView.transform = CGAffineTransformMakeRotation(angle);
        [wheelImg addSubview:itemView];
    }
    wheelImg.transform = CGAffineTransformMakeRotation(M_PI_2);
    _spinBtn.center = wheelImg.center;
    [self bringSubviewToFront:_spinBtn];
}

- (IBAction)onSpinBtn:(id)sender {
    [self setSpinData];
    [self SpinAnim];
}

-(void)SpinAnim
{
    int StopIndex = arc4random()%NoOfItem;
    NSLog(@"Stop Index ===> %d", StopIndex);
    
    double angleRotate =  (M_PI * 5) + (-anglePerItem*StopIndex*2);
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spinAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    spinAnimation.toValue = [NSNumber numberWithFloat:M_PI+angleRotate];
    spinAnimation.duration = 7.0f;
    spinAnimation.cumulative = YES;
    spinAnimation.additive = YES;
    wheelImg.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    spinAnimation.removedOnCompletion = NO;
    spinAnimation.timingFunction = [CAMediaTimingFunction
                                    functionWithName:kCAMediaTimingFunctionEaseOut];
    spinAnimation.fillMode = kCAFillModeForwards;
    [wheelImg.layer addAnimation:spinAnimation forKey:@"spinAnimation"];

}

@end
