//
//  ChannelsModel.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 03.07.2022.
//

import Foundation

struct ChannelsModel: Decodable {
    
    var videoId = ""
    
    enum CodingKeys: String, CodingKey {
        case snippet
        case resourceId
        case videoId
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse Video ID
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
    }
    
}
