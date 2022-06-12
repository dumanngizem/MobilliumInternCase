//
//  RegisterViewController.swift
//  MobilliumInternCase
//
//  Created by Gizem Duman on 11.06.2022.
//

import SwiftUI
import Firebase

struct RegisterViewController: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var retrypassword = ""
    @State var passvisible = false
    @State var rtryvisible = false
    @State var show = false
    @State var StatusMessage = ""
    @State var alert = false
    @State var error = ""


    var body: some View {
        
        ZStack{
            ZStack{
                Color.blue.opacity(0.7)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom,18)
                Circle()
                    .scale(1.4)
                    .foregroundColor(.white)
                    .padding(.bottom,18)

                
                ZStack(alignment: .topTrailing){
                    GeometryReader{_ in
                        
                        VStack{
                            
                            VStack{
                                HStack{
                                    Text("LOGIN")
                                        .foregroundColor(.black.opacity(0.8))
                                        .font(.custom("Palatino",size:40))
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 13.0)
                                        
                                    Spacer(minLength: 0)
                                }
                                .padding(.top,190)
                                .padding([.leading, .trailing], 95)
                                
                                VStack{
                                    HStack(spacing: 20){

                                        Image(systemName: "person.circle")
                                            .foregroundColor(Color.black)
                                        
                                            TextField("Name Surname ", text: self.$name)
                                            
                                        
                                    }
                                    Divider().background(Color.black.opacity(0.5))
                                }
                                
                                .padding(.trailing)
                                .padding(.top, 8)
                                
                                VStack{
                                    HStack(spacing: 15){
                                        
                                        Image(systemName: "envelope.fill")
                                            .foregroundColor(Color.black)
                                        
                                        TextField("Email", text: self.$email)
                                            .keyboardType(.emailAddress)
                                            .autocapitalization(.none)
                                    }
                                    Divider().background(Color.black.opacity(0.5))
                                }
                                
                                .padding(.trailing)
                                .padding(.top, 15)
                                
                                VStack{
                                    
                                    HStack(spacing: 15){
                                        
                                        VStack{
                                            
                                            if self.passvisible{
                                                TextField("Password ", text: self.$password)
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
                                
                                VStack{
                                    
                                    HStack(spacing: 15){
                                        
                                        VStack{
                                            
                                            if self.rtryvisible{
                                                TextField("Retry Password: ", text: self.$retrypassword)
                                            }else{
                                                SecureField("Retry Password", text : self.$retrypassword)
                                            }
                                        }
                                        Button(action: {
                                            
                                            self.rtryvisible.toggle()
                                        }) {
                                
                                            Image(systemName: self.rtryvisible ? "eye.slash.fill" : "eye.fill")
                                                .foregroundColor(Color.black)}

                                    }
                                    
                                    Divider().background(Color.black.opacity(0.5))
                                    VStack{
                                        NavigationView{
                                            
                                            NavigationLink(
                                                destination: LoginViewController(rootIsActive: self.$show), isActive: self.$show){
                                                HStack{
                                                    Spacer(minLength: 0)
                                                    
                                                    Button(action: {
                                                        self.verify()
                                                        handleAction()
                                                    }) {
                                                        
                                                        Text("SignUp")
                                                            .foregroundColor(Color.black.opacity(0.8))
                                                            .fontWeight(.bold)
                                                            .padding(.vertical)
                                                            .padding(.horizontal,25)
                                                            .background(Color.blue.opacity(0.7))
                                                            .clipShape(Capsule())
                                                    }
                                                    .offset(x:-120)
                                                    

                                                }
                                            }.isDetailLink(false)
                                            .navigationBarTitle("Root")
                                                

                                        }
                                    }.hidden()
                                }
                                
                                .padding(.trailing)
                                .padding(.top)
                                
                                
                            
                            }
                            .padding(.bottom)
                            .padding(.horizontal)
                                
                        }
                        
                    }
                }
                
            if self.alert{
                
                errorView(alert: self.$alert, error: self.$error)
            }
                
            }
            
        }
        Text(self.StatusMessage)
            .foregroundColor(Color.white)
       
    }
    
    private func handleAction(){
        createNewAccount()
    }
    private func createNewAccount(){
        Auth.auth().createUser(withEmail: email, password:password){result, err in
            if let err = err{
                print("Failed to create user", err)
                self.StatusMessage = "Failed to create user: \(err)"
                self.alert = true
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.StatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            self.storeUserInformation()
        }
    }
    private func storeUserInformation(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let userData = ["fname": self.name,"email": self.email, "uid": uid]
                Firestore.firestore().collection("users")
                    .document(uid).setData(userData) { err in
                        if let err = err {
                            print(err)
                            self.StatusMessage = "\(err)"
                            return
                        }
            
                        print("Success")
                    }
            
    }
        
  
  
    private func verify(){
        if self.name != "" && self.email != "" && self.password != "" && self.retrypassword != "" && self.password == self.retrypassword
        {
            if self.password == self.retrypassword{
                self.show.toggle()
            }
            
        }else if self.name == "" && self.email != "" && self.password != "" && self.retrypassword != "" && self.password == self.retrypassword{
            
            self.error = "Name Surname cannot be blank."
            self.alert.toggle()
            
        }else if self.name != "" && self.email == "" && self.password != "" && self.retrypassword != "" && self.password == self.retrypassword{
            
            self.error = "Email cannot be blank."
            self.alert.toggle()
        }else if self.name != "" && self.email != "" && self.password == "" && self.retrypassword != "" && self.password == self.retrypassword{
            
            self.error = "Password cannot be blank."
            self.alert.toggle()
        }
        else if self.name != "" && self.email != "" && self.password != "" && self.retrypassword == "" && self.password == self.retrypassword{
            
            self.error = "Retry Password cannot be blank."
            self.alert.toggle()
        }
    }
}



struct RegisterViewController_Previews: PreviewProvider {
    static var previews: some View {
        RegisterViewController()
    }
}

struct errorView : View {
    
    @State var color = Color.blue.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                HStack{
                    
                    Text("Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.top,30)
                .padding(.horizontal, 90)
                
                Text(self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 40)
                
                Button(action: {
                    self.alert.toggle()
                }){
                    
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width-120)
                }
                .background(Color.blue.opacity(0.6))
                .cornerRadius(10)
                .padding(.top, 25)
                .padding(.bottom,20)
            }
            .frame(width: UIScreen.main.bounds.width-70)
            .background(Color.white.opacity(0.7))
            .cornerRadius(15)
            .padding(.top, 80)
            .padding(.horizontal,35)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
