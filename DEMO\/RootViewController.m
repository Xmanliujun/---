#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Helper.h"

#define COUNT 6

@interface RootViewController ()

@end

@implementation RootViewController

- (id)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"简单实现按钮点击功能";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    label.tag = 100;
    label.text = @"0";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label release];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [leftBtn setFrame:CGRectMake(50, 80, 50, 30)];
    [leftBtn setTitle:@"减" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightBtn setFrame:CGRectMake(130, 80, 50, 30)];
    [rightBtn setTitle:@"增" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [resetBtn setFrame:CGRectMake(210, 80, 50, 30)];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [self.view addSubview:resetBtn];
    
    UIButton *randomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [randomBtn setFrame:CGRectMake(130, 150, 50, 30)];
    [randomBtn setTitle:@"随机数" forState:UIControlStateNormal];
    [randomBtn addTarget:self action:@selector(randomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    randomBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [self.view addSubview:randomBtn];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(20, 200, 280, 255)];
    contentView.backgroundColor = [UIColor blackColor];
    contentView.layer.shadowOffset = CGSizeMake(4, 4);
    contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    contentView.layer.shadowOpacity = 0.5;
    contentView.tag = 1000;
    contentView.alpha = 0;
    [self.view addSubview:contentView];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, contentView.bounds.size.width, 44)];
    navBar.tintColor = [UIColor blackColor];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"友達に教えよう"];
    UIBarButtonItem *rBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(rBtnAction)];
    rBtn.tintColor = [UIColor grayColor];
    item.rightBarButtonItem = rBtn;
    [rBtn release];
    [navBar pushNavigationItem:item animated:YES];
    [item release];
    [contentView addSubview:navBar];
    [navBar release];
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 280, 255)];
    imageView.tag = 20000;
    [self.view addSubview:imageView];
    [imageView release];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, contentView.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.3f;
    [contentView addSubview:lineView];
    [lineView release];
    
    [contentView release];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self rBtnAction];
}

- (void)rightBarButtonAction
{
    UIView *contentView = (UIView *)[self.view viewWithTag:1000];
    [Helper showContentViewAnimation:contentView withAlpha:1];
}

- (void)rBtnAction
{
    UIView *contentView = (UIView *)[self.view viewWithTag:1000];
    [Helper showContentViewAnimation:contentView withAlpha:0];
}

- (void)randomButtonAction:(UIButton *)btn
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
    [btn removeTarget:self action:@selector(randomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(stopRandomNumber:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)stopRandomNumber:(UIButton *)btn
{
    [timer invalidate];
    [btn removeTarget:self action:@selector(stopRandomNumber:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(randomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateMeters
{
    UILabel *label = (UILabel *)[self.view viewWithTag:100];
    int num = arc4random() % COUNT;
    label.text = [NSString stringWithFormat:@"%d", num];
    
    UIImageView * imageViewa = (UIImageView *)[self.view viewWithTag:20000];
    imageViewa.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%d.jpg",num]];
    
    
    
}

- (void)leftButtonAction:(UIButton *)btn
{
    UILabel *label = (UILabel *)[self.view viewWithTag:100];
    int count = [[NSString stringWithFormat:@"%@", label.text] intValue];
    label.text = [NSString stringWithFormat:@"%d", count - 1];
}

- (void)rightButtonAction:(UIButton *)btn
{
    UILabel *label = (UILabel *)[self.view viewWithTag:100];
    int count = [[NSString stringWithFormat:@"%@", label.text] intValue];
    label.text = [NSString stringWithFormat:@"%d", count + 1];
}

- (void)resetButtonAction:(UIButton *)btn
{
    UILabel *label = (UILabel *)[self.view viewWithTag:100];
    label.text = @"0";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
