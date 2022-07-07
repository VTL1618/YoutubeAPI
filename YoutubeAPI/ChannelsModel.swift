//
//  ChannelsModel.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 03.07.2022.
//

import Foundation
import UIKit

protocol ChannelsModelDelegate {
    func fetchChannels(_ channels: [Channel])
//    func fetchNumberOfViews(_ views: [String])
//    func fetchNumberOfViews(_ views: [ChannelsModel])
}

class ChannelsModel {
    
    var channelDelegate: ChannelsModelDelegate?
   
    func getChannels(playlist: String) {
        
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
                let response = try decoder.decode(ChannelsResponse.self, from: data!)
                // Forse unwraped! because we alredy checked if that is not nil
                // And this method - throws (away, literally), so we need let and try
                
                if response.items != nil {
                    
//                    self.arrayOfVideos = response.items!
                                            
                    DispatchQueue.main.async {
                        self.channelDelegate?.fetchChannels(response.items!)
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
