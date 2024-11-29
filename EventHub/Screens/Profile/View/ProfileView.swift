//
//  ProfileView.swift
//  EventHub
//
//  Created by Kate Kashko on 26.11.2024.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var isEditing: Bool = false
    @State private var name: String = ""
    @State private var aboutMe: String = ""
    @State private var profileImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    
    var body: some View {

        VStack {
            Text("Profile")
            .font(.system(size: 24, weight: .medium))
            .multilineTextAlignment(.center)
            
            // Profile Image
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 96, height: 96)
                    .cornerRadius(48)
                    .clipped()
                    .padding(.top, 30)
                    .onTapGesture {
                        if isEditing {
                            showImagePicker = true
                        }
                    }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 96, height: 96)
                    .foregroundColor(.gray)
                    .padding(.top, 30)
                    .onTapGesture {
                        if isEditing {
                            showImagePicker = true
                        }
                    }
            }

            
            // Name
            if isEditing {
                TextField("Enter your name", text: $viewModel.displayName)
                    .font(.system(size: 24, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(viewModel.displayName.isEmpty ? "Name" : viewModel.displayName)
                    .font(.system(size: 24, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                    .padding(.top, 20)
            }
            
            // Edit/Save Button
            Button {
                isEditing.toggle()
                if !isEditing {
                    viewModel.saveUsernameToUserDefaults(username: name)
                    saveProfile()
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("MainBlue"), lineWidth: 1.5)
                        .frame(width: 150, height: 50)
                    
                    HStack {
                        Image(systemName: isEditing ? "checkmark.seal" : "square.and.pencil")
                            .foregroundColor(Color("MainBlue"))
//                            .frame(width: 22, height: 22)
                        Text(isEditing ? "Save" : "Edit Profile")
                            .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("MainBlue"))
                    }
                }
            }
            .padding(.top, 20)
            
            // About Me Section
            VStack(alignment: .leading, spacing: 25) {
                Text("About Me")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if isEditing {
                    TextEditor(text: $aboutMe)
                        .font(.system(size: 16))
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                        )
                } else {
                    Text(aboutMe)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Sign Out Button
            Button{
                viewModel.signOut()
            } label: {
                HStack {
                    Image(systemName: "arrow.backward.square")
                        .font(.system(size: 20))
                    Text("Sign Out")
                        .font(.system(size: 16, weight: .regular))
                }
                .foregroundColor(Color("MainBlue"))
                .padding()
            }
            .padding(.bottom, 30)
        }
        .padding()
        .padding(.top, 50)
        .onAppear {
            if let currentUser = Auth.auth().currentUser {
                viewModel.displayName = currentUser.displayName ?? viewModel.getUsernameFromUserDefaults() ?? "Name"
            } else {
                viewModel.displayName = viewModel.getUsernameFromUserDefaults() ?? "Name"
            }
            print("Current displayName: \(viewModel.displayName)")

        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage)
        }
    }
    
    // MARK: - Helper Functions
    private func selectImage() {
        // Logic for selecting an image (e.g., UIImagePickerController)
        print("Select Image")
    }
    
    private func saveProfile() {
        // Save profile changes to Firebase or CoreData
        print("Profile Saved: \(name), \(aboutMe)")
    }
    
    private func signOut() {
        // Logic for signing out
        print("User signed out")
    }
}

//#Preview {
//    ProfileView()
//}



