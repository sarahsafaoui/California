import Foundation
import AVFoundation
import UIKit

// This is the actual View of the Video created in UIKit, this is where the video lives
// structs don't normally update so using class here. Need the video player to exist for the entire lifecycle that its been created- this is where class comes in!!!
// So the video player is created in its own class then exposed to the videoPlayerContainer as a bridge to SwiftUI
class VideoPlayerView: UIView { // basically the class blueprint
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    // custom init overriding the superclass one //only use init when dealing with classes 
    // using custom because we require something in our class so this overrides the standard init
    init(frame: CGRect, videoURL: URL) {
        super.init(frame: frame)
        setupPlayer(with: videoURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setup the player with the video URL
    private func setupPlayer(with videoURL: URL) {
        // creating the video player
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = bounds
        playerLayer?.videoGravity = .resizeAspect
        if let playerLayer = playerLayer {
            // adding the video to the view's sublayer
            layer.addSublayer(playerLayer)
        }
    }
    
    // playback functions
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func forward() {
        guard let player = player else { return }
        let currentTime = player.currentTime()
        let newTime = CMTimeAdd(currentTime, CMTimeMake(value: 10, timescale: 1))
        player.seek(to: newTime)
    }
    
    func rewind() {
        guard let player = player else { return }
        let currentTime = player.currentTime()
        let newTime = CMTimeSubtract(currentTime, CMTimeMake(value: 10, timescale: 1))
        player.seek(to: newTime)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
}

