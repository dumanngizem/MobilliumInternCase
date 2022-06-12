//
//  MovieListViewController.swift
//  MobilliumInternCase
//
//  Created by Gizem Duman on 11.06.2022.
//

import SwiftUI
import Firebase

struct MovieListViewController: View {
    
    @Binding var shouldPopToRootView : Bool

    var body: some View {
        NavigationView{
            List(["1. PK","2.Bohemian Rhapsody","3. Ayla","4. The Old Guard","5. Harry Potter","6. Bird Box", "7. Joker","8. 3 Idiots","9. Lucy", "10. Hababam Sınıfı"],id: \.self){number in
                Text("\(number)")
                    .frame(width: 200, height: 30)
            }.navigationTitle("Gizem's Top 10")
            
            VStack{
                Button(action: {self.shouldPopToRootView = false}){
                    Text("")
                }
            }.navigationTitle("")
            
        }
        
    }
}

struct MovieListViewController_Previews: PreviewProvider {
    static var previews: some View {
        MovieListViewController()
    }
}
