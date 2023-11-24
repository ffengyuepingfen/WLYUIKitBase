//
//  VideoView.swift
//  jinrongjiagou
//
//  Created by Laowang on 2023/1/5.
//

import SwiftUI
import AVKit

struct VideoView: View {
    
    @State var player : AVPlayer!
    
    var videoUrl: URL
    
    var body: some View {
        if #available(iOS 14.0, *) {
            VideoPlayer(player: player)
                .onAppear{
                    //                let url = Bundle.main.url(forResource: songName, withExtension: "mp4")!
                    self.player = AVPlayer(url: videoUrl)
                    self.player.play()
                }
        } else {
            // Fallback on earlier versions
        }
    }
    
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        let url = Bundle.main.url(forResource: "02丨吉他&贝斯：跳过枯燥的乐器练习，让你成为吉他手1", withExtension: "mp4")!
        VideoView(videoUrl: url)
    }
}
