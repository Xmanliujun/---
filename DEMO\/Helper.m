#import "Helper.h"

@implementation Helper

+ (void)showContentViewAnimation:(UIView *)view withAlpha:(CGFloat)alpha
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    view.alpha = alpha;
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

@end
