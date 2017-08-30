//
//  RSObjcSyntaxViewController.m
//  RSDemo
//
//  Created by yaoqi on 2017/8/27.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSObjcSyntaxViewController.h"

@implementation RSBlockSyntaxObject

- (void)excuteStrongBlock {
    if (self.strongBlock) {
        NSLog(@"excute strong block %@", self.strongBlock);
        self.strongBlock();
    }
}

- (void)excuteCopyBlock {
    if (self.copyBlock) {
        NSLog(@"excute copy block %@", self.copyBlock);
        self.copyBlock();
    }
}

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
}

@end

@implementation RSPropertySyntaxObject

@synthesize _obj1 = __obj1;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _copyedMutableArray = [@[@"haha"] mutableCopy];
        NSLog(@"[[RSPropertySyntaxObject alloc] init] - copyedMutableArray %@ : %@", [_copyedMutableArray class], _copyedMutableArray);
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    RSPropertySyntaxObject *obj = [[[self class] allocWithZone:zone] init];
    obj.intValue = self.intValue;
    obj.strongText = self.strongText;
    obj.copyedText = self.copyedText;
    obj.copyedMutableText = self.copyedMutableText;
    obj.strongArray = self.strongArray;
    obj.copyedArray = self.copyedArray;
    obj.copyedMutableArray = self.copyedMutableArray;
    return obj;
}

- (void)print {
    NSLog(@"strongArray %@ : %@", [self.strongArray class], self.strongArray);
    NSLog(@"copyedArray %@ : %@", [self.copyedArray class], self.copyedArray);
    NSLog(@"copyedMutableArray %@ : %@", [self.copyedMutableArray class], self.copyedMutableArray);
    NSLog(@"strongText %@ : %@", [self.strongText class], self.strongText);
    NSLog(@"copyedText %@ : %@", [self.copyedText class], self.copyedText);
    NSLog(@"copyedMutableText %@ : %@", [self.copyedMutableText class], self.copyedMutableText);
}


- (void)testArrayCrash {
    // copyedMutableArray 的属性是 copy，copy 就是复制一个不可变 NSArray 对象，对 NSArray 对象进行增删改操作，会直接 crash
    [self.copyedMutableArray insertObject:@"insert object" atIndex:0];
    NSLog(@"copyedMutableArray %@ : %@", [self.copyedMutableArray class], self.copyedMutableArray);
}

@end

@interface RSObjcSyntaxViewController ()

@property (nonatomic, strong) RSBlockSyntaxObject *blockSyntaxObject;

@end

@implementation RSObjcSyntaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.blockSyntaxObject = [[RSBlockSyntaxObject alloc] init];
    self.blockSyntaxObject.copyBlock = ^{
        self.view.backgroundColor = [UIColor redColor];
        // 循环引用测试，置为 nil 后 blockSyntaxObject 才会被释放
        self.blockSyntaxObject = nil;
    };
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.backgroundColor = [UIColor lightGrayColor];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    clearButton.frame = CGRectMake(0, 0, 100, 44);
    clearButton.center = self.view.center;
    [clearButton addTarget:self action:@selector(clickClearButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickClearButton:(id)sender {
    [self.blockSyntaxObject excuteCopyBlock];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
}

@end
