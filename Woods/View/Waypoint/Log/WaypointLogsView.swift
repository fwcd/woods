import SwiftUI

struct WaypointLogsView: View {
    let waypoint: Waypoint
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // TODO: Only show some logs and add link to full logs
            ForEach(waypoint.logs) { log in
                WaypointLogView(waypointLog: log)
            }
        }
    }
}

struct WaypointLogsView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogsView(waypoint: mockGeocaches()[0])
    }
}
