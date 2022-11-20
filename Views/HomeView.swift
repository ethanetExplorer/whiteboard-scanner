//
//  HomeView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @ObservedObject var whiteboardManager: WhiteboardManager
    
    @State var outputImage = OutputImage()
    
    //sheet presented
    @State private var isImagePickerPresented = false
    @State private var isNewWhiteboardViewPresented = false
    @State var isDocumentScannerPresented = false
    //
    
    var body: some View {
        NavigationView {
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
                        // by importing
                        Menu {
                            // photos
                            Button {
                                isImagePickerPresented = true
                            } label: {
                                Image(systemName: "photo")
                                Text("Photos")
                            }
                            //files
                            Button {
                                print("import by files")
                            } label: {
                                Image(systemName: "folder")
                                Text("Files")
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                            Text("Import")
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
            .navigationTitle("Home")
            
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $inputImage)
            }
            
            .onChange(of: inputImage) { _ in
                loadImage()
                isNewWhiteboardViewPresented = true
            }
            
            .sheet(isPresented: $isNewWhiteboardViewPresented) {
                NewWhiteboardView(whiteboards: .constant([]))
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
    }
    
    
    func loadImage() {
        
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
    
    
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(whiteboardManager: WhiteboardManager())
//    }
//}
