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
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var isEditing: Bool = false
    @State private var name: String = ""
    @State private var aboutMe: String = ""
    @State private var profileImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var isExpanded: Bool = false
    private let maxCharacterLimit = 100
    
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
                TextField("Enter your name", text: $name)
                    .font(.system(size: 24, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(name.isEmpty ? (viewModel.displayName.isEmpty ? "Name" : viewModel.displayName) : name)
                    .font(.system(size: 24, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                    .padding(.top, 20)
            }
            
            // Edit/Save Button
            Button {
                isEditing.toggle()
                if !isEditing {
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
                    VStack(alignment: .leading, spacing: 8) {
                                Text(isExpanded || aboutMe.count <= maxCharacterLimit
                                     ? aboutMe
                                     : "\(aboutMe.prefix(maxCharacterLimit))...")
                                .font(.custom(EventHubFont.body1.name, size: 16))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                
                                if aboutMe.count > maxCharacterLimit {
                                    Button(action: {
                                        isExpanded.toggle()
                                    }) {
                                        Text(isExpanded ? "Read Less" : "Read More")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.mainBlue)
                                            .padding(.top, 5)
                                    }
                                }
                            }
                    
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Sign Out Button
            Button{
               viewModel.signOut()
                navigationManager.currentDestination = .signIn
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
            loadProfile()
            loadProfileImage()
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
    
    private func saveProfileImage() {
        if let profileImage = profileImage, let imageData = profileImage.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.set(imageData, forKey: "profileImage")
            print("Profile image saved.")
        }
    }

    private func loadProfileImage() {
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let savedImage = UIImage(data: imageData) {
            self.profileImage = savedImage
            print("Profile image loaded.")
        }
    }
    
    private func saveProfile() {
        // Save profile changes to Firebase or CoreData
        if !name.isEmpty {
               viewModel.updateUsernameFromUserDefaults(username: name)
           }
           saveProfileImage()
            if !aboutMe.isEmpty {
               viewModel.saveAboutMe(aboutMe: aboutMe)
           }
           print("Profile saved: \(name), \(aboutMe)")
    }
    
    private func signOut() {
        // Logic for signing out
        print("User signed out")
    }
    
    
    private func loadProfile() {
        if let username = viewModel.getUsernameFromUserDefaults(), !username.isEmpty {
            name = username
        } else {
            name = viewModel.displayName.isEmpty ? "Name" : viewModel.displayName
        }
        
        if let savedAboutMe = viewModel.getAboutMe(), !savedAboutMe.isEmpty {
            aboutMe = savedAboutMe
        } else {
            aboutMe = "Tell us about yourself."
        }
        
        print("Loaded username: \(name), About Me: \(aboutMe)")
    }
}

//#Preview {
//    ProfileView()
//}



