//
//  Model.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 30.06.2022.
//

import Foundation

protocol ModelDelegate {
    func fetchVideos(_ videos: [Video])
}

class Model {
    
    var delegate: ModelDelegate?
    
    func detVideos() {
        
        // Create URL object
        let url = URL(string: APIConstants.API_URL)
        guard url != nil else { return }
        
        // Get the URLSession object
        let session = URLSession.shared
        
        // Get a data task from the URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check if there were any errors
            if error != nil || data == nil { return }
            
            do {
                
                // Parsing the data into video objects
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data!)
                // Forse unwraped! because we alredy checked if that is not nil
                // And this method - throws, so we need let and try
                
                if response.items != nil {
                    
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
