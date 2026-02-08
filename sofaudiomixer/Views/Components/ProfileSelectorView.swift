// SoAudioMixer/Views/Components/ProfileSelectorView.swift
import SwiftUI

struct ProfileSelectorView: View {
    @Bindable var audioEngine: AudioEngine
    @State private var showingProfileMenu = false
    @State private var hoveredProfile: AudioProfile?

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            // Profile Header
            HStack {
                Label("Audio Profile", systemImage: "waveform.circle")
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                Text(audioEngine.settingsManager.currentProfile.rawValue)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, DesignTokens.Spacing.sm)
            .padding(.vertical, DesignTokens.Spacing.xs)

            // Quick Profile Buttons (2x3 grid)
            VStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(Array(AudioProfile.allCases.prefix(6).enumerated()), id: \.offset) { index, profile in
                    if index % 2 == 0 {
                        HStack(spacing: DesignTokens.Spacing.xs) {
                            profileButton(for: profile)
                            if index + 1 < min(6, AudioProfile.allCases.count) {
                                profileButton(for: AudioProfile.allCases[index + 1])
                            }
                            Spacer()
                        }
                    }
                }
            }
            .padding(.horizontal, DesignTokens.Spacing.sm)

            // Profile Info Text
            infoText
                .font(.system(.caption2, design: .rounded))
                .foregroundColor(.secondary)
                .padding(.horizontal, DesignTokens.Spacing.sm)
                .padding(.vertical, DesignTokens.Spacing.xs)
        }
        .padding(DesignTokens.Spacing.md)
        .background(Color.black.opacity(0.2))
        .cornerRadius(DesignTokens.Dimensions.rowRadius)
    }

    private func profileButton(for profile: AudioProfile) -> some View {
        Button(action: {
            audioEngine.settingsManager.setCurrentProfile(profile)
            audioEngine.settingsManager.applyProfile(profile)
        }) {
            VStack(spacing: 4) {
                Text(String(profile.displayName.prefix(1)))
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                Text(profile.rawValue)
                    .font(.system(.caption2, design: .rounded))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
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

    private var infoText: some View {
        HStack(spacing: 4) {
            Image(systemName: "info.circle")
                .font(.caption2)
            Text(audioEngine.settingsManager.currentProfile.description)
                .lineLimit(2)
        }
    }
}

// MARK: - Preview

#Preview("Profile Selector View") {
    ProfileSelectorView(audioEngine: AudioEngine())
        .preferredColorScheme(.dark)
        .frame(width: 300)
}
