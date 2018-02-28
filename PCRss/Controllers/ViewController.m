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
    [self.view addSubview:_collectionView];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
//    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.view.layoutMargins = UIEdgeInsetsZero;
//    _collectionView.mar = UIEdgeInsetsZero;
//    NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0];
//    NSLayoutConstraint *layoutBottom = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:0];
//    NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeftMargin multiplier:1 constant:0];
//    NSLayoutConstraint *layoutRight = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRightMargin multiplier:1 constant:0];
//    [NSLayoutConstraint activateConstraints:@[layoutTop, layoutBottom, layoutLeft, layoutRight]];
    
    // Start loading data
    [_dataModel refreshFeedData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        item = _dataModel.feedItems[0];
        cell.titleLabel.numberOfLines = 1;
        cell.titleLabel.text = item.title;
        cell.descLabel.numberOfLines = 2;
        cell.descLabel.text = item.desc;
    } else {
        item = _dataModel.feedItems[indexPath.item+1];
        cell.titleLabel.numberOfLines = 2;
        cell.titleLabel.text = item.title;
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
    NSLog(@"data loaded");
    for (Artical *art in model.feedItems) {
        NSLog(@"artical title: %@", art.title);
    }
    [_collectionView reloadData];
}

- (void)feedDataFailedToLoad:(FeedDataModel *)model error:(NSError *)error {
    NSLog(@"feed loading failed with error: %@", error);
}

@end
