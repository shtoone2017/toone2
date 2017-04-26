//
//  TheProjectCell.m
//  The Projects
//
//  Created by Ahmed Karim on 1/11/13.
//  Copyright (c) 2013 Ahmed Karim. All rights reserved.
//

#import "LqTheProjectCell.h"

@interface LqTheProjectCell()

@property (nonatomic) BOOL isExpanded;

@end
@implementation LqTheProjectCell

#pragma mark - Draw controls messages

- (void)drawRect:(CGRect)rect
{
    CGRect cellFrame = self.cellLabel.frame;
    CGRect buttonFrame = self.cellButton.frame;
    int indentation = self.LqtreeNode.depth * 25;
    cellFrame.origin.x = buttonFrame.size.width + indentation + 5;
    buttonFrame.origin.x = 2 + indentation;
    self.cellLabel.frame = cellFrame;
    self.cellButton.frame = buttonFrame;
}

- (void)setTheButtonBackgroundImage:(UIImage *)backgroundImage
{
    [self.cellButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

@end
