//
//  CardView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    
    var eventTitle: String
    var eventDate: String
    var attendees: [String]
    var goingCount: Int
    var location: String
    var eventImage: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .frame(width: 237, height: 255)
            
            VStack(spacing: 10) {
                // MARK: - Image
                ZStack(alignment: .top) {
                    if let url = URL(string: eventImage) {
                        KFImage(url)
                            .placeholder {
                                ProgressView()
                                    .frame(width: 219, height: 131)
                            }
                            .retry(maxCount: 3, interval: .seconds(2)) // Повторные попытки загрузки
                            .cacheOriginalImage()
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 219, height: 131)
                            .cornerRadius(10)
                            .clipped()
                    } else {
                        Image("img")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 219, height: 131)
                            .cornerRadius(10)
                            .clipped()
                    }
                    
                    HStack {
                        // MARK: - Date
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.8))
                                .frame(width: 45, height: 45)
                                Text(eventDate)
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(.red)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 38, height: 40)
                        }
                        .padding(.top, 8)
                        
                        Spacer()
                        
                        // MARK: - Mark
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color.white.opacity(0.8))
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.red)
                        }
                        .padding(.top, -8)
                    }
                    .padding(.horizontal, 16)
                    Spacer()
                }
                
                // MARK: - Title
                Text(eventTitle)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                // MARK: - Persons going
                HStack(spacing: -8) {
                    ForEach(attendees.prefix(3), id: \.self) { attendee in
                        if let url = URL(string: attendee){
                            KFImage(url)
                                .placeholder {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 24, height: 24)
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 24, height: 24)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 1))
                        } else {
                            Image("img")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 24, height: 24)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 1))
                        }
                    }
                    
                    if goingCount > 3 {
                        Text("+\(goingCount - 3) Going")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(red: 0.25, green: 0.22, blue: 0.87))
                            .padding(.leading, 16)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                
                // MARK: - Location
                HStack {
                    Image("location")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("LightGrey"))
                    Text(location)
                        .font(.custom(EventHubFont.subtitle2))
                        .foregroundColor(Color("LightGrey"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
            //            .frame(width: 237, height: 255)
        }
        .frame(width: 237, height: 255)
        //        .padding(.vertical, 12)
        
        
    }
}

#Preview {
    CardView(
        eventTitle: "International Band Music Festival",
        eventDate: "6 Jun",
        attendees: ["person1", "person2", "person3", "person4"],
        goingCount: 20,
        location: "36 Guild Street London, UK",
        eventImage: "event_image"
    )
}




