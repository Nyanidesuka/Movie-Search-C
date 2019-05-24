//
//  MovieTableViewController.swift
//  MovieSearch-C
//
//  Created by Haley Jones on 5/24/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//
//hey swift how u been
import UIKit

class MovieTableViewController: UITableViewController {

    var movies: [HAJMovie] = []{
        didSet{
            DispatchQueue.main.async {
                print("got movies. \(self.movies.count)")
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        //I definitely declared the shared.movies array to only ever contain HAJMovie but i still need to cast it seems.
        let cellMovie = movies[indexPath.row]
        HAJMovieController.shared().fetchImage(for: cellMovie) { (image) in
            //always hop on the main thread to update UI.
            DispatchQueue.main.async {
                cell.updateViews(with: cellMovie, poster: image)
            }
        }
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !self.movies.isEmpty{ //preeeeetty sure there'd be some sketchy results if i let them segue with all the cells empty.
            if segue.identifier == "toMovieDetail"{
                guard let destinVC = segue.destination as? MovieDetailViewController else {return}
                guard let index = tableView.indexPathForSelectedRow else {return}
                let passMovie = self.movies[index.row]
                destinVC.movie = passMovie
            }
        }
    }
    

}
//adopt the delegate protocol so the search bar can politely boss us around
extension MovieTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        if (searchText != ""){ //dont search if they didnt type.
        HAJMovieController.shared().fetchMovies(withSearch: searchText) { (fetchedMovies) in
                DispatchQueue.main.async {
                    //i'm doing this on main thread because it'll trigger a didset that'll update UI and i am PARANOID.
                    self.movies = fetchedMovies
                }
            }
        }
    }
}
