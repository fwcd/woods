//
//  AccountLoginStateView.swift
//  Woods
//
//  Created by Fredrik on 28.02.23.
//

import SwiftUI

struct AccountLoginStateView: View {
    let state: AccountLogin.State
    
    private var color: Color {
        switch state {
        case .connecting: return .yellow
        case .connected: return .green
        case .failed: return .red
        case .loggedOut: return .gray
        }
    }
    
    var body: some View {
        Image(systemName: "circlebadge.fill")
            .foregroundColor(color)
    }
}

struct AccountLoginStateView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AccountLoginStateView(state: .loggedOut)
            AccountLoginStateView(state: .connecting)
            AccountLoginStateView(state: .connected(MockConnector()))
            AccountLoginStateView(state: .failed)
        }
    }
}
