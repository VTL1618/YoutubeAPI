
//
//  TopChannelModel.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 23.06.2022.
//

import Foundation
import UIKit

struct TopChannelModel {
    var coverImage: UIImage
    var nameOfChannel: String
    var numberOfSubscribers: String
    
    static func fetchChannels() -> [TopChannelModel] {
        let firstChannel = TopChannelModel(
            coverImage: UIImage(named: "dudMashkova")!,
            nameOfChannel: "Дудь",
            numberOfSubscribers: "10 000 000 подписчиков")
        
        let secondChannel = TopChannelModel(
            coverImage: UIImage(named: "dudEidelman")!,
            nameOfChannel: "Дудь",
            numberOfSubscribers: "10 000 000 подписчиков")
        
        let thirdChannel = TopChannelModel(
            coverImage: UIImage(named: "dudAkunin")!,
            nameOfChannel: "Дудь",
            numberOfSubscribers: "10 000 000 подписчиков")
        
        let fourthChannel = TopChannelModel(
            coverImage: UIImage(named: "dudFace")!,
            nameOfChannel: "Дудь",
            numberOfSubscribers: "10 000 000 подписчиков")
        
        return [firstChannel, secondChannel, thirdChannel, fourthChannel]
    }
}

// struct с фиксированными расстояниями
struct Constants {
    static let leftDistanceToView: CGFloat = 16
    static let rightDistanceToView: CGFloat = 16
    static let galleryMinimumLineSpacing: CGFloat = 32
    // теперь можем вычислить ширину нашей ячейки в top карусели
    static let galleryItemWidth = UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView
}
