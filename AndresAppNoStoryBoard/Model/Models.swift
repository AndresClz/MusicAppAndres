//
//  Models.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 09/12/2021.
//

import Foundation

struct Account {
    let user: String
    let pass: String
}
struct Registered {
    let user1: Account = Account(user: "andres@gmail.com", pass: "Password1234")
}

struct Track: Codable, Hashable {
    let title: String?
    let artist: String?
    let album: String?
    let songId: String?
    let genre: String?
    //let duration: Double?
    
    enum CodingKeys: String, CodingKey {
        case songId = "song_id"
        case title = "name"
        //case duration
        case artist
        case genre
        case album
        
    }
}
//enum Genero : String, Codable{
//    case Rock
//    case Pop
//    case Folclore
//    case Vacio = ""
//}
 var misTracks = [Track]()

//enum PlayerStates{
//    case play
//    case pause
//    case next
//    case previous
//}
//enum contextMenu : String, Codable{
//    case Remove = "Remove from Playlist"
//    case Download
//    case Add = "Add to Playlist"
//    case Share = "Share Song"
//    case Love = "Add to your liked songs"
//
//}
