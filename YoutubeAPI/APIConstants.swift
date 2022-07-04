//
//  APIConstants.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 30.06.2022.
//

import Foundation

struct APIConstants {
    
    static var API_KEY = "AIzaSyDOC4yPr_Z7Boy4h-fRQ57frKJgBJn2L0c"
    
    static var FIRST_PLAYLIST_API = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=jwmS1gc9S5A&id=E99Et5mzxv0&id=arDDZjcbaXI&id=yvX1WkFFtQI&id=9tobL8U7dQo&id=SQvM-mDkK_s&id=RUEtUaDcH2U&key=\(APIConstants.API_KEY)"
    static var SECOND_PLAYLIST_API = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=RH9cezXEFS0&id=kV__iZuxDGE&id=GByi_j-7Q2E&id=pJIKPzZTJXM&id=QuMWSrJyt3o&id=JCzFO1dFF-k&id=S5WaFx8rx54&id=72cAe_2LAFQ&id=XKfgdkcIUxw&id=m43rh-pI0P0&key=\(APIConstants.API_KEY)"
    
//    static var API_URL = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=RH9cezXEFS0&id=kV__iZuxDGE&id=GByi_j-7Q2E&id=pJIKPzZTJXM&id=QuMWSrJyt3o&id=JCzFO1dFF-k&id=S5WaFx8rx54&id=72cAe_2LAFQ&id=XKfgdkcIUxw&id=m43rh-pI0P0&key=\(APIConstants.API_KEY)"
    
//    static var PLAYLIST_ID = "PLHFlHpPjgk714Wqve10unWDzDIo4HVAI8"
//    static var API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(APIConstants.PLAYLIST_ID)&key=\(APIConstants.API_KEY)"
    
}
