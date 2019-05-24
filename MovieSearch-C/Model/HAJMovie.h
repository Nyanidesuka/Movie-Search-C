//
//  HAJMovie.h
//  MovieSearch-C
//
//  Created by Haley Jones on 5/24/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HAJMovie : NSObject

@property (nonatomic, copy) NSString *title;
//turns out NSObjects have a built-in property called description so this has to be called synopsis.
@property (nonatomic, copy, readonly) NSString *synopsis;
@property (nonatomic, copy) NSString *releaseDate;
//I'm making this a string to try and fix some issue it was giving me when trying to assign a value from the dictionary.
@property (nonatomic) double rating;
@property (nonatomic, copy) NSString *posterURL;
//inits. Two of them.
-(instancetype)initWithTitle:(NSString *)title releaseDate:(NSString *)releaseDate rating:(double)rating posterURL:(NSString *)posterURL synopsis:(NSString *)synopsis;
-(instancetype)initFromDictionary:(NSDictionary<NSString *, id> *)dictionary;


@end

NS_ASSUME_NONNULL_END
