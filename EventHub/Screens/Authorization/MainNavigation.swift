//
//  MainNavigation.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/20/24.
//

//import SwiftUI
//
//struct MainNavigation: View {
//    @StateObject private var navigationManager = NavigationManager()
//    @ObservedObject var Model: AuthenticationModel
//    var body: some View {
//        NavigationView {
//            Group {
//                switch navigationManager.currentDestination {
//                case .signIn:
//                    SignIn(Model: AuthenticationModel())
//                        .environmentObject(navigationManager)
//                case .signUp:
//                    SignUp(Model: AuthenticationModel())
//                        .environmentObject(navigationManager)
//                case .contentView:
//                    ContentView()
//                        .environmentObject(navigationManager)
//                case .resetPassword:
//                    ResetPassword(Model: AuthenticationModel())
//                        .environmentObject(navigationManager)
//                case .changePassword:
//                    ChangePassword(Model: AuthenticationModel())
//                        .environmentObject(navigationManager)
//                }
//            }
//            .navigationViewStyle(StackNavigationViewStyle())
//        }
//    }
//}
