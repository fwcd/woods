//
//  LoginView.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @Binding var credentials: Credentials
    
    var body: some View {
        VStack {
            TextField("Username", text: $credentials.username)
            SecureField("Password", text: $credentials.password)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var credentials = Credentials()
    static var previews: some View {
        LoginView(credentials: $credentials)
    }
}
