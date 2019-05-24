//
//  MovieTableViewCell.swift
//  MovieSearch-C
//
//  Created by Haley Jones on 5/24/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

//Since the instructions say to write the view controllers in swift, i figure that also counts for a custom cell? It's a view i guess but. Gonna do it in swift to make sure i finish on time.
import UIKit
//I'm realy unhappy about this file not being in a Views folder but putting it in there caused an error i couldnt fix and i'm on a time limit. Same for the bridging header.
class MovieTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    //custom function to update the views.
    func updateViews(with movie: HAJMovie, poster: UIImage?){
        self.titleLabel.text = movie.title
        self.ratingLabel.text = "\(movie.rating)"
        self.descriptionLabel.text = movie.synopsis //remember to use synopsis to dodge that built-in description property.
        //because we made the completion on fetch image nullable it's gonna hand us an optional image os lets see if its there
        guard let posterImage = poster else {print("poster does not exist"); return}
        self.posterView.image = posterImage
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
