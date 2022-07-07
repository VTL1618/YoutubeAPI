//
//  Channel.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 06.07.2022.
//

import Foundation

struct Channel: Decodable, JSONable {
    
    var channelId = ""
    var channelName = ""
    var numberOfSubscribers = ""
    var channelBanner = ""
    var uploads = ""
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case contentDetails
        case relatedPlaylists
        case brandingSettings
        case image
        case statistics
        
        case channelId = "id"
        case channelName = "title"
        case numberOfSubscribers = "subscriberCount"
        case channelBanner = "bannerExternalUrl"
        case uploads
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse title
        self.channelName = try snippetContainer.decode(String.self, forKey: .channelName)
        
        // Parse number of subscribers
        let statisticsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .statistics)
        
        self.numberOfSubscribers = try statisticsContainer.decode(String.self, forKey: .numberOfSubscribers)
        
        // Parse banner
        let brandingSettingsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .brandingSettings)
        
        let imageContainer = try brandingSettingsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .image)
        
        self.channelBanner = try imageContainer.decode(String.self, forKey: .channelBanner)
        
        // Parse uploads
        let contentDetailsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .contentDetails)
        
        let relatedPlaylistsContainer = try contentDetailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .relatedPlaylists)
        
        self.uploads = try relatedPlaylistsContainer.decode(String.self, forKey: .uploads)
        
        // Parse Channel ID
        self.channelId = try container.decode(String.self, forKey: .channelId)
        
    }
    
}
