// SoAudioMixer/Views/Components/ProfileSelectorView.swift
import SwiftUI

struct ProfileSelectorView: View {
    @Bindable var audioEngine: AudioEngine
    @State private var showingProfileMenu = false
    @State private var hoveredProfile: AudioProfile?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Profile Header
            HStack {
                Label("Audio Profile", systemImage: "waveform.circle")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                Text(audioEngine.settingsManager.currentProfile.rawValue)
                    .font(.system(.caption2, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, DesignTokens.Spacing.sm)
            .padding(.vertical, 6)

            // Quick Profile Buttons (single row)
            HStack(spacing: 4) {
                ForEach(AudioProfile.allCases, id: \.self) { profile in
                    profileButton(for: profile)
                }
            }
            .padding(.horizontal, DesignTokens.Spacing.xs)
            .padding(.vertical, 6)
        }
        .padding(DesignTokens.Spacing.sm)
        .background(Color.black.opacity(0.2))
        .cornerRadius(DesignTokens.Dimensions.rowRadius)
    }

    private func profileButton(for profile: AudioProfile) -> some View {
        Button(action: {
            audioEngine.settingsManager.setCurrentProfile(profile)
            audioEngine.settingsManager.applyProfile(profile)
        }) {
            Text(profile.rawValue)
                .font(.system(.caption2, design: .rounded))
                .lineLimit(1)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: DesignTokens.Dimensions.buttonRadius)
                        .fill(audioEngine.settingsManager.currentProfile == profile ?
                              Color.accentColor.opacity(0.8) :
                              Color.white.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: DesignTokens.Dimensions.buttonRadius)
                        .stroke(
                            audioEngine.settingsManager.currentProfile == profile ?
                            Color.accentColor :
                            Color.white.opacity(0.2),
                            lineWidth: 1
                        )
                )
                .foregroundColor(.white)
        }
        .buttonStyle(.plain)
    }

}

// MARK: - Preview

#Preview("Profile Selector View") {
    ProfileSelectorView(audioEngine: AudioEngine())
        .preferredColorScheme(.dark)
        .frame(width: 300)
}
