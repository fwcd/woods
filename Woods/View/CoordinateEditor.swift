//
//  CoordinateEditor.swift
//  Woods
//
//  Created by Fredrik on 20.04.22.
//

import SwiftUI

struct CoordinateEditor<CoordinateCardinal>: View
where CoordinateCardinal: SignedCardinal & Hashable & CaseIterable & CustomStringConvertible,
      CoordinateCardinal.AllCases: RandomAccessCollection,
      CoordinateCardinal.AllCases.Index == Int {
    @Binding var degrees: Degrees

    var body: some View {
        EnumPicker(selection: Binding(
            get: { CoordinateCardinal(sign: degrees.sign) },
            set: { degrees.sign = $0.sign }
        ))
    }
}

struct CoordinateEditor_Previews: PreviewProvider {
    @State static var degrees = Degrees.zero
    static var previews: some View {
        CoordinateEditor<LatitudeCardinal>(degrees: $degrees)
    }
}
