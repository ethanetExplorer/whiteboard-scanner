//
//  ContentView.swift
//  whiteboard-scanner
//
//  Created by Seth Loh on 22/10/22.
//
 
import SwiftUI


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var whiteboardManager = WhiteboardManager()
    
    var body: some View {
        TabView {
            HomeView(whiteboardManager: whiteboardManager, outputImages: [])
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            LibraryView()
                .tabItem {
                    Label("Whiteboards", systemImage: "rectangle.fill.on.rectangle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}