
import Foundation
import UIKit

struct FirstPlaylistModel {
    var coverImage: UIImage
    var nameOfVideo: String
    var numberOfViews: String
    
    static func fetchVideos() -> [FirstPlaylistModel] {
        let firstVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudMashkova")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 300 000 просмотров")
        
        let secondVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudEidelman")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 000 000 просмотров")
        
        let thirdVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudAkunin")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 700 000 просмотров")
        
        let fourthVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudFace")!,
            nameOfVideo: "Дудь",
            numberOfViews: "5 200 000 просмотров")
        
        let fifthVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudMashkova")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 300 000 просмотров")
        
        let sixthVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudEidelman")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 000 000 просмотров")
        
        let seventhVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudAkunin")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 700 000 просмотров")
        
        let eighthVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudFace")!,
            nameOfVideo: "Дудь",
            numberOfViews: "5 200 000 просмотров")
        
        let ninthVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudAkunin")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 700 000 просмотров")
        
        let tenthVideo = FirstPlaylistModel(
            coverImage: UIImage(named: "dudFace")!,
            nameOfVideo: "Дудь",
            numberOfViews: "5 200 000 просмотров")
        
        return [firstVideo, secondVideo, thirdVideo, fourthVideo, fifthVideo, sixthVideo, seventhVideo, eighthVideo, ninthVideo, tenthVideo]
    }
}

// struct с фиксированными расстояниями
struct ConstantsForPlaylists {
    static let leftDistanceToView: CGFloat = 16
    static let rightDistanceToView: CGFloat = 16
    static let galleryMinimumLineSpacing: CGFloat = 10
    // теперь можем вычислить ширину нашей ячейки в top карусели
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsForPlaylists.leftDistanceToView - ConstantsForPlaylists.rightDistanceToView - (ConstantsForPlaylists.galleryMinimumLineSpacing * 2)) / 2
}
