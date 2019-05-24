//
//  HAJMovieController.m
//  MovieSearch-C
//
//  Created by Haley Jones on 5/24/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

#import "HAJMovieController.h"

//setting up the base url up here so i can shorthand it below
static NSString *const baseURLString = @"https://api.themoviedb.org/3/search/movie";
//also the API key.
static NSString *const apiKey = @"d7b164c4ba538d2cb40823a7a1472e3b";

@implementation HAJMovieController

//first up is gonna be the shared instance.
+ (instancetype)shared
{
    static HAJMovieController *shared = nil;
    //built-in snippet mvp
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [HAJMovieController new];
    });
    return shared;
}

//fetch
- (void)fetchMoviesWithSearch:(NSString *)searchTerms completion:(void (^)(NSArray<HAJMovie *> * _Nonnull))completion
{
    //first thing's first we gotta make that URL.
    NSURL *baseURL = [NSURL URLWithString:baseURLString]; //turn it into an actual URL from string
    NSURLQueryItem *apiKeyQuery= [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]; //make the api key a query item
    NSURLQueryItem *searchTermQuery  = [NSURLQueryItem queryItemWithName:@"query" value:searchTerms];//set search terms, these will be from the search bar
    //make the base url into components and then add query items to it.
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:false];
    components.queryItems = @[searchTermQuery, apiKeyQuery];
    NSURL *finalURL = components.URL;
    NSLog([finalURL absoluteString]); //just to be sure. Tested it and it returns a working URL.
    //Now that we have the URL let's actually sent it out to find us some movies; I recommend Iron Man 3, it's underrated.
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        { //handle the error
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion([NSArray new]); //i cant completion nil because i told the array not to be nullable but  i should be able to completion with an empty array?
            return;
        }
        if (!data)
        {
            NSLog(@"There was an error in %s: No data was fetched.", __PRETTY_FUNCTION__);
            completion([NSArray new]);
            return;
        }
        //by now we know there was no error and that we have data so lets make it into some movies
        NSMutableArray<HAJMovie *> *movies = [NSMutableArray new]; //starting out by making a place to store said movies temporarily
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]; //get that TLD
        NSArray *results = topLevelDictionary[@"results"];//was gonna declare it as an array of string-any dictionaries here but it was UGLY
        //i'm gonna for loop thru the results array in the TLD and for each result, make a movie from the dictionary i find
        for (int i = 0; i < results.count; i++)
        {
            NSDictionary<NSString *, id> *movieDict = results[i];
            HAJMovie *newMovie = [[HAJMovie alloc]initFromDictionary:movieDict];
            [movies addObject:newMovie];
        }
        //complete with this new movies array.
        completion(movies);
    }]resume];
}

//let's get the images now
- (void)fetchImageForMovie:(HAJMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    //always URL first
    NSURL *baseURL = [NSURL URLWithString:@"https://image.tmdb.org/t/p/w500"]; //a different base URL which feels less cool.
    NSURL *posterPathUrl = [baseURL URLByAppendingPathComponent:movie.posterURL];
    NSURLComponents *components = [NSURLComponents componentsWithURL:posterPathUrl resolvingAgainstBaseURL:false];
    //throw the api key on there
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:@"d7b164c4ba538d2cb40823a7a1472e3b"];
    components.queryItems = @[apiKey];
    NSURL *finalURL = components.URL;
    NSLog([finalURL absoluteString]);
    //and now we can just fetch
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil); //this one is a nullable completion thing so we can use nil again.
            return;
        } //it's just the same error handling as before really
        if (!data)
        {
            NSLog(@"There was an error in %s: No data was fetched.", __PRETTY_FUNCTION__);
            completion(nil);
            return;
        }
        //so now we know we've got data, lets make an image out of it and then we'll complete w that image
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }]resume]; //always resume ur data tasks, kids
}



@end
