//
//  EventDetailsScreen.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct EventDetailsScreen: View {
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isBookmarked: Bool = true
    @State private var isButtonShow: Bool = true
    @State private var showSharedView: Bool = false
    @State private var scrollOffset: CGFloat = 0
    
    let mockImageHTTPS = "https://kudago.com/media/images/agent/19/d1/19d170f390f102f2bfea80e543be281f.jpg"
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(.vertical, showsIndicators: false) {
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            scrollOffset = geometry.frame(in: .global).minY
                        }
                        .onChange(of: geometry.frame(in: .global).minY) { newValue in
                            scrollOffset = newValue
                        }
                }
                
                VStack {
                    /// Image and ButtonShare
                    ZStack(alignment: .bottomTrailing) {
                        
                        ImageEventDetail(imageURL: mockImageHTTPS)
                        
                        ActionButtonHeader(
                            icon: "shared",
                            iconChange: "shared",
                            action: {
                                showSharedView = true
                                isButtonShow.toggle()
                            }
                        )
                        .opacity(isButtonShow ? 1000 : 0)
                        .padding(.trailing, 20)
                        .padding(.bottom, 14)
                    }
                    .frame(height: 180)
                    
                    /// MainContent - Tittle, Date, Location, Organizer, Description
                    VStack(alignment: .leading) {
                        /// Title
                        Text("International Band Music Concert")
                            .font(.custom(EventHubFont.h2))
                            .foregroundColor(.mainBlack)
                            .frame(width: 313, alignment: .topLeading)
                            .padding(.top, 70)
                        
                        /// Info Date and Time
                        InfoItem(image: "Date", title: "14 December, 2021", subTitle: "Tuesday, 4:00PM - 9:00PM")
                        
                        /// Info Location
                        InfoItem(image: "Location", title: "Gala Convention Center", subTitle: "36 Guild Street London, UK")
                            .padding(.top, 16)
                        
                        /// Info Name Organizer
                        OrganizationNameItem(imageURL: mockImageHTTPS, name: "Ashfak Sayem", position: "Organizer")
                            .padding(.top, 16)
                        
                        /// About Event
                        Text("About Event")
                            .font(.custom(EventHubFont.title1))
                            .foregroundColor(.typographyDarkGrey)
                            .padding(.top, 16)
                            .padding(.trailing, 20)
                        
                        /// Description
                        Text("Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will betrucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will beand have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will betrucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food f")
                            .font(.custom(EventHubFont.body1))
                            .foregroundColor(.typographyDarkGrey)
                            .opacity(0.9)
                            .lineSpacing(4)
                            .padding(.top, 6)
                            .padding(.trailing, 20)
                        
                    }
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            
            /// ButtonsLeft Tittle BookmarkButton
            VStack {
                HStack(alignment: .center) {
                    /// BackButton
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("arrowLeft")
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 28)
                    
                    /// Title
                    Text("Event Details")
                        .font(.custom(EventHubFont.h4))
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                        .padding(.bottom, 28)
                    
                    Spacer()
                    
                    /// BookmarkButton
                    ActionButtonHeader(
                        icon: "bookmarkED",
                        iconChange: "bookmarkFillED",
                        action: {
                            isBookmarked.toggle()
                        }
                    )
                    .padding(.trailing, 20)
                    .padding(.bottom, 28)
                }
                /// animation NavigationBar
                .background(
                    .ultraThinMaterial
                        .opacity(min(1, max(0, (-scrollOffset) / CGFloat(100))))
                )
                .animation(.easeInOut, value: scrollOffset)
                
                Spacer()
            }
            /// SharedView
            SharedView(isShowing: $showSharedView, isShowingButton: $isButtonShow)
        }
    }
}

#Preview {
    EventDetailsScreen()
}