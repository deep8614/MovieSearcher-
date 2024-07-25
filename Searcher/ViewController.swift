//
//  ViewController.swift
//  Searcher
//
//  Created by Randeep singh on 2024-07-24.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView! // TABLE VIEW CONNECTED HERE
    @IBOutlet var field: UITextField! // TEXT FIELD CONNECTED HERE
    @IBOutlet var searchButton: UIButton! // SEARCH BUTTON CONNECTED HERE
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    // ACTIONS OF SEARCH BUTTON
    @objc func searchButtonTapped() {
        searchMovies()
    }
    
    // ACTIONS OF Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    
    func searchMovies() {
        field.resignFirstResponder()
        
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        let query = text.replacingOccurrences(of: " ", with: "%20")
        
        movies.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=f82acf5e&s=\(query)&type=movie")!,
                                   completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            // Convert
            var result: MovieResult?
            do {
                result = try JSONDecoder().decode(MovieResult.self, from: data)
            }
            catch {
                print("error")
            }
            
            guard let finalResult = result else {
                return
            }
            
            // Update our movies array
            let newMovies = finalResult.Search
            self.movies.append(contentsOf: newMovies)
            
            // REFRESH THE TABLE
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
        }).resume()
        
    }
    
    // FOR TABLE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
           cell.configure(with: movies[indexPath.row])
           return cell
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let imdbID = movies[indexPath.row].imdbID
        
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=22ea2b42=\(imdbID)")!,
                                   completionHandler: { data, response, error in //MY API KEY
            
            guard let data = data, error == nil else {
                return
            }
            
            // CONNVERT
            var detailedMovie: DetailedMovie?
            do {
                detailedMovie = try JSONDecoder().decode(DetailedMovie.self, from: data)
            }
            catch {
                print("error")
            }
            
            guard let finalDetailedMovie = detailedMovie else {
                return
            }
            
            DispatchQueue.main.async {
                // Show movie details
                let vc = MovieDetailViewController(movie: finalDetailedMovie)
                self.present(vc, animated: true)
            }
        }).resume()
    }
}

struct MovieResult: Codable {
    let Search: [Movie]
}


struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
  
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}
