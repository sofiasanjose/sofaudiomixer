// SoAudioMixer/Views/Components/ProfileSelectorView.swift
import SwiftUI

struct ProfileSelectorView: View {
    @Bindable var audioEngine: AudioEngine

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            SectionHeader(title: "Audio Profile")
                .padding(.bottom, DesignTokens.Spacing.xs)

            // Compact profile grid
            VStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(AudioProfile.allCases.chunked(into: 2), id: \.self) { row in
                    HStack(spacing: DesignTokens.Spacing.xs) {
                        ForEach(row, id: \.self) { profile in
                            profileButton(for: profile)
                        }
                        Spacer()
                    }
                }
            }

            // Profile Description
            Text(audioEngine.settingsManager.currentProfile.description)
                .font(DesignTokens.Typography.caption)
                .foregroundColor(DesignTokens.Colors.textTertiary)
                .lineLimit(1)
                .padding(.top, DesignTokens.Spacing.xs)
        }
    }

    private func profileButton(for profile: AudioProfile) -> some View {
        Button(action: {
            audioEngine.settingsManager.setCurrentProfile(profile)
            audioEngine.settingsManager.applyProfile(profile)
        }) {
            HStack(spacing: 6) {
                Image(systemName: audioEngine.settingsManager.currentProfile == profile ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 12, weight: .regular))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(audioEngine.settingsManager.currentProfile == profile ? 
                                   DesignTokens.Colors.interactiveDefault : 
                                   DesignTokens.Colors.textTertiary)

                Text(profile.rawValue)
                    .font(DesignTokens.Typography.rowName)
                    .foregroundStyle(DesignTokens.Colors.textPrimary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, DesignTokens.Spacing.sm)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: DesignTokens.Dimensions.buttonRadius)
                    .fill(Color.white.opacity(audioEngine.settingsManager.currentProfile == profile ? 0.1 : 0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.Dimensions.buttonRadius)
                    .strokeBorder(
                        audioEngine.settingsManager.currentProfile == profile ?
                        DesignTokens.Colors.interactiveDefault.opacity(0.3) :
                        Color.white.opacity(0.1),
                        lineWidth: 0.5
                    )
            )
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

// MARK: - Helper for Array chunking

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
