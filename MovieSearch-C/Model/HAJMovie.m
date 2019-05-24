//
//  HAJMovie.m
//  MovieSearch-C
//
//  Created by Haley Jones on 5/24/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

#import "HAJMovie.h"

@implementation HAJMovie
//this is the lower level initializer, we'll pass stuff into this with another initializer.
-(instancetype)initWithTitle:(NSString *)title releaseDate:(NSString *)releaseDate rating:(double)rating posterURL:(NSString *)posterURL synopsis:(nonnull NSString *)synopsis;
{
    self = [super init];
    //i remembered to put the curly on its own line wow my styling is so correct
    if (self)
    {
        _title = title;
        _releaseDate = releaseDate;
        _rating = rating;
        _posterURL = posterURL;
        _synopsis = synopsis;
    }
    return self;
}
//this is the thing we'll use to turn the json into a movie.
- (instancetype)initFromDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    //so instead of using coding keys, in objC we just have to be very sure that we subscript the dicitonary with exactly the key the dictionary will have.
    NSString *title = dictionary[@"original_title"];
    NSString *releaseDate = dictionary[@"release_date"];

    double rating = [dictionary[@"vote_average"] doubleValue];
    NSString *posterURL = dictionary[@"poster_path"];
    NSString *synopsis = dictionary[@"overview"];
    
    self = [self initWithTitle:title releaseDate:releaseDate rating:rating posterURL:posterURL synopsis:synopsis];
    return self;
}
//model's done

@end
