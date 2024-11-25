//
//  WebViewScreen.swift
//  EventHub
//
//  Created by Roman Golub on 25.11.2024.
//

import SwiftUI
import WebKit

struct WebViewScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    let urlPage: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                WebViewPresent(urlString: urlPage)
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
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
    }
}


struct WebViewPresent: UIViewRepresentable {
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        } else {
            uiView.loadHTMLString("<h1>Некорректный URL</h1>", baseURL: nil)
        }
    }
}

#Preview {
    WebViewScreen(urlPage: "https://kudago.com/follow/basta/")
}
