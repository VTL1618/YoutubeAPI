//
//  APIConstants.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 30.06.2022.
//

import Foundation

struct APIConstants {
    
    static var API_KEY = "AIzaSyDOC4yPr_Z7Boy4h-fRQ57frKJgBJn2L0c"
    static var PLAYLIST_ID = "PLHFlHpPjgk714Wqve10unWDzDIo4HVAI8"
    static var API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(APIConstants.PLAYLIST_ID)&key=\(APIConstants.API_KEY)"
//    static var VIDEOCELL_ID = "FirstPlaylistCollectionViewCell"

}
