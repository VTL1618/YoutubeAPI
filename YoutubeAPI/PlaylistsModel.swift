//
//  PlaylistsModel.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 30.06.2022.
//

import Foundation
import UIKit

protocol ModelDelegate {
    func fetchVideos(_ videos: [Video])
//    func fetchNumberOfViews(_ views: [String])
//    func fetchNumberOfViews(_ views: [ChannelsModel])
}

class PlaylistsModel {
    
    var delegate: ModelDelegate?
//    private var arrayOfVideos: [Video] = []
   
    func getVideos(playlist: String) {
        
        // Create URL object
        let url = URL(string: playlist)
        guard url != nil else { return }
        
        // Get the URLSession object
        let session = URLSession.shared
        
        // Get a data task from the URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check if there were any errors
            // If there Any error (error != nil - means if there is an error) or the No data, we return and don't execute further
            if error != nil || data == nil { return }
            
            do {
                
                // Parsing the data into video objects
                let decoder = JSONDecoder()
                let response = try decoder.decode(PlaylistsResponse.self, from: data!)
                // Forse unwraped! because we alredy checked if that is not nil
                // And this method - throws (away, literally), so we need let and try
                
                if response.items != nil {
                    
//                    self.arrayOfVideos = response.items!
                                            
                    DispatchQueue.main.async {
                        self.delegate?.fetchVideos(response.items!)
                    }
                
                }
                            
//                dump(response)
                
            } catch {
                
            }
            
        }
        // Kick off the task
        dataTask.resume()
        
    }
        
}
    
// struct с фиксированными расстояниями
struct ConstantsForChannels {
    static let leftDistanceToView: CGFloat = 16
    static let rightDistanceToView: CGFloat = 16
    static let galleryMinimumLineSpacing: CGFloat = 32
    // теперь можем вычислить ширину нашей ячейки в top карусели
    static let galleryItemWidth = UIScreen.main.bounds.width - ConstantsForChannels.leftDistanceToView - ConstantsForChannels.rightDistanceToView
}

struct ConstantsForPlaylist {
    static let leftDistanceToView: CGFloat = 16
    static let rightDistanceToView: CGFloat = 16
    static let galleryMinimumLineSpacing: CGFloat = 10
    // теперь можем вычислить ширину нашей ячейки в top карусели
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsForPlaylist.leftDistanceToView - ConstantsForPlaylist.rightDistanceToView - (ConstantsForPlaylist.galleryMinimumLineSpacing * 2)) / 2
}

struct ConstantsForSecondPlaylist {
    static let leftDistanceToView: CGFloat = 16
    static let rightDistanceToView: CGFloat = 16
    static let galleryMinimumLineSpacing: CGFloat = 10
    // теперь можем вычислить ширину нашей ячейки в top карусели
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsForSecondPlaylist.leftDistanceToView - ConstantsForSecondPlaylist.rightDistanceToView - (ConstantsForSecondPlaylist.galleryMinimumLineSpacing / 2)) / 2.5
}
