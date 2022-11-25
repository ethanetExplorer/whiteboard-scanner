//
//  WhiteboardDetailView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 19/11/22.
//

import SwiftUI

struct WhiteboardDetailView: View {
    
    @Binding var whiteboard: Whiteboard
    @State var hasDetailsChanged = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(uiImage: UIImage(data: whiteboard.imageData[whiteboard.imageData.count - 1])!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                TextField(whiteboard.title, text: $whiteboard.title)
                    .padding()
                    .onChange(of: whiteboard.title) { newValue in
                        whiteboard.title = whiteboard.title //don't know if this is redundant
                        hasDetailsChanged = true
                    }
                TextField(whiteboard.description, text: $whiteboard.description)
                    .padding()
                    .onChange(of: whiteboard.title) { newValue in
                        hasDetailsChanged = true
                    }
                Spacer()
                Button("Save") {
//                    whiteboardManager.whiteboards.append(Whiteboard(title: whiteboardTitle, description: whiteboardDesc, dateCreated: Date.now.formatted(date: .long, time: .shortened), imageData: outputImage.imgData))
//                    presentationMode.wrappedValue.dismiss()
                    // not sure how to use map/filter to replace struct
                }
                .disabled(!hasDetailsChanged)
                
            }
        }
        .navigationTitle($whiteboard.title)
    }
}

//struct WhiteboardDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhiteboardDetailView(whiteboard: .constant(Whiteboard(title: "Test", description: "desc test")))
//    }
//}
