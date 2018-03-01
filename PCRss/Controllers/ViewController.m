//
//  ViewController.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "ViewController.h"
#import "FeedDataModel.h"
#import "DetailViewController.h"
#import "FeedCell.h"
#import "Artical.h"
#import "FeedViewModel.h"
#import "UIImageView+ImageLoader.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FeedDataModelDelegate>

@property (nonatomic, strong) FeedDataModel     *dataModel;
@property (nonatomic, strong) FeedViewModel     *viewModel;
@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UIActivityIndicatorView   *spinner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Personal Capital";
    
    // Add the refresh button onto the nav bar
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(onRefreshButtonClicked:)];
    [self.navigationItem setRightBarButtonItem:refresh];
    
    _dataModel = [[FeedDataModel alloc] init];
    _dataModel.delegate = self;
    
    _viewModel = [[FeedViewModel alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_viewModel.feedViewLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[FeedCell class] forCellWithReuseIdentifier:NSStringFromClass([FeedCell class])];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_collectionView];
    
    // Show a spinner
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.hidesWhenStopped = YES;
    _spinner.color = [UIColor blueColor];
    [_spinner startAnimating];
    [_collectionView addSubview:_spinner];
    
    // Layout spinner to make sure it always stay in the center
    _spinner.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[[NSLayoutConstraint constraintWithItem:_spinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_collectionView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0], [NSLayoutConstraint constraintWithItem:_spinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_collectionView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]]];

    // Start loading data
    [_dataModel refreshFeedData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_collectionView.collectionViewLayout invalidateLayout];
}

- (void)onRefreshButtonClicked:(UIResponder *)sender {
    // Refresh the data loading
    [_dataModel refreshFeedData];
}

#pragma mark - UICollectionDataSource, UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    // Open up a detailed view
    Artical *item = nil;
    
    switch (indexPath.section) {
        case 0:
            item = _dataModel.feedItems[0];
            break;
        case 1:
            item = _dataModel.feedItems[indexPath.item+1];
        default:
            break;
    }
    
    DetailViewController *detailVC = [[DetailViewController alloc] initWithLink:item.link title:item.title];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return [_dataModel.feedItems count] > 0 ? 1 : 0;
    }
    return MAX([_dataModel.feedItems count]-1, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FeedCell class]) forIndexPath:indexPath];
    Artical *item = nil;
    if (indexPath.section == 0) {
        CGPoint spacing = [_viewModel headlineTextSpacing];
        cell.xSpacing = spacing.x;
        cell.ySpacing = spacing.y;
        item = _dataModel.feedItems[0];
        cell.titleLabel.numberOfLines = 1;
        cell.titleLabel.text = item.title;
        cell.titleLabel.font = _viewModel.headlineTitleFont;
        cell.descLabel.numberOfLines = 2;
        cell.descLabel.text = [[NSDateFormatter localizedStringFromDate:item.pubDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle] stringByAppendingString: [NSString stringWithFormat:@" - %@", item.desc]];
        cell.descLabel.font = _viewModel.headlineDescFont;
    } else {
        CGPoint spacing = [_viewModel regularTileTextSpacing];
        cell.xSpacing = spacing.x;
        cell.ySpacing = spacing.y;
        item = _dataModel.feedItems[indexPath.item+1];
        cell.titleLabel.numberOfLines = 2;
        cell.titleLabel.text = item.title;
        cell.titleLabel.font = _viewModel.tileTitleFont;
        cell.descLabel.text = nil;
    }
    [cell.thumbnail setImageWithUrl:item.thumbnailUrl];
    
    return cell;
}

#pragma mark - UIcollectionViewFlowLayout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_viewModel collectionView:collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [_viewModel collectionView:collectionView minimumLineSpacingForSectionAtIndex:section];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [_viewModel collectionView:collectionView minimumInteritemSpacingForSectionAtIndex:section];
}

#pragma mark - FeedDataModelDelegate

- (void)feedDataDidLoad:(FeedDataModel *)model {
    [_spinner stopAnimating];
    [_collectionView reloadData];
}

- (void)feedDataFailedToLoad:(FeedDataModel *)model error:(NSError *)error {
    [_spinner stopAnimating];
    NSLog(@"feed loading failed with error: %@", error);
}

@end
