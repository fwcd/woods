//
//  CoordinateEditor.swift
//  Woods
//
//  Created by Fredrik on 20.04.22.
//

import SwiftUI

private let degreesFormatter: NumberFormatter = NumberFormatter()
private let minutesFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumIntegerDigits = 2
    f.minimumFractionDigits = 3
    return f
}()

struct CoordinateEditor<CoordinateCardinal>: View
where CoordinateCardinal: SignedCardinal & Hashable & CaseIterable & CustomStringConvertible,
      CoordinateCardinal.AllCases: RandomAccessCollection,
      CoordinateCardinal.AllCases.Index == Int {
    @Binding var degrees: Degrees

    // TODO: More formats beside decimal minutes (decimal degrees, DMS, ...)?
    
    var body: some View {
        HStack {
            EnumPicker(selection: Binding(
                get: { CoordinateCardinal(sign: degrees.sign) },
                set: { degrees.sign = $0.sign }
            ))
            .pickerStyle(.menu)
            TextField("0", value: $degrees.magnitude.dm.degrees, formatter: degreesFormatter)
                .frame(width: 50)
                #if !os(macOS)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                #endif
            Text("°")
            TextField("00.000", value: $degrees.magnitude.dm.minutes, formatter: minutesFormatter)
                #if !os(macOS)
                .keyboardType(.decimalPad)
                #endif
        }
    }
}

struct CoordinateEditor_Previews: PreviewProvider {
    @State static var degrees = Degrees.zero
    static var previews: some View {
        CoordinateEditor<LatitudeCardinal>(degrees: $degrees)
    }
}
