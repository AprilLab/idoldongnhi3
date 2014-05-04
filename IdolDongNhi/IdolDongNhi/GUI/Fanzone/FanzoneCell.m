//
//  FanzoneCell.m
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 4/27/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "FanzoneCell.h"

@implementation FanzoneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.avarta = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 35, 35)];
        [self.contentView addSubview:self.avarta];
        
        self.lastTimeMessage = [[UILabel alloc] initWithFrame:CGRectMake(55, 6, self.contentView.frame.size.width, 20)];
        self.lastTimeMessage.font= [UIFont fontWithName:@"Arial" size:11];
        self.lastTimeMessage.textColor= [UIColor grayColor];
        [self.contentView addSubview:self.lastTimeMessage];
        
        
        
        self.fanName = [[UILabel alloc] initWithFrame:CGRectMake(55, 20, self.contentView.frame.size.width, 20)];
        self.fanName.font= [UIFont fontWithName:@"Arial" size:15];
        self.fanName.textColor= [UIColor whiteColor];
        [self.contentView addSubview:self.fanName];
        
        self.message = [[UILabel alloc] initWithFrame:CGRectMake(55, 37, self.contentView.frame.size.width - 65, 15)];
        self.message.font= [UIFont fontWithName:@"Arial" size:12];
        self.message.textColor= [UIColor whiteColor];
        [self.contentView addSubview:self.message];
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
