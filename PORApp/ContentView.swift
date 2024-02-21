//
//  ContentView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = BiometricModel()
    @State var showAppPage : Bool = false
    var body: some View {
        
        VStack {
            
            Text("More Echo App")
                .font(.title)
            
            Text("Click the button below to Face ID Login")
                .padding()
            
            if model.isError == true {
                Text("\(model.errorMessage)")
            }
            Button(action: {
                model.evaluatePolicy()
            }, label: {
                Image(systemName: "faceid")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }).padding()
        }
        //show the main view of the app
        .fullScreenCover(isPresented: $showAppPage, content: {
            MainView()
        })
        .padding()
        .onAppear {
            model.checkPolicy()
        }
        .onChange(of: model.isAuthenicated) {
            newValue in
            showAppPage = model.isAuthenicated
        }
    }
}

struct ContentView_Preview : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
