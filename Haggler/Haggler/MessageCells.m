//
//  MessageCells.m
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "CustomGUI.h"
#import "MessageCells.h"

@implementation MessageCells

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        _senderAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)];
        _senderAndTimeLabel.textAlignment = NSTextAlignmentCenter;
        _senderAndTimeLabel.font = [UIFont systemFontOfSize:11.0];
        _senderAndTimeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_senderAndTimeLabel];
        
        _messageContentView = [[UITextView alloc] init];
        _messageContentView.backgroundColor = [UIColor clearColor];
        _messageContentView.layer.borderWidth = 1;
        _messageContentView.editable = NO;
        _messageContentView.scrollEnabled = NO;
        _messageContentView.layer.cornerRadius = 7.6;
        [_messageContentView sizeToFit];
        [self.contentView addSubview:_messageContentView];
        
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
