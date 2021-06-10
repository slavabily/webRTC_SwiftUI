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
        ZStack(alignment: .leading) {
            SVC()
            SocketView()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                .position(x: 100, y: 450.0)
            VStack {
                HStack {
                    Spacer(minLength: 250)
                    Button(action: {
                        SVC.leave()
                        isPresented = false
                    }, label: {
                        Text("Leave")
                            .font(.headline)
                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                            .foregroundColor(.white)
                            .background(Color.red)
                            .clipShape(Ellipse())
                    })
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct Streamingview_Previews: PreviewProvider {
    
    @State static var isPresented = true
    
    static var previews: some View {
        Streamingview(isPresented: $isPresented)
    }
}
