
import Foundation
import UIKit

struct SecondPlaylistModel {
    var coverImage: UIImage
    var nameOfVideo: String
    var numberOfViews: String
    
    static func fetchVideos() -> [SecondPlaylistModel] {
        let firstVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudMashkova")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 300 000 просмотров")
        
        let secondVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudEidelman")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 000 000 просмотров")
        
        let thirdVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudAkunin")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 700 000 просмотров")
        
        let fourthVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudFace")!,
            nameOfVideo: "Дудь",
            numberOfViews: "5 200 000 просмотров")
        
        let fifthVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudMashkova")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 300 000 просмотров")
        
        let sixthVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudEidelman")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 000 000 просмотров")
        
        let seventhVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudAkunin")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 700 000 просмотров")
        
        let eighthVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudFace")!,
            nameOfVideo: "Дудь",
            numberOfViews: "5 200 000 просмотров")
        
        let ninthVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudAkunin")!,
            nameOfVideo: "Дудь",
            numberOfViews: "2 700 000 просмотров")
        
        let tenthVideo = SecondPlaylistModel(
            coverImage: UIImage(named: "dudFace")!,
            nameOfVideo: "Дудь",
            numberOfViews: "5 200 000 просмотров")
        
        return [firstVideo, secondVideo, thirdVideo, fourthVideo, fifthVideo, sixthVideo, seventhVideo, eighthVideo, ninthVideo, tenthVideo]
    }
}

// struct с фиксированными расстояниями
struct ConstantsForSecondPlaylist {
    static let leftDistanceToView: CGFloat = 16
    static let rightDistanceToView: CGFloat = 16
    static let galleryMinimumLineSpacing: CGFloat = 10
    // теперь можем вычислить ширину нашей ячейки в top карусели
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsForPlaylists.leftDistanceToView - ConstantsForPlaylists.rightDistanceToView - (ConstantsForPlaylists.galleryMinimumLineSpacing / 2)) / 2.5
}
