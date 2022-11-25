//
//  HomeView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//

import SwiftUI
import PhotosUI

struct HomeView: View {
    
    @State private var selectedImages: [PhotosPickerItem] = []
    @State private var selectedImageData: [Data] = []
    @ObservedObject var whiteboardManager: WhiteboardManager
    
    @State var outputImage = OutputImage()
    
    //sheet presented
    @State private var isImagePickerPresented = false
    @State private var isNewWhiteboardViewPresented = false
    @State var isDocumentScannerPresented = false
    @State private var isPhotosPickerPresented = false
    //
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ScrollView(.vertical) {
                        Menu {
                            // by camera
                            Button {
                                isDocumentScannerPresented = true
                            } label: {
                                Image(systemName: "camera")
                                Text("Camera")
                            }
                            // photos
                            Button {
                                print("Photo Picker")
                                isPhotosPickerPresented = true
                                
                            } label: {
                                Image(systemName: "photo")
                                Text("Photo")
                            }
                        } label: {
                            HStack() {
                                Image(systemName: "doc.viewfinder")
                                Text("New Scan")
                            }
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    
                }
                .photosPicker(isPresented: $isPhotosPickerPresented, selection: $selectedImages, matching: .images)
                .onChange(of: selectedImages) { newItems in
                    Task {
                        // Retrieve selected asset in the form of Data
                        for newItem in newItems {
                            if let data = try? await newItem.loadTransferable(type: Data.self) {
                                selectedImageData = [data]
                                var numberOfPages = data.count
                                outputImage.imgData = selectedImageData
                                isNewWhiteboardViewPresented = true
                                
                            }
                        }
                    }
                }
                .sheet(isPresented: $isNewWhiteboardViewPresented) {
                    //                NewWhiteboardView(whiteboards: .constant([]), outputImage: $outputImage)
                    NewWhiteboardView(whiteboardManager: whiteboardManager, outputImage: $outputImage)
                }
                
                .sheet(isPresented: $isDocumentScannerPresented) {
                    DocumentCameraView() { images in
                        outputImage.imgData = images.compactMap { $0.pngData() }
                        isNewWhiteboardViewPresented = true
                        isDocumentScannerPresented = false
                    }
                    .background(.black)
                }
            }
            .navigationTitle("Home")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            print(whiteboardManager.whiteboards)
        }
    }
    
    
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(whiteboardManager: WhiteboardManager())
//    }
//}
