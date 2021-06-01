//
//  StreamingViewController.swift
//  TeaParty_SwiftUI
//
//  Created by slava bily on 31.05.2021.
//

import SwiftUI
import UIKit

struct SVC: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> StreamingViewController {
        let streamingViewController = StreamingViewController()
        
        return streamingViewController
    }
    
    func updateUIViewController(_ streamingViewController: StreamingViewController, context: Context) {
        streamingViewController.viewDidLoad()
    }
    
    static func leave() {
        StreamingViewController.leave()
    }
}
