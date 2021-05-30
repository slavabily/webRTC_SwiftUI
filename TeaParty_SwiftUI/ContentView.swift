//
//  ContentView.swift
//  TeaParty_SwiftUI
//
//  Created by slava bily on 29.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            Image("tea-background")
                .resizable(capInsets: EdgeInsets(), resizingMode: .tile)
            
            Button(action: {
                isPresented = true
            }, label: {
                Text("Enter Lounge")
                    .padding(EdgeInsets(top: 20, leading: 100, bottom: 20, trailing: 100))
                    .foregroundColor(.black)
                    .background(Color.white)
                    .border(Color.black)
            })
        }.sheet(isPresented: $isPresented, onDismiss: {}, content: {
            Streamingview(isPresented: $isPresented)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
