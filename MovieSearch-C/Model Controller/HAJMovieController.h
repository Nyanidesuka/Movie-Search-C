//
//  HAJMovieController.h
//  MovieSearch-C
//
//  Created by Haley Jones on 5/24/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//
//UIKit includes foundation so we can swap
#import <UIKit/UIKit.h>
//needs to know about movies if its gonna control them
#import "HAJMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface HAJMovieController : NSObject

//This'll just need fetch and IMO a source of truth because of the favorites black diamond
+(instancetype) shared;
//make this boi mutable so i can change it all the time
@property (nonatomic, copy)NSMutableArray<HAJMovie *> *movies;

//and now we need 2 fetchers, one for movies from a search and one for image for movie. NEither have to return anything because completions are lit
-(void)fetchMoviesWithSearch:(NSString *)searchTerms completion:(void (^) (NSArray<HAJMovie *>*))completion;//return an array of movie. Might be empty. But wont be nil.
-(void)fetchImageForMovie:(HAJMovie *)movie completion:(void (^) (UIImage * _Nullable))completion;//there might be no image, be nullable pls

@end

NS_ASSUME_NONNULL_END
