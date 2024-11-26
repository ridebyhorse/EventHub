//
//  CategoryView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI


enum CategoryColor: String, CaseIterable {
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
                .frame(width: 120, height: 40)

            HStack(spacing: 6) {
                Image(systemName: categoryIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
                    .foregroundColor(.white)
                
                Text(categoryName)
                    .font(.custom(EventHubFont.body2))
                    .foregroundColor(.white)
                    .frame(maxWidth: 80)
               
            }
            .padding(4)
        }
    }
}

#Preview {
    CategoryView(categoryIcon: "sparkles", categoryName: "art", backgroundColor: .blue)
}

struct CategoriesScrollView: View {
    @ObservedObject var viewModel: ExploreViewModel
  
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                
                ForEach(Array(viewModel.categories.enumerated()), id: \.element.id) { index, category in
                    Button(action: {
                        viewModel.selectCategory(category)
                    }) {
                        CategoryView(
                            categoryIcon: category.systemIcon,
                            categoryName: category.name,
                            backgroundColor: category.assignedColor(index: index)
                        )
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .shadow(color: Color(red: 0.18, green: 0.18, blue: 0.31).opacity(0.12), radius: 10, x: 0, y: 6)
    }
}
