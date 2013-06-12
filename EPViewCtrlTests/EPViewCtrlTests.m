//
//  EPViewCtrlTests.m
//  EPViewCtrlTests
//
//  Created by Alexander Perepelitsyn on 5/30/13.
//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "ViewController.h"
#import <OCMock/OCMock.h>
#import "ViewController_ViewControllerExt.h"
#import "FakeNotificationCenter.h"

@interface EPViewCtrlTests : SenTestCase
{
    ViewController *sut;
    id fakeNotificationCenter;
}
@end

@implementation EPViewCtrlTests

#pragma mark - setUp/tearDown

- (void)setUp
{
    [super setUp];
    
    sut = [[ViewController alloc] init];
    fakeNotificationCenter = [[FakeNotificationCenter alloc] init];
}

- (void)tearDown
{
    sut = nil;
    fakeNotificationCenter = nil;
    
    [super tearDown];
}

#pragma mark - IBOutlets

- (void)testCurrentCountLabelIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut currentCountLabel], @"");
}

- (void)testSavedCountLabelIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut savedCountLabel], @"");
}

- (void)testPlusButtonIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut plusButton], @"");
}

- (void)testMinusButtonIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut minusButton], @"");
}

- (void)testSaveButtonIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut saveButton], @"");
}

- (void)testResetButtonIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut resetButton], @"");
}

#pragma mark - 

- (void)testDefaultUserDefaultsIsSet
{
    // ASSERT
    STAssertEqualObjects([[sut userDefaults] class], [NSUserDefaults class], @"");
}

#pragma mark - IBActions

- (void)testPlusButtonAction
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertTrue([[[sut plusButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside] containsObject:@"incrementCount:"], @"");
}

- (void)testMinusButtonAction
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertTrue([[[sut minusButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside] containsObject:@"decrementCount:"], @"");
}

- (void)testSaveButtonAction
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertTrue([[[sut saveButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside] containsObject:@"saveCount:"], @"");
}

- (void)testResetButtonAction
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertTrue([[[sut resetButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside] containsObject:@"resetCount:"], @"");
}

- (void)testIncrementCountAddsOneToCountLabel
{
    // ARRANGE
    [sut view];
    
    // ACT
    [sut incrementCount:nil];
    
    // ASSERT
    STAssertEqualObjects([[sut currentCountLabel] text], @"1", @"");
}

- (void)testIncrementCountTwiceAddsTwoToCountLabel
{
    // ARRANGE
    [sut view];
    
    // ACT
    [sut incrementCount:nil];
    [sut incrementCount:nil];
    
    // ASSERT
    STAssertEqualObjects([[sut currentCountLabel] text], @"2", @"");
}

- (void)testDecrementCountSubstractsOneFromCountLabel
{
    // ARRANGE
    [sut view];
    
    // ACT
    [sut decrementCount:nil];
    
    // ASSERT
    STAssertEqualObjects([[sut currentCountLabel] text], @"-1", @"");
}

- (void)testDecrementCountTwiceSubstractsTwoFromCountLabel
{
    // ARRANGE
    [sut view];
    
    // ACT
    [sut decrementCount:nil];
    [sut decrementCount:nil];
    
    // ASSERT
    STAssertEqualObjects([[sut currentCountLabel] text], @"-2", @"");
}

#pragma mark - View Lifecycle

- (void)testViewUnloading {
    [sut view];
    STAssertNotNil([sut view], @"");
    
    [sut didReceiveMemoryWarning];
    // Note that while sut.view is nil here we cannot test that directly as accessing view will trigger a call to loadView. Instead use outlets or -isViewLoaded.
    STAssertNil([sut currentCountLabel], @"");
    STAssertFalse([sut isViewLoaded], @"");
    
    [sut view];
    STAssertNotNil([sut view], @"");
    STAssertTrue([sut isViewLoaded], @"");
}

- (void)testVCStartsObservingDummyNotificationInViewDidLoad1 // LISTEN
{
    // ARRANGE
    id mockNotificationCenter = [OCMockObject mockForClass:[NSNotificationCenter class]];
    [[mockNotificationCenter expect] addObserver:sut selector:@selector(onSave:) name:kDummyNotification object:[OCMArg isNil]];
    [sut setNotificationCenter:mockNotificationCenter];
    
    // ACT
    [sut viewDidLoad];
    
    // ASSERT
    [mockNotificationCenter verify];
    
    // TEARDOWN
    sut.notificationCenter = nil;
}

#pragma mark - Notifications

- (void)testVCStartsObservingDummyNotificationInViewDidLoad2 // LISTEN
{
    // ACT
    [sut setNotificationCenter:fakeNotificationCenter];
    [sut viewDidLoad];
    
    // ASSERT
    STAssertTrue([fakeNotificationCenter hasObject:sut forNotification:kDummyNotification], @"");
}

- (void)testSaveCountPostsDummyNotification1 // GENERATE
{
    // ARRANGE
    id mockObserver = [OCMockObject observerMock];
    [[NSNotificationCenter defaultCenter] addMockObserver:mockObserver name:kDummyNotification object:nil];
    [[mockObserver expect] notificationWithName:kDummyNotification object:[OCMArg any]];
    
    // ACT
    [sut saveCount:nil];
    
    // ASSERT
    [mockObserver verify];
    
    // TEARDOWN
    [[NSNotificationCenter defaultCenter] removeObserver:mockObserver];
}

- (void)testSaveCountPostsDummyNotification2 // GENERATE
{
    // ARRANGE
    id mockNotificationCenter = [OCMockObject mockForClass:[NSNotificationCenter class]];
    [[mockNotificationCenter expect] postNotificationName:kDummyNotification object:[OCMArg any]];
    [sut setNotificationCenter:mockNotificationCenter];
    
    // ACT
    [sut saveCount:nil];
    
    // ASSERT
    [mockNotificationCenter verify];
    
    // TEARDOWN
    sut.notificationCenter = nil;
}

- (void)testThatDummyNotificationHandlerGetsCalled // REACT/GENERATE
{
    // ARRANGE
    id mockSut = [OCMockObject partialMockForObject:sut];
    [[mockSut expect] onSave:[OCMArg any]];
    [mockSut viewDidLoad]; // Invokes -addObserver:selector:name:object:
    
    // ACT
    [[NSNotificationCenter defaultCenter] postNotificationName:kDummyNotification object:nil];
    
    // ASSERT
    [mockSut verify];
}

- (void)testDummyNotificationHandlerDoesItsJob // REACT
{
    // ARRANGE
    id notificationMock = [OCMockObject mockForClass:[NSNotification class]];
    [[[notificationMock stub] andReturn:@11] object];
    id labelMock = [OCMockObject mockForClass:[UILabel class]];
    [[labelMock expect] setText:@"11"];
    [sut setSavedCountLabel:labelMock];
    
    // ACT
    [sut onSave:(NSNotification *)notificationMock]; // Invokes [self.savedCountLabel setText:[NSString stringWithFormat:@"%i", [[notif object] integerValue]];
    
    // ASSERT
    [labelMock verify];
}

#pragma mark - NSUserDefaults

- (void)clearUserDefaults
{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:@"com.temp.EPViewCtrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)testCountValueIsLoadedFromUserDefaults1
{
    // ARRANGE
    id mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    [[[mockDefaults expect] andReturn:@8] objectForKey:@"countValue"];
    [sut setUserDefaults:mockDefaults];
    
    // ACT
    [sut viewDidLoad];
    
    // ASSERT
    STAssertEquals([sut count], (NSInteger)8, @"");
}

- (void)testCountValueIsLoadedFromUserDefaults2 // Not recommended
{
    // ARRANGE
    [self clearUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:@12 forKey:@"countValue"];
    
    // ACT
    [sut viewDidLoad];
    
    // ASSERT
    STAssertEquals([sut count], (NSInteger)12, @"");
    
    //TEARDOWN
    [self clearUserDefaults];
}

- (void)testInitialCurrentCountValueLabelIsZero
{
    // ARRANGE
    id mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    [[[mockDefaults expect] andReturn:nil] objectForKey:@"countValue"];
    [sut setUserDefaults:mockDefaults];
    
    // ACT
    [sut view]; // [self view] -> [self loadView] -> [vc viewDidLoad]
    
    // ASSERT
    STAssertEqualObjects([[sut currentCountLabel] text], @"0", @"");
}

- (void)testInitialSavedCountValueLabelIsDash
{
    // ARRANGE
    id mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    [[[mockDefaults expect] andReturn:nil] objectForKey:@"countValue"];
    [sut setUserDefaults:mockDefaults];
    
    // ACT
    [sut view]; // [self view] -> [self loadView] -> [vc viewDidLoad]
    
    // ASSERT
    STAssertEqualObjects([[sut savedCountLabel] text], @"-", @"");
}

- (void)testSaveCountButtonSavesCountValueToUserDefaults
{
    // ARRANGE
    id mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    [[mockDefaults expect] setObject:[OCMArg any] forKey:@"countValue"];
    [[mockDefaults expect] synchronize];
    [sut setUserDefaults:mockDefaults];
    
    // ACT
    [sut saveCount:nil];
    
    // ASSERT
    [mockDefaults verify];
}

@end
