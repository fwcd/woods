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
    @State var accountType: AccountType = .geocachingCom // TODO
    
    var body: some View {
        Form {
            Section(header: Text("Account Type")) {
                EnumPicker(selection: $accountType, label: Text("Account Type"))
            }
            Section(header: Text("Credentials")) {
                TextField("Username", text: $credentials.username)
                SecureField("Password", text: $credentials.password)
            }
            Button(action: {}) {
                Text("Log in")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var credentials = Credentials()
    static var previews: some View {
        LoginView(credentials: $credentials)
    }
}
