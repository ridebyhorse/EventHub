//
//  CategoryView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI


enum CategoryColor: String {
    case red, blue, green, yellow
    
    var color: Color {
        switch self {
        case .red:
            return Color("MainRed")
        case .blue:
            return Color("MainOrange")
        case .green:
            return Color("MainGreen")
        case .yellow:
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
            // Закруглённый фон с цветом и тенью
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor.color)
                .frame(width: 106, height: 40)
                .shadow(color: Color(red: 0.18, green: 0.18, blue: 0.31).opacity(0.12), radius: 10, x: 0, y: 6)
            
            // Контент (иконка + текст)
            HStack(spacing: 8) {
                Image(categoryIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17) // Размер иконки
                
                Text(categoryName)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white) // Цвет текста
                    .frame(maxWidth: 48, alignment: .leading)
            }
        }
    }
}

#Preview {
    CategoryView(categoryIcon: "sport", categoryName: "Sport", backgroundColor: .yellow)
}

struct CategoriesScrollView: View {
    // Пример данных категорий
    let categories = [
        (icon: "sport", name: "Sport", color: CategoryColor.red),
        (icon: "music", name: "Music", color: CategoryColor.blue),
        (icon: "food", name: "Food", color: CategoryColor.green),
        (icon: "travel", name: "Art", color: CategoryColor.yellow)
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) { // Пространство между категориями
                ForEach(categories, id: \.name) { category in
                    CategoryView(
                        categoryIcon: category.icon,
                        categoryName: category.name,
                        backgroundColor: category.color
                    )
                }
            }
            .padding(.horizontal, 16) // Отступы по краям
        }
    }
}
