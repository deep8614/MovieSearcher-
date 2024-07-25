//
//  MovieDetailViewController.swift
//  Searcher
//
//  Created by Randeep singh on 2024-07-24.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {

    var movie: DetailedMovie

    init(movie: DetailedMovie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add a UIScrollView to allow scrolling through movie details
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        let containerView = UIView() // Container view for all the details
        scrollView.addSubview(containerView)
        
        let margin: CGFloat = 20
        var offsetY: CGFloat = margin
        
        // MOvie POSTER IMAGE VIEW
        let posterImageView = UIImageView(frame: CGRect(x: margin, y: offsetY, width: view.frame.width - 2 * margin, height: 400))
        posterImageView.contentMode = .scaleAspectFit
        if let url = URL(string: movie.Poster), let data = try? Data(contentsOf: url) {
            posterImageView.image = UIImage(data: data)
        }
        containerView.addSubview(posterImageView)
       
        offsetY += posterImageView.frame.height + margin   // TITLE LABEL
        let titleLabel = createLabel(text: movie.Title, fontSize: 24, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(titleLabel)
        
        
        offsetY += titleLabel.frame.height + margin //YEAR LABEL
        let yearLabel = createLabel(text: "Year: \(movie.Year)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(yearLabel)
        
        // RATED LABEL
        offsetY += yearLabel.frame.height + margin
        let ratedLabel = createLabel(text: "Rated: \(movie.Rated)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(ratedLabel)
        
        
        offsetY += ratedLabel.frame.height + margin //RELEASED LABEL
        let releasedLabel = createLabel(text: "Released: \(movie.Released)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(releasedLabel)
        
        
        offsetY += releasedLabel.frame.height + margin //RUN TIME LABEL
        let runtimeLabel = createLabel(text: "Runtime: \(movie.Runtime)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(runtimeLabel)
        
        offsetY += runtimeLabel.frame.height + margin //GENRE LABEL
        let genreLabel = createLabel(text: "Genre: \(movie.Genre)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(genreLabel)
        
        // DIRECTOR OF THE MOVIE LABEL
        offsetY += genreLabel.frame.height + margin
        let directorLabel = createLabel(text: "Director: \(movie.Director)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(directorLabel)
        
        // ACTORS LABEL
        offsetY += directorLabel.frame.height + margin
        let actorsLabel = createLabel(text: "Actors: \(movie.Actors)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(actorsLabel)
        
        
        offsetY += actorsLabel.frame.height + margin //PLOT LABEL
        let plotLabel = createLabel(text: "Plot: \(movie.Plot)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        plotLabel.numberOfLines = 0
        containerView.addSubview(plotLabel)
        // IMDb Rating label
        offsetY += plotLabel.frame.height + margin
        let imdbRatingLabel = createLabel(text: "IMDb Rating: \(movie.imdbRating)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(imdbRatingLabel)

        //PRODUCTION LABEL
        offsetY += imdbRatingLabel.frame.height + margin
        let productionLabel = createLabel(text: "Production: \(movie.Production)", fontSize: 16, offsetY: offsetY, containerView: containerView)
        containerView.addSubview(productionLabel)

        //THIS WILL ADJUST THE SIZE OF CONTROLLER
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: offsetY + margin)
        scrollView.contentSize = containerView.frame.size
    }
    private func createLabel(text: String, fontSize: CGFloat, offsetY: CGFloat, containerView: UIView) -> UILabel {
        let label = UILabel(frame: CGRect(x: 20, y: offsetY, width: view.frame.width - 40, height: 0))
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.sizeToFit()
        return label
    }
}

