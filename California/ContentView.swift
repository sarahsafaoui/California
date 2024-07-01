


//
//  ContentView.swift
//  CaliforniaVideos
//
//  Created by sarah safaoui on 6/27/24.
// for loop - used to basically pull datat from array and copy it to the end

import SwiftUI
import AVKit
import UIKit

struct ContentView: View {
    
    @State private var videoThumbnail = ["Pool", "Drink", "Bird"] //make sure to declare variables before the body
    @State var player: AVPlayer? //telling our app we dont have the video loaded right away, will load when button clicked
    @State var video: URL? = nil
    @State var isPlaying = false
    @State var videoLoaded = false
    @State var isClicked = false
    @State private var searchText = ""
    @State private var showCamera = false
    var body: some View {
        
        GeometryReader{geo in// this is able to take material and place it according to the size of display
            
            
            VStack(alignment: .leading) {
                Text("Search Videos")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                TextField("Search", text: $searchText)
                    .padding(.vertical)
                    .padding(.horizontal,10)
                    .frame(width: geo.size.width * 0.8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                   
            }
            .padding(.top, 40)
            ZStack{
                ScrollView{
                    
                    VStack(alignment: .leading ) {
                        
                        Text("My Videos")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        
                        
                        ForEach(videoThumbnail,id:\.self){ photos in //id is current index number for array, starts at 0
                            HStack{
                                Button{
                                
                                    // this will run the fuction "openVideo" which asks for the video's URL. Basically its path in this project
                                    // After this it will set the "isClicked" bool to true which opens the sheet on screen.
                                    
                                    
                                    openVideo(video: Bundle.main.url(forResource: photos, withExtension: "mov")!)
                                    isClicked = true
                                    
                                } label: { //everything in here becomes a button
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: geo.size.width/2, height: geo.size.height/5)
                                        .overlay{
                                            Image(photos)
                                                .resizable()
                                                .frame(width: geo.size.width/2, height: geo.size.height/5)
                                                .shadow(radius: 5)
                                            
                                        }
                                }
                                VStack{
                                    
                                    Text(photos)
                                        .font(.headline)
                                    HStack{
                                        Text("Views")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        
                                        Text("Duration")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
   
                                }
                            }
                            Divider()  //anything thats a view starts with a capital
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        } ) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(width: 80, height: 80)
                                .background(Color.purple)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }

                    }
                } .padding(.top,(140))
            }.sheet(isPresented: $isClicked,onDismiss: {isClicked = false; videoLoaded = false}){// tells me that  the "sheet" will open if the bool is true
                

                
                // this will check to make sure that the bool is true, if it is then it means that the video asset is ready to be fed into the video player, it will then change the view from a progress view to an actual video player
                if self.videoLoaded {
                    VideoPlayer(player: self.player)
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                
            }
            
            
        }
    }
    
    
    // this function will make sure the video file does get placed into the "AV Player" asset so that it's usable in the video player
    func openVideo(video: URL) {
        // "Task" is a method that allows asyncrohnous work, it means that the video asset will begin loading while other things are happening (the sheet view popping up). The app does not have to wait for this function to finish because i marked it with the "Task" method. So it allows everything else to work just file while we load the video
        Task {
            self.player = AVPlayer(url: video)
            // the guard statement below is a double check just to make sure that the player is in fact loaded and ready, once its done we update the boolean below it so that the "sheet" view above changes (line 128)
            guard let _ = self.player else {return}
            self.videoLoaded = true
        }
    }
    
}
            struct CameraView: UIViewControllerRepresentable {
                @Binding var isPresented: Bool
    
                func makeUIViewController(context: Context) -> UIImagePickerController {
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    picker.cameraDevice = .rear
                    return picker
                }
    
                func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update the picker if needed
    }
}



