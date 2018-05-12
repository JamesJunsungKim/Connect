//
//  Page.swift
//  Connect
//
//  Created by James Kim on 5/8/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation

struct Page {
    let title: String
    let description: String
    let imageName: String
    
    static func fetchPages()-> [Page] {
        let firstPage = Page(title: "Share a great listen", description: "It's free to send your books to the people in your life. Every recipient's first book is on us", imageName: "page1")
        let secondPage = Page(title: "send from your library", description: "Tap the More menu next to any book. Choose \"send this book\"", imageName: "page2")
        let thirdPage = Page(title: "send from the player", description: "Tap the more menu in the upper cornoer. Choose \"SEnd this gbook\"", imageName: "page3" )
        return [firstPage, secondPage, thirdPage]
    }
}
