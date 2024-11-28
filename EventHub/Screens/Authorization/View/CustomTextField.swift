//
//  CustomTextField.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/18/24.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var imageName: String
    var keyboardType: UIKeyboardType = .default

    @State private var isSecureEntry: Bool = true

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 22, height: 22)
                .padding(.trailing, 12)

            if isSecure {
                if isSecureEntry {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .font(.custom(EventHubFont.body3.name, size: EventHubFont.body3.size))
                        .textInputAutocapitalization(.never)
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .font(.custom(EventHubFont.body3.name, size: EventHubFont.body3.size))
                        .textInputAutocapitalization(.never)
                }
                Button(action: {
                    isSecureEntry.toggle()
                }) {
                    Image(systemName: isSecureEntry ? "eye" : "eye.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.eye)
                }
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .foregroundColor(.gray)
                    .font(.custom(EventHubFont.body3.name, size: EventHubFont.body3.size))
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
        }
        .padding()
        .frame(width: 317, height: 56)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.textFieldStroke)
        )
    }
}

#Preview {
    CustomTextField(placeholder: "Your email", text: .constant(""), imageName: "envelope", keyboardType: .emailAddress)
}

