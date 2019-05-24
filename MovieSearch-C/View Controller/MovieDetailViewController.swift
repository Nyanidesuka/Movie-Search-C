//
//  MovieDetailViewController.swift
//  MovieSearch-C
//
//  Created by Haley Jones on 5/24/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//
//i only have time for detail view this week, i think.

//This isn't as pretty as last week's, had to spend more time on the actual code this time. Have mercy.
import UIKit

class MovieDetailViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var movie: HAJMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pageMovie = movie else {return}
        HAJMovieController.shared().fetchImage(for: pageMovie) { (image) in
            guard let moviePoster = image else {return}
            DispatchQueue.main.async {
                self.updateViews(with: pageMovie, poster: moviePoster)
            }
        }
    }
    //update all the views. even tho we'll only call it here it just feels cleaner as a function.
    func updateViews(with movie: HAJMovie, poster: UIImage){
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = "Released Date: \(movie.releaseDate)"
        self.ratingLabel.text = "Rating: \(movie.rating)"
        self.descriptionLabel.text = movie.synopsis
        posterView.image = poster
    }

}
