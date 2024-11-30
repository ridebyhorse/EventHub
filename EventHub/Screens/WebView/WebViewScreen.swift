//
//  WebViewScreen.swift
//  EventHub
//
//  Created by Roman Golub on 25.11.2024.
//

import SwiftUI
import WebKit

struct WebViewScreen: View {
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    
    let urlPage: URL?
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                WebViewPresent(url: urlPage)
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("arrowLeftBlack")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct WebViewPresent: UIViewRepresentable {
    // MARK: - Properties
    let url: URL?
    
    // MARK: - Methods
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            let request = URLRequest(url: url)
            uiView.load(request)
        } else {
            uiView.loadHTMLString("<h1>Некорректный URL</h1>", baseURL: nil)
        }
    }
}

#Preview {
    WebViewScreen(urlPage: URL(string: "https://kudago.com/follow/basta/"))
}
