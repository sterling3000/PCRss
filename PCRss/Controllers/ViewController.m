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

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) FeedDataModel     *dataModel;
@property (nonatomic, strong) FeedViewModel     *viewModel;
@property (nonatomic, strong) UICollectionView  *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataModel = [[FeedDataModel alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_viewModel.feedViewLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[FeedCell class] forCellWithReuseIdentifier:NSStringFromClass([FeedCell class])];
    [self.view addSubview:_collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        return 1;
    }
    return MAX([_dataModel.feedItems count]-1, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FeedCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - UIcollectionViewFlowLayout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_viewModel collectionView:collectionView sizeForItemAtIndexPath:indexPath];
}

@end
