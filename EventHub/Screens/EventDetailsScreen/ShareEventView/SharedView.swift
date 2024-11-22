//
//  SharedView.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct SharedView: View {
    // MARK: - Properties
    @Binding var isShowing: Bool
    @Binding var isShowingButton: Bool
    
    let buttons = ActionButtonsShareModel.allCases
    let columns = 4
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                /// Background color
                Color.black.ignoresSafeArea()
                    .opacity(0.5)
                
                VStack {
                    Capsule()
                        .frame(width: 30, height: 4)
                        .foregroundColor(.lightGreyV2)
                        .padding(.top, -10)
                    
                    HStack {
                        Text("Share with friends")
                            .font(.custom(EventHubFont.h4))
                            .opacity(0.8)
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.top, 12)
                    
                    /// ActionButtonsShare
                    VStack {
                        ForEach(groupedButtons(), id: \.self) { row in
                            HStack {
                                ForEach(row, id: \.self) { button in
                                    VStack {
                                        Button(action: {
                                            // some action
                                        }) {
                                            Image(button.imageName)
                                                .frame(width: 76, height: 76)
                                        }
                                        Text(button.title)
                                            .font(.custom(EventHubFont.subtitle2))
                                            .foregroundColor(.typographyBlack)
                                            .multilineTextAlignment(.center)
                                            .padding(.top, -22)
                                    }
                                }
                            }
                        }
                    }
                    
                    /// Button CANCEL
                    ActionButtonCancel(buttonText: "CANCEL", action: {
                        isShowing = false
                        isShowingButton.toggle()
                    })
                    .padding(.top, 18)
                    .padding(.bottom, 2)
                }
                .frame(height: 380)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(38)
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .animation(.easeOut)
        .ignoresSafeArea()
    }
    
    // MARK: - Methods
    private func groupedButtons() -> [[ActionButtonsShareModel]] {
        stride(from: 0, to: buttons.count, by: columns).map {
            Array(buttons[$0..<min($0 + columns, buttons.count)])
        }
    }
}

#Preview {
    SharedView(isShowing: .constant(true), isShowingButton: .constant(true))
}
