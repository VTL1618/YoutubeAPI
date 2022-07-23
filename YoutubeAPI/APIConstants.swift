//
//  APIConstants.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 30.06.2022.
//

import Foundation

struct APIConstants {
    
    static var API_KEY = ""
    
    static var FIRST_PLAYLIST_API = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=jwmS1gc9S5A&id=E99Et5mzxv0&id=arDDZjcbaXI&id=yvX1WkFFtQI&id=9tobL8U7dQo&id=SQvM-mDkK_s&id=RUEtUaDcH2U&key=\(APIConstants.API_KEY)"
    
    static var SECOND_PLAYLIST_API = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=RH9cezXEFS0&id=kV__iZuxDGE&id=GByi_j-7Q2E&id=pJIKPzZTJXM&id=QuMWSrJyt3o&id=JCzFO1dFF-k&id=S5WaFx8rx54&id=72cAe_2LAFQ&id=XKfgdkcIUxw&id=m43rh-pI0P0&key=\(APIConstants.API_KEY)"
    
    static var CHANNELS_API = "https://youtube.googleapis.com/youtube/v3/channels?part=brandingSettings%2Csnippet%2CcontentDetails%2Cstatistics&id=UCE_M8A5yxnLfW0KghEeajjw&id=UCByOQJjav0CUDwxCk-jVNRQ&id=UCMCgOm8GZkHp8zJ6l7_hIuA&id=UCbTw29mcP12YlTt1EpUaVJw&key=\(APIConstants.API_KEY)"
    
    static var UPLOADS_API = "https://youtube.com/embed/videoseries?list="
    
    static var YOUTUBE_EMBED_URL = "https://youtube.com/embed/"
    
//    static var SECRET_ADD_FOR_API = "=w2120-fcrop64=1,00005a57ffffa5a8-k-c0xffffffff-no-nd-rj"
    
//    static var PLAYLIST_ID = "PLHFlHpPjgk714Wqve10unWDzDIo4HVAI8"

//    Запасной для проверки
//    static var SECOND_PLAYLIST_API = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=eZslMJsyKdw&id=eZslMJsyKdw&id=5A3ndYDeYkU&id=pJIKPzZTJXM&id=QuMWSrJyt3o&id=JCzFO1dFF-k&id=S5WaFx8rx54&id=72cAe_2LAFQ&id=XKfgdkcIUxw&id=m43rh-pI0P0&key=\(APIConstants.API_KEY)"
    
}
