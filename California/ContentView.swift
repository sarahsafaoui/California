


//
//  ContentView.swift
//  CaliforniaVideos
//
//  Created by sarah safaoui on 6/27/24.



import SwiftUI
import AVKit

struct ContentView: View {
    
    @State private var videoThumbnails = ["Pool", "Drink", "Bird"]
    @State var selectedVideo: URL? = nil
    @State private var searchText = ""
    @State private var showSheet = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Text("Summer Video Playlist")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                TextField("Search", text: $searchText)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frame(width: geo.size.width * 0.8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Spacer(minLength: 20)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("My Videos")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        ForEach(videoThumbnails, id: \.self) { photo in //basically "for each" thumbnail this is going to happen
                            HStack {
                                Button {
                                    if let url = Bundle.main.url(forResource: photo, withExtension: "mov") {
                                        self.selectedVideo = url
                                        self.showSheet.toggle()
                                    } else {
                                        print("Video not found for \(photo)")
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 40)
                                        .frame(width: geo.size.width / 2, height: geo.size.height / 5)
                                        .overlay {
                                            Image(photo)
                                                .resizable()
                                                .frame(width: geo.size.width / 2, height: geo.size.height / 5)
                                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                                .shadow(color: .gray, radius: 10)
                                        }
                                }
                                
                                VStack {
                                    Text(photo)
                                        .font(.headline)
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading) {
                                            Text("Views")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            Text("10")
                                                .font(.caption2)
                                                .fontWeight(.medium)
                                        }
                                        VStack(alignment: .leading) {
                                            Text("Duration")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                                .lineLimit(1)
                                            Text("1:02")
                                                .font(.caption)
                                                .fontWeight(.medium)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.bottom, 10)
                            
                            Divider()
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                
                .sheet(isPresented: $showSheet) {
                    if let selectedVideo = selectedVideo {
                        VideoView(videoURL: selectedVideo)
                    }
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}














































































































