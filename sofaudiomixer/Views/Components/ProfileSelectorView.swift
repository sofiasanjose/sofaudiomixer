// SoAudioMixer/Views/Components/ProfileSelectorView.swift
import SwiftUI

struct ProfileSelectorView: View {
    @Bindable var audioEngine: AudioEngine

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            // Profile Header
            HStack {
                Label("Audio Profile", systemImage: "waveform.circle")
                    .font(DesignTokens.Typography.rowName)
                    .foregroundColor(DesignTokens.Colors.textPrimary)
                Spacer()
                Text(audioEngine.settingsManager.currentProfile.rawValue)
                    .font(.system(.caption2, design: .default))
                    .foregroundColor(DesignTokens.Colors.textSecondary)
            }

            // Quick Profile Buttons (single row)
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(AudioProfile.allCases, id: \.self) { profile in
                    profileButton(for: profile)
                }
            }
            .frame(height: 28)

            // Profile Description
            Text(audioEngine.settingsManager.currentProfile.description)
                .font(.system(.caption2, design: .default))
                .foregroundColor(DesignTokens.Colors.textTertiary)
                .lineLimit(1)
        }
    }

    private func profileButton(for profile: AudioProfile) -> some View {
        Button(action: {
            audioEngine.settingsManager.setCurrentProfile(profile)
            audioEngine.settingsManager.applyProfile(profile)
        }) {
            Text(profile.rawValue)
                .font(.system(.caption2, design: .default))
                .lineLimit(1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: DesignTokens.Dimensions.buttonRadius)
                        .fill(audioEngine.settingsManager.currentProfile == profile ?
                              Color.accentColor.opacity(0.7) :
                              Color.white.opacity(0.08))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: DesignTokens.Dimensions.buttonRadius)
                        .stroke(
                            audioEngine.settingsManager.currentProfile == profile ?
                            Color.accentColor.opacity(0.8) :
                            Color.clear,
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
