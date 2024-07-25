//
//  DetailedMOvie.swift
//  Searcher
//
//  Created by Randeep singh on 2024-07-24.
//

import Foundation
struct DetailedMovie: Codable {
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Actors: String
    let Plot: String
    let Poster: String
    let imdbRating: String
    let Production: String

    private enum CodingKeys: String, CodingKey {
        case Title, Year, Rated, Released, Runtime, Genre, Director, Actors, Plot, Poster, imdbRating, Production
    }
}
