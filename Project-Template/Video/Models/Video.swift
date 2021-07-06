//
//  Video.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation

// MARK: - Video
struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let thumbnail: String
    let description: String
    let videoLink: String

    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail
        case description = "description"
        case videoLink = "video_link"
    }
    
    //must define decoding structure since the JSON INT:id mismatches with Post:Identifiable protocol's STRING:id
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try String(container.decode(Int.self, forKey: .id))
        
        name = try container.decode(String.self, forKey: .name)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        description = try container.decode(String.self, forKey: .description)
        videoLink = try container.decode(String.self, forKey: .videoLink)
        
    }
    
    init(id: String, name: String, thumbnail: String, description: String, videoLink: String){
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.videoLink = videoLink
    }
}

extension Video {

    static func with(id: String = "2323",
                     name: String = "This is my video",
                     thumbnail: String = "https://placeimg.com/640/640/nature",
                     description: String = "Lorem ipsum",
                     videoLink: String = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8") -> Video {
        
        return Video(id: id,
                     name: name,
                     thumbnail: thumbnail,
                     description: description,
                     videoLink: videoLink)
    }
}
