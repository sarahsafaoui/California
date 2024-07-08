//
//  VideoView.swift
// 
//
//
//

import Foundation
import SwiftUI

struct VideoView: View {
    
    @State var videoURL: URL?
    @State private var isPlaying = false
    @State private var isForward = true
    @State private var isRewinding = true
    
    
    var body: some View {
        VStack {
            if let url = videoURL {
                ZStack {
                    Rectangle()
                        .frame(width: 352, height: 198)
                    VideoPlayerContainer(videoURL: url, isPlaying: $isPlaying, isRewinding: $isRewinding, isForward: $isForward)
                        .frame(width: 320, height: 180)
                    
                }
                
            } else {
                Text("Loading...")
                    .frame(width: 320, height: 180)
            }
            
            HStack {
                // This Hstack contains all the buttons that were using pause/play forward/rewind
                
                Button(action: {isRewinding = true}
                ) {
                
                    Image(systemName: "backward.fill")
                        .font(.title)
                        .padding()
                }
                
                Button(action: togglePlayPause) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .padding()
                }
                
                Button(action: {isForward = true}
                ) {
                    Image(systemName: "forward.fill")
                        .font(.title)
                        .padding()
                }
            }
            .padding()
        }

    }
    
    
    private func togglePlayPause() {
        isPlaying.toggle()
       
    }
    
   
}


// this is the UIViewRepresetable, its a way to bridge UIKit views to SwiftUI using the struct name below
struct VideoPlayerContainer: UIViewRepresentable {
    
    var videoURL: URL
    @Binding var isPlaying: Bool
    @Binding var isRewinding: Bool
    @Binding var isForward: Bool
    // binding variable that will always update accordingly
    var forward: ()
    
    // create the view
    func makeUIView(context: Context) -> VideoPlayerView {
        let view = UIView()
        return VideoPlayerView(frame: view.bounds, videoURL: videoURL)
    }
    
    // updating the view, like playing/pausing/rewinding...etc
    func updateUIView(_ uiView: VideoPlayerView, context: Context) {
        if isPlaying {
            uiView.play()
        } else {
            uiView.pause()
        }
        if isForward{
            uiView.forward()
            isForward = false
            
        }
        if isRewinding{
            uiView.rewind()
        }
        
        
    
    }
        
}


