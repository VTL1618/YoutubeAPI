//
//  Video.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 30.06.2022.
//

import Foundation

struct Video: Decodable, JSONable {
    
    var videoId = ""
    var title = ""
    var numberOfViews = ""
    var thumbnail = ""
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case statistics
        
        case videoId = "id"
        case title
        case numberOfViews = "viewCount"
        case thumbnail = "url"
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse thumbnails
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Parse Video ID
        self.videoId = try container.decode(String.self, forKey: .videoId)
        
        // Parse numberOfViews
        let statisticsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .statistics)

        self.numberOfViews = try statisticsContainer.decode(String.self, forKey: .numberOfViews)
        
    }
    
}
