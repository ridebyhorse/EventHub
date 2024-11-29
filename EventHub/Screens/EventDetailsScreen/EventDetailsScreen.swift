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
//    @EnvironmentObject var navigationManager: NavigationManager
    @State private var isBookmarked: Bool = true
    @State private var isButtonShow: Bool = true
    @State private var showSharedView: Bool = false
    @State private var scrollOffset: CGFloat = 0
    
    let event: EventModel
    
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
                        
                        ImageEventDetail(imageURL: event.images.first?.image)
                        
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
                        Text(event.title.capitalizingFirstLetter())
                            .font(.custom(EventHubFont.h2))
                            .foregroundColor(.mainBlack)
                            .frame(width: 313, alignment: .topLeading)
                            .padding(.top, 70)
                        
                        /// Info Date and Time
                        InfoItem(image: "Date",
                                 title: event.dates.first?.start.formattedForEventDate() ?? "nil",
                                 subTitle: event.dates.first?.start.formattedForEvent() ?? "nil")
                        
                        /// Info Location
                        InfoItem(image: "Location", title: "Gala Convention Center", subTitle: event.location.slug.formattedLocation)
                            .padding(.top, 16)
                        
                        /// Info Name Organizer
                        OrganizationNameItem(imageURL: event.images.first?.image, name: event.tagline, position: "Organizer")
                            .padding(.top, 16)
                        
                        /// About Event
                        let cleanedDescription = removeHTMLTags(from: event.description)
                        if cleanedDescription.isEmpty {
                            Text("Ошибка при загрузке текста")
                        } else {
                            Text(cleanedDescription)
                                .font(.custom(EventHubFont.title1))
                                .foregroundColor(.typographyDarkGrey)
                                .opacity(0.9)
                                .lineSpacing(4)
                                .padding(.top, 16)
                                .padding(.trailing, 20)
                        }
                        
                        /// Description
                        let cleanedText = removeHTMLTags(from: event.bodyText)
                        if cleanedText.isEmpty {
                            Text("Ошибка при загрузке текста")
                        } else {
                            Text(cleanedText)
                                .font(.custom(EventHubFont.body1))
                                .foregroundColor(.typographyDarkGrey)
                                .opacity(0.9)
                                .lineSpacing(4)
                                .padding(.top, 6)
                                .padding(.trailing, 20)
                        }
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
                    Text(event.shortTitle)
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
    // MARK: - Methods
    private func removeHTMLTags(from htmlString: String) -> String {
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [])
        let range = NSRange(location: 0, length: htmlString.utf16.count)
        return regex.stringByReplacingMatches(in: htmlString, options: [], range: range, withTemplate: "")
    }
}
