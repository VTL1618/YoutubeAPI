//
//  ChannelsResponse.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 04.07.2022.
//

import Foundation

struct ChannelsResponse: Decodable {
    
    var items: [Channel]?
    
    enum CodingKeys: String, CodingKey {
        
        case items
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([Channel].self, forKey: .items)
        
    }
    
}
