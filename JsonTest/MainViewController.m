//
//  MainViewController.m
//  JsonTest
//
//  Created by Parag Shah on 7/11/14.
//  Copyright (c) 2014 Parag Shah. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewController.h"
#import "JsonDownloader.h"


@interface MainViewController ()<JSDownloaderDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) JsonDownloader *downloader;
@property (nonatomic) NSArray *list;

@end


@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  NSURL *URL = [[NSURL alloc] initWithString:JSON_ITUNES_TOP_25];
  self.downloader = [[JsonDownloader alloc] initWithURL:URL];
  self.downloader.delegate = self;
  [self.downloader start];

  MainTableViewController *mainTVC = [MainTableViewController new];
  mainTVC.tableView.delegate = self;
  mainTVC.tableView.dataSource = self;
  self.tableView = mainTVC.tableView;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
  [self.view addSubview:mainTVC.view];
}

#pragma mark - JSDownloaderDelegate

- (void)download:(JsonDownloader *)jsonDownloader didFinishWithDictionary:(NSDictionary *)data {
  self.list = data[@"feed"][@"entry"];

  dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
  });
}

- (void)download:(JsonDownloader *)jsonDownloader didFailWithError:(NSError *)error {
  NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.list.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

  if (cell == nil) {
    cell = [UITableViewCell new];
  }

  cell.textLabel.text = self.list[indexPath.row][@"title"][@"label"];
  return cell;
}

@end
