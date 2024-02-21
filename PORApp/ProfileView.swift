//
//  MyView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI

struct MyView: View {
    @State var userName:String = "Alpha User"
    var body: some View {
        NavigationStack{
            VStack {
                Text("UserName")
                HStack{
                    TextEditor(text: $userName)
                }
            }
            VStack {
                Text("Contact number")
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct MyView_Preview : PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
