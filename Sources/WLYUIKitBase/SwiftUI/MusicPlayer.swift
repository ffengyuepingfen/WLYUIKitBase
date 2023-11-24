//
//  MusicPlayer.swift
//  jinrongjiagou
//
//  Created by Laowang on 2023/1/5.
//

import SwiftUI
import AVKit

struct MusicPlayer: View {
    
    @State var data : Data = .init(count: 0)
    @State var title = "001"
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var finish = false // 是否播放完成
    @State var del = AVDelegate() // 播放器的代理
    
    var songName: String
    
    @State var video1: URL? = nil
    @State var video2: URL? = nil
    
    var body: some View {
        
        Text("---")
//        VStack(spacing:8) {
//            HStack(alignment: .center) {
//                Image(uiImage:self.data.count == 0 ? UIImage(named: "001")! :  UIImage(data: self.data)!)
//                    .resizable()
//                    .frame(width: 44, height: 44)
//                    .cornerRadius(15)
//                Text(self.title).font(.subheadline)
//                Spacer()
//            }
//            ZStack(alignment: .leading) {
//                Capsule().fill(Color.black.opacity(0.08)).frame(height:8)
//                // 红色进度等于播放进度
//                Capsule().fill(Color.red).frame(width:self.width,height:8)
//                // 拖拽进度条处理
//                    .gesture(DragGesture()
//                        .onChanged({ value in
//                            let x = value.location.x
//                            self.width = x
//
//                        })
//                            .onEnded({ value in
//                                let x = value.location.x
//                                let screen = UIScreen.main.bounds.width - 30
//                                // 百分比
//                                let percent = x / screen
//                                self.player.currentTime = Double(percent) * self.player.duration
//                            })
//                    )
//
//            }
            
            
//            HStack(spacing:30) {
//                // 视频一
//                if let video1 = video1 {
//                    NavigationLink(destination: VideoView(videoUrl: video1), label: {
//                        Text("视频1").font(.subheadline)
//                    })
//                }
//
//                // 2.返回前15秒
//                Button  {
//                    self.player.currentTime -= 15
//                } label: {
//                    Image(systemName: "gobackward.15").font(.title)
//                }
//
//                // 3.播放暂停
//                Button  {
//                    if self.player.isPlaying {
//                        self.player.pause()
//                        self.playing = false
//                    }
//                    else {
//                        if self.finish {
//                            self.player.currentTime = 0
//                            self.width = 0
//                            self.finish = false
//                        }
//
//                        self.player.play()
//                        self.playing = true
//                    }
//
//                } label: {
//                    // 如果是播放完成 也要变回到播放按钮
//                    Image(systemName:self.playing && !self.finish  ? "pause.fill" : "play.fill").font(.title)
//                }
//                // 4.向后跳15秒
//                Button  {
//                    let increase = self.player.currentTime + 15
//                    if increase < self.player.duration {
//                        self.player.currentTime = increase
//                    }
//
//
//                } label: {
//                    Image(systemName: "goforward.15").font(.title)
//                }
//
//                // 视频2
//                if let video2 = video2 {
//                    NavigationLink(destination: VideoView(videoUrl: video2), label:{
//                        Text("视频2").font(.subheadline)
//                    })
//                }
//
//
//            }
//            .padding(.top)
//            .foregroundColor(Color.black)
            
//        }
//        .padding()
//        .onAppear{
//
//            let url = Bundle.main.path(forResource: songName, ofType: "m4a")
//            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
//            self.player.prepareToPlay()
//            self.player.delegate = self.del
//            // 获取音频数据 并且把音频数据得到的data存储起来
//            self.getData()
//
//            // 启动定时器 播放时候 进度同步更新
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
//                if self.player.isPlaying {
//                    // 测试播放进度
//                    //print(self.player.currentTime)
//                    let screen = UIScreen.main
//                        .bounds.width - 30
//
//                    let value = self.player.currentTime / self.player.duration
//
//                    self.width = screen * CGFloat(value)
//                }
//            }
//
//            // 使用通知监听歌曲是否播放完成
//            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
//                self.finish = true
//            }
//
//            video1 = Bundle.main.url(forResource: songName, withExtension: "mp4")
//            video2 = Bundle.main.url(forResource: songName + "2", withExtension: "mp4")
//        }
//        .onDisappear{
//            self.player.stop()
//
//        }
    }
    
    func getData(){
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata {
            
            if i.commonKey?.rawValue == "artwork" {
                let data = i.value as! Data
                self.data = data
            }
            
            if i.commonKey?.rawValue == "title"{
                let title = i.value as! String
                self.title = title
                
            }
            self.title = songName
        }
    }
}

struct MusicPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayer(songName: "01丨业务初探：扫了二维码之后发生了什么？")
    }
}

// 通过代理监听歌曲是否播放完成
// 使用通知告诉视图 操作播放完成的操作
class AVDelegate : NSObject,AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
