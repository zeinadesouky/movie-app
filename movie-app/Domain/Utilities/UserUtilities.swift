//
//  UserUtilities.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

protocol UserUtilitiesProtocol {
    static func addToWatchlist(movieID: Int)
    static func loadWatchlist() -> [Int]
    static func removeFromWatchlist(movieID: Int)
}

class UserUtilities: UserUtilitiesProtocol {
    private struct Keys {
        static let watchlist = "watchlist"
    }
    
    static func addToWatchlist(movieID: Int) {
        var watchlist = loadWatchlist()
        guard !watchlist.contains(movieID) else { return }
        watchlist.append(movieID)
        saveWatchlist(watchlist)
    }

    static func loadWatchlist() -> [Int] {
        return UserDefaults.standard.array(forKey: Keys.watchlist) as? [Int] ?? []
    }

    static func removeFromWatchlist(movieID: Int) {
        var watchlist = loadWatchlist()
        watchlist.removeAll { $0 == movieID }
        saveWatchlist(watchlist)
    }

    private static func saveWatchlist(_ watchlist: [Int]) {
        UserDefaults.standard.set(watchlist, forKey: Keys.watchlist)
    }
}
