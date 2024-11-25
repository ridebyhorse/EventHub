//
//  CategoryView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI


enum CategoryColor: String {
    case red, orange, green, blue
    
    var color: Color {
        switch self {
        case .red:
            return Color("MainRed")
        case .orange:
            return Color("MainOrange")
        case .green:
            return Color("MainGreen")
        case .blue:
            return Color("MainLightBlue")
        }
    }
}

struct CategoryView: View {
    let categoryIcon: String
    let categoryName: String
    let backgroundColor: CategoryColor
    
    var body: some View {
        ZStack {

            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor.color)
                .frame(width: 106, height: 40)

            HStack(alignment: .center, spacing: 8) {
                Image(categoryIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
                
                Text(categoryName)
                    .font(.custom(EventHubFont.body2))
                    .foregroundColor(.white)
                    .frame(maxWidth: 48, alignment: .leading)
            }
        }
    }
}

#Preview {
    CategoryView(categoryIcon: "sport", categoryName: "Sport", backgroundColor: .blue)
}

struct CategoriesScrollView: View {
    // Пример данных категорий
    let categories = [
        (icon: "sport", name: "Sport", color: CategoryColor.red),
        (icon: "music", name: "Music", color: CategoryColor.orange),
        (icon: "food", name: "Food", color: CategoryColor.green),
        (icon: "palette", name: "Art", color: CategoryColor.blue)
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories, id: \.name) { category in
                    CategoryView(
                        categoryIcon: category.icon,
                        categoryName: category.name,
                        backgroundColor: category.color
                    )
                }
            }
            .padding(.horizontal, 16)
        }
        .shadow(color: Color(red: 0.18, green: 0.18, blue: 0.31).opacity(0.12), radius: 10, x: 0, y: 6)
    }
}
