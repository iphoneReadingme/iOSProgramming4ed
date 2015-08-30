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

    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];

    // Setting the border style on the text field will allow us to see it easier
    textField.borderStyle = UITextBorderStyleRoundedRect; ///< 边框样式
    textField.placeholder = @"Hypnotize me";    ///< 占位符文本，只是改变了换行键的外观
    textField.returnKeyType = UIReturnKeyDone; ///< 修改键盘的换行键类型
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
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];

    textField.text = @"";
    [textField resignFirstResponder];

    return YES;
}

/*
 Delegate:
 Notice that it always sends itself as the first argument to the delegate method
 委托：注意，在委托方法中，通常应该将对象自身作为第一个参数。
 多个对象可能具有相同的委托，当委托收到消息时，需要需要根据该参数判断发送消息的对象。
 例如，如果某个视图控制器中包含多个UITextField对象，它们的委托都是该视图控制器，那么，视图控制器就需要根据textField参数获取相应的UITextField对象并执行不同的操作。
 
 Protocols
 For every object that can have a delegate, there is a corresponding protocol that declares the messages that the object can send its delegate. 
 The delegate implements methods from the protocol for events it is interested in. 
 When a class implements methods from a protocol, it is said to conform to the protocol.
 (If you are coming from Java or C#, you would use the word “interface” instead of “ protocol”.)
 凡是支持委托的对象，其背后都有一个相应的协议（如果读者之前接触过Java或C#, 这此言语中的“协议”称这为“接口”)，声明可以向该对象的委托发送的消息。委托对象根据这个协议为其“感兴趣的事件实现相应的方法。
 如果一个类实现了某个协议中规定的方法，就称这个类遵守（conform）该协议。
 
 This protocol, like all protocols, is declared with the directive @protocol followed by its name, UITextFieldDelegate. 
 The NSObject in angled brackets refers to the NSObject protocol and tells us that UITextFieldDelegate includes all of the methods in the NSObject protocol. 
 The methods specific to UITextFieldDelegate are declared next, and the protocol is closed with an @end directive.
 声明协议的语法是，使用@protocol指令开头，后跟协议的名称（例如UITextFieldDelegate)。尖括号里的NSObject 是指 NSObject 协议，其作用是声明UITextFieldDelegate包含NSObject协议的全部方法。
 接着声明新协议特有的方法，最后使用@end指令结束。
 Note that a protocol is not a class; it is simply a list of method declarations. 
 You cannot create instances of a protocol, it cannot have instance variables, and these methods are not implemented anywhere in the protocol. 
 Instead, implementation is left to each class that conforms to the protocol.
 协议不是类，只是一组声明。不能为协议创建对象，或者添加实例变量。协议自身不实现方法，需要由遵守相应协议的类来实现。
 */

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

@end
