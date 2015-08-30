//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by John Gallagher on 1/6/14.
//  Copyright (c) 2014 John Gallagher. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, retain) UILabel *txtLabel;
@end

@implementation BNRHypnosisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";

        // Create a UIImage from a file
        // This will use Hypno@2x on retina display devices
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];

        // Put that image on the tab bar item
        self.tabBarItem.image = image;
    }

    return self;
}

- (void)loadView
{
    // Create a view
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];

    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40, -20, 240, 30)];
    self.textField = textField;

    // Setting the border style on the text field will allow us to see it easier
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    [backgroundView addSubview:textField];

    textField.delegate = self;

    // Set it as *the* view of this view controller
    self.view = backgroundView;
	
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];

	NSLog(@"BNRHypnosisViewController loaded its view");
	
	CGRect rect = CGRectMake(200, 0, 100, 30);
	UILabel* pLabel = [[UILabel alloc] initWithFrame:rect];
	pLabel.text = @"关键动画帧demo2015-08-15";
	_txtLabel = pLabel;
	
	[self.view addSubview:pLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [UIView animateWithDuration:2.0
//                          delay:0.0
//         usingSpringWithDamping:0.25
//          initialSpringVelocity:0.0
//                        options:0
//                     animations:^{
//                         CGRect frame = CGRectMake(40, 70, 240, 30);
//                         self.textField.frame = frame;
//                     }
//                     completion:NULL];
	
	[self executeAnimation];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];

    textField.text = @"";
    [textField resignFirstResponder];

    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];

        // Configure the label's colors and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;

        // This method resizes the label, which will be relative
        // to the text that it is displaying
        [messageLabel sizeToFit];

        // Get a random x value that fits within the hypnosis view's width
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random_uniform(width);

        // Get a random y value that fits within the hypnosis view's height
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random_uniform(height);

        // Update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;

        // Add the label to the hierarchy
        [self.view addSubview:messageLabel];

        // Set the label's initial alpha
        messageLabel.alpha = 0.0;

        // Animate the alpha to 1.0
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             messageLabel.alpha = 1.0;
                         }
                         completion:NULL];

        [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
                messageLabel.center = self.view.center;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                int x = arc4random() % width;
                int y = arc4random() % height;
                messageLabel.center = CGPointMake(x, y);
            }];
        } completion:^(BOOL finished) {
            NSLog(@"Animation finished");
        }];

        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];

        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
    }
}

- (void)executeAnimation
{
	// Animate the alpha to 1.0
	CGRect rect = [_textField frame];
	rect.origin.y = 0;
	[_textField setFrame:rect];
	
	CGFloat t1 = 0.25f;
	CGFloat t2 = 0.25f;
	CGFloat t3 = 0.25f;
	CGFloat t4 = 0.25f;
	CGFloat t = 3.0f;
	
	[UIView animateKeyframesWithDuration:t delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
		
		[UIView addKeyframeWithRelativeStartTime:0 relativeDuration:t1 animations:^{
			
			CGRect rect = [_textField frame];
			rect.origin.y = 300;
			[_textField setFrame:rect];
			
			rect.origin.x = 200;
			rect.origin.y = 400;
			[_txtLabel setFrame:rect];
		}];
		
		[UIView addKeyframeWithRelativeStartTime:t1 relativeDuration:t2 animations:^{
			_textField.backgroundColor = [UIColor blueColor];
			_txtLabel.textColor = [UIColor redColor];
			_txtLabel.backgroundColor = [UIColor grayColor];
		}];
		[UIView addKeyframeWithRelativeStartTime:t1 + t2 relativeDuration:t3 animations:^{
			int x = arc4random() % 200;
			int y = arc4random() % 200;
			_textField.center = CGPointMake(x, y);
			
			CGRect rect = [_txtLabel frame];
			rect.origin.x = 200;
			rect.origin.y = 0;
			[_txtLabel setFrame:rect];
		}];
		
		[UIView addKeyframeWithRelativeStartTime:t1 + t2 + t3 relativeDuration:t4 animations:^{
			
			_textField.backgroundColor = [UIColor clearColor];
			_txtLabel.backgroundColor = [UIColor blueColor];
		}];
		
	} completion:^(BOOL finished) {
		NSLog(@"Animation finished");
	}];
}

@end
