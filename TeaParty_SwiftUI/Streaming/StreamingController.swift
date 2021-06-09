//
//  StreamingController.swift
//  TeaParty_SwiftUI
//
//  Created by slava bily on 30.05.2021.
//

import OpenTok
import Foundation

final class StreamingViewController: UIViewController {
  private let apiKey = "47232544"
  private let sessionId = "2_MX40NzIzMjU0NH5-MTYyMTM1MDA1OTEyMn53b0dWM0w0ZVdJRlJzajN6b01UODJRUTh-fg"
  // swiftlint:disable:next line_length
  private let token = "T1==cGFydG5lcl9pZD00NzIzMjU0NCZzaWc9MzExY2UwMmM2YTJhMmU2OTQ2ZGU2Mzg0ZDhhM2YyNGI0MjFmNmUxYzpzZXNzaW9uX2lkPTJfTVg0ME56SXpNalUwTkg1LU1UWXlNVE0xTURBMU9URXlNbjUzYjBkV00wdzBaVmRKUmxKemFqTjZiMDFVT0RKUlVUaC1mZyZjcmVhdGVfdGltZT0xNjIxMzUyMTE4Jm5vbmNlPTAuNTQ2MzcwNzgzOTMwODE4MyZyb2xlPXB1Ymxpc2hlciZleHBpcmVfdGltZT0xNjIzOTQ0MTE3JmluaXRpYWxfbGF5b3V0X2NsYXNzX2xpc3Q9"
  
  var subscriberView: UIView?
  
  private static var session: OTSession?
  
//  @IBOutlet private var leaveButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    connectToSession()
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)

//    leaveButton.layer.cornerRadius = leaveButton.frame.size.height / 2
//    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
  }

@objc func appMovedToForeground() {
    connectToSession()
    print("App moved to foreground!")
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        connectToSession()
    }

    static func leave() {
        var error: OTError?
        session?.disconnect(&error)
        
        if let error = error {
            print("An error occurred disconnecting from the session", error)
        }
//        else {
//            navigationController?.popViewController(animated: true)
//        }
    }
  
  private func connectToSession() {
    // 1
    StreamingViewController.session = OTSession(
      apiKey: apiKey,
      sessionId: sessionId,
      delegate: self
    )

    // 2
    var error: OTError?
    StreamingViewController.session?.connect(withToken: token, error: &error)

    // 3
    if let error = error {
      print("An error occurred connecting to the session", error)
    }
  }
  
  private func publishCamera() {
    // 1
    guard let publisher = OTPublisher(delegate: nil) else {
      return
    }

    // 2
    var error: OTError?
    StreamingViewController.session?.publish(publisher, error: &error)

    // 3
    if let error = error {
      print("An error occurred when trying to publish", error)
      return
    }

    // 4
    guard let publisherView = publisher.view else {
      return
    }

    // 5
    let screenBounds = UIScreen.main.bounds
    let viewWidth: CGFloat = 150
    let viewHeight: CGFloat = 267
    let margin: CGFloat = 20

    publisherView.frame = CGRect(
      x: screenBounds.width - viewWidth - margin,
      y: screenBounds.height - viewHeight - margin,
      width: viewWidth,
      height: viewHeight
    )
    view.addSubview(publisherView)
  }
  
  private func subscribe(to stream: OTStream) {
    // 1
    guard let subscriber = OTSubscriber(stream: stream, delegate: nil) else {
      return
    }

    // 2
    var error: OTError?
    StreamingViewController.session?.subscribe(subscriber, error: &error)

    // 3
    if let error = error {
      print("An error occurred when subscribing to the stream", error)
      return
    }

    // 4
    guard let subscriberView = subscriber.view else {
      return
    }

    // 5
    self.subscriberView = subscriberView
    subscriberView.frame = UIScreen.main.bounds
    view.insertSubview(subscriberView, at: 0)
  }
}

// MARK: - OTSessionDelegate
extension StreamingViewController: OTSessionDelegate {
  // 1
  func sessionDidConnect(_ session: OTSession) {
    print("The client connected to the session.")
    
    publishCamera()
  }

  // 2
  func sessionDidDisconnect(_ session: OTSession) {
    print("The client disconnected from the session.")
  }

  // 3
  func session(_ session: OTSession, didFailWithError error: OTError) {
    print("The client failed to connect to the session: \(error).")
  }

  // 4
  func session(_ session: OTSession, streamCreated stream: OTStream) {
    print("A stream was created in the session.")
    
    subscribe(to: stream)
  }

  // 5
  func session(_ session: OTSession, streamDestroyed stream: OTStream) {
    print("A stream was destroyed in the session.")
    
    subscriberView?.removeFromSuperview()
  }
}

