import SwiftUI
import CoreData


struct FavoriteEmptyView: View {
    
    var body: some View {
        VStack {
            // MARK: - Header

            // MARK: - Main Part
            
            Text("NO FAVORITES")
                .font(.custom(EventHubFont.h1.name, size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(.darkBlack)
                .frame(width: 231, height: 240, alignment: .center)
                .padding(.top, 102)
            
            ZStack {
                Image("emptyFavorite")
                    .resizable()
                    .scaledToFit()
                
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.mainRed)
                    .frame(width: 31, height: 30)
                    .offset(y: -10)
            }
            .frame(width: 137, height: 143)
            .padding(.top, -50)
        
         
        }
        Spacer()
    }
}

#Preview {
    FavoriteEmptyView()
}
