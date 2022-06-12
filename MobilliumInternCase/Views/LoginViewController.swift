//
//  LoginViewController.swift
//  MobilliumInternCase
//
//  Created by Gizem Duman on 11.06.2022.
//

import SwiftUI
import Firebase

struct LoginViewController: View {

    @State var name = ""
    @State var password = ""
    @State var passvisible = false
    @State var StatusMessage = ""
    @Binding var rootIsActive : Bool
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.opacity(0.7)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.5)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom,100)
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white)
                    .padding(.bottom, 100)
               
                GeometryReader{_ in
                    Button(action: {
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .padding(.top)
                            .font(.title)
                            .foregroundColor(Color.black)
                    }
                    .padding(.top,50)
                    
                    VStack{
                        VStack{
                            HStack(spacing: 15){
                                
                                Image(systemName: "person.circle")
                                    .foregroundColor(Color.black)
                                
                                TextField("Name Surname ", text: self.$name)

                            }
                            Divider().background(Color.black.opacity(0.5))
                        }
                        .padding(.trailing)
                        .padding(.top, 80)
                        
                        VStack{
                            
                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.passvisible{
                                        TextField("Password: ", text: self.$password)
                                    }else{
                                        SecureField("Password", text : self.$password)
                                    }
                                }
                                Button(action: {
                                    
                                    self.passvisible.toggle()
                                }) {
                        
                                    Image(systemName: self.passvisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.black)}

                            }
                            Divider().background(Color.black.opacity(0.5))
                        }
                        .padding(.trailing)
                        .padding(.top, 20)
                        
                        NavigationLink(destination: MovieListViewController(shouldPopToRootView: self.$rootIsActive)){
                            
                            HStack{
                                Spacer(minLength: 0)
                                
                                Button(action: {
                                }) {
                                    Text("Log in")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .padding(.vertical)
                                        .padding(.horizontal,30)
                                        .background(Color.blue.opacity(0.7))
                                        .clipShape(Capsule())
                                }
                                .offset(x:-60)
                            }
                            
                            .padding(.trailing)
                            .padding(.top, 50)
                                
                        }.isDetailLink(false)
                        .navigationBarTitle("")
                    }
                    .padding()
                    .padding(.bottom, 100)
                    .padding(.horizontal)
                }

            }
        }
        
        Text(self.StatusMessage)
            .foregroundColor(Color.white)
       
    }
    /*
    private func loginUser(){
          Auth.auth().signIn(withEmail: email, password: password){result, err in
              if let err = err{
                  print("Failed to login", err)
                  self.StatusMessage = "Failed to login user: \(err)"
              }
              print("Successfully logged in as user: \(result?.user.uid ?? "")")
              self.StatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
          }
      }*/

}

struct LoginViewController_Previews: PreviewProvider {
    static var previews: some View {
        MovieListViewController()
    }
}
