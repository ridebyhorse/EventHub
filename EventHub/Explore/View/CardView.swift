//
//  CardView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI

struct CartView: View {
    
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
                .shadow(color: Color(red: 0.31, green: 0.33, blue: 0.53).opacity(0.06), radius: 15, x: 0, y: 8)
            
            VStack(spacing: 10) {
                // MARK: - Image
                ZStack(alignment: .top) {
                    Image("img")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 219, height: 131)
                        .cornerRadius(10)
                        .clipped()
                    
                    HStack {
                        // MARK: - Date
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 45, height: 45)
                            Text(eventDate)
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.red)
                                .lineLimit(2) // Ограничиваем двумя строками
                                .multilineTextAlignment(.center)
                                .frame(width: 45, height: 45)
                        }
                        .padding(.top, 8)
                        
                        Spacer()
                        
                        // MARK: - Mark
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color.white.opacity(0.7))
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
                        Image("img")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24, height: 24)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 1))
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
                        .font(.system(size: 13))
                        .foregroundColor(Color("LightGrey"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
            .frame(width: 237, height: 255) // Ограничиваем VStack
        }
        .frame(width: 237, height: 255) // Основное ограничение
        
        
    }
}

#Preview {
    CartView(
        eventTitle: "International Band Music Festival",
        eventDate: "10 JUNE",
        attendees: ["person1", "person2", "person3", "person4"],
        goingCount: 20,
        location: "36 Guild Street London, UK",
        eventImage: "event_image"
    )
}




