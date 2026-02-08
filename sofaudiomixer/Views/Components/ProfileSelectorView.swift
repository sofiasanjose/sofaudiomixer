// SoAudioMixer/Views/Components/ProfileSelectorView.swift
import SwiftUI

struct ProfileSelectorView: View {
    @Bindable var audioEngine: AudioEngine

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            SectionHeader(title: "Audio Profile")
                .padding(.bottom, DesignTokens.Spacing.xs)

            ForEach(AudioProfile.allCases, id: \.self) { profile in
                profileRow(for: profile)
            }

            // Profile Description
            Text(audioEngine.settingsManager.currentProfile.description)
                .font(DesignTokens.Typography.caption)
                .foregroundColor(DesignTokens.Colors.textTertiary)
                .lineLimit(1)
                .padding(.horizontal, DesignTokens.Spacing.md)
                .padding(.top, DesignTokens.Spacing.xs)
        }
    }

    private func profileRow(for profile: AudioProfile) -> some View {
        Button(action: {
            audioEngine.settingsManager.setCurrentProfile(profile)
            audioEngine.settingsManager.applyProfile(profile)
        }) {
            HStack(spacing: DesignTokens.Spacing.md) {
                // Radio button indicator
                Image(systemName: audioEngine.settingsManager.currentProfile == profile ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 14, weight: .regular))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(audioEngine.settingsManager.currentProfile == profile ? 
                                   DesignTokens.Colors.interactiveDefault : 
                                   DesignTokens.Colors.textTertiary)
                    .frame(width: DesignTokens.Dimensions.settingsIconWidth, alignment: .center)

                // Profile name
                Text(profile.rawValue)
                    .font(DesignTokens.Typography.rowName)
                    .foregroundStyle(DesignTokens.Colors.textPrimary)

                Spacer()
            }
            .padding(.horizontal, DesignTokens.Spacing.md)
            .padding(.vertical, DesignTokens.Spacing.sm)
            .hoverableRow()
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
