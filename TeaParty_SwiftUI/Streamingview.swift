//
//  Streamingview.swift
//  TeaParty_SwiftUI
//
//  Created by slava bily on 30.05.2021.
//

import SwiftUI

struct Streamingview: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 190)
                Button(action: {
                    isPresented = false
                }, label: {
                    Text("Leave")
                        .font(.title)
                        .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                        .foregroundColor(.white)
                        .background(Color.red)
                })
                Spacer()
            }
            Spacer()
        }
        
    }
}

struct Streamingview_Previews: PreviewProvider {
    
    @State static var isPresented = true
    
    static var previews: some View {
        Streamingview(isPresented: $isPresented)
    }
}
