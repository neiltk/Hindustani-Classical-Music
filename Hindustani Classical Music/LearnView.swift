import SwiftUI

// A simple structure to define what makes up a "Recording"
struct Recording: Identifiable {
    let id = UUID()
    let title: String
    let raag: String
    let topic: String
    let praharIcon: String
}

struct LearnView: View {
    // 1. THE TOPICS LIST
    let topics = ["All", "Intro", "Alankars", "Palta", "Sargam Geet", "Bandish", "Tarana", "Lakshangeet", "Swar Vistar"]
    
    @State private var selectedTopic = "All"
    
    // 2. OUR DUMMY DATABASE OF RECORDINGS
    let allRecordings = [
        Recording(title: "Basic Ascend/Descend", raag: "Bhairav", topic: "Alankars", praharIcon: "🌅"),
        Recording(title: "Teental Composition", raag: "Yaman", topic: "Bandish", praharIcon: "🌇"),
        Recording(title: "Understanding the Vadi", raag: "Bhairav", topic: "Intro", praharIcon: "🌅"),
        Recording(title: "Fast Tempo Drut", raag: "Bageshree", topic: "Tarana", praharIcon: "🌙"),
        Recording(title: "Sa Re Ga Ma Practice", raag: "Yaman", topic: "Sargam Geet", praharIcon: "🌇")
    ]
    
    // 3. THE FILTER LOGIC
    var filteredRecordings: [Recording] {
        if selectedTopic == "All" {
            return allRecordings
        } else {
            return allRecordings.filter { $0.topic == selectedTopic }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                
                // --- THE SMART PRAHAR HEADER ---
                VStack(alignment: .leading, spacing: 5) {
                    Text("2nd Prahar • 9 AM - 12 PM")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .textCase(.uppercase)
                    
                    Text("Time for Asavari")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.orange.opacity(0.1))
                
                // --- THE TOPIC FILTER CAROUSEL ---
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(topics, id: \.self) { topic in
                            Button(action: {
                                // When tapped, change the selected topic!
                                selectedTopic = topic
                            }) {
                                Text(topic)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedTopic == topic ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(selectedTopic == topic ? .white : .black)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding()
                }
                
                // --- THE RECORDINGS LIST ---
                List(filteredRecordings) { recording in
                    HStack(spacing: 15) {
                        Text(recording.praharIcon)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recording.title)
                                .font(.headline)
                            Text("\(recording.raag) • \(recording.topic)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "play.circle")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Library")
        }
    }
}

#Preview {
    LearnView()
}
