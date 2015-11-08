//
//  UIView+ViewController.m
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
-(UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
    
}



@end
