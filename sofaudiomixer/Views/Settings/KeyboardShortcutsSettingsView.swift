// SoAudioMixer/Views/Settings/KeyboardShortcutsSettingsView.swift
import SwiftUI

/// Settings view for managing keyboard shortcuts
struct KeyboardShortcutsSettingsView: View {
    @State private var selectedShortcut: KeyboardShortcutType?
    @State private var isRecording = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            SectionHeader(title: "Keyboard Shortcuts")
                .padding(.bottom, DesignTokens.Spacing.xs)
            
            // Current shortcuts list
            VStack(spacing: DesignTokens.Spacing.xs) {
                shortcutRow(
                    title: "Gaming Profile",
                    shortcut: "Cmd + Option + 1",
                    description: "Switch to Gaming profile"
                )
                
                shortcutRow(
                    title: "Streaming Profile",
                    shortcut: "Cmd + Option + 2",
                    description: "Switch to Streaming profile"
                )
                
                shortcutRow(
                    title: "Music Profile",
                    shortcut: "Cmd + Option + 3",
                    description: "Switch to Music profile"
                )
                
                shortcutRow(
                    title: "Calls Profile",
                    shortcut: "Cmd + Option + 4",
                    description: "Switch to Calls profile"
                )
                
                shortcutRow(
                    title: "Balanced Profile",
                    shortcut: "Cmd + Option + 5",
                    description: "Switch to Balanced profile"
                )
                
                Divider()
                    .padding(.vertical, DesignTokens.Spacing.xs)
                
                shortcutRow(
                    title: "Cycle Profiles",
                    shortcut: "Cmd + Option + M",
                    description: "Cycle through all profiles"
                )
            }
            
            // Info section
            HStack(spacing: DesignTokens.Spacing.sm) {
                Image(systemName: "info.circle")
                    .foregroundStyle(DesignTokens.Colors.mutedIndicator)
                    .font(.system(size: 14))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Global Hotkeys")
                        .font(DesignTokens.Typography.rowName)
                        .foregroundStyle(DesignTokens.Colors.textPrimary)
                    Text("Works when sofaudiomixer is minimized or in background")
                        .font(DesignTokens.Typography.caption)
                        .foregroundStyle(DesignTokens.Colors.textTertiary)
                }
                
                Spacer()
            }
            .padding(DesignTokens.Spacing.sm)
            .background(Color.white.opacity(0.05))
            .cornerRadius(DesignTokens.Dimensions.rowRadius)
        }
    }
    
    private func shortcutRow(
        title: String,
        shortcut: String,
        description: String
    ) -> some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: "keyboard")
                .foregroundStyle(DesignTokens.Colors.accentPrimary)
                .frame(width: DesignTokens.Dimensions.settingsIconWidth)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(DesignTokens.Typography.rowName)
                    .foregroundStyle(DesignTokens.Colors.textPrimary)
                Text(description)
                    .font(DesignTokens.Typography.caption)
                    .foregroundStyle(DesignTokens.Colors.textTertiary)
            }
            
            Spacer()
            
            Text(shortcut)
                .font(.system(.caption, design: .monospaced))
                .foregroundStyle(DesignTokens.Colors.accentPrimary)
                .padding(.horizontal, DesignTokens.Spacing.sm)
                .padding(.vertical, 4)
                .background(Color.white.opacity(0.1))
                .cornerRadius(4)
        }
        .padding(.vertical, DesignTokens.Spacing.xs)
    }
}

// MARK: - Keyboard Shortcut Types

enum KeyboardShortcutType: String, CaseIterable, Identifiable {
    case gaming = "Cmd + Option + 1"
    case streaming = "Cmd + Option + 2"
    case music = "Cmd + Option + 3"
    case calls = "Cmd + Option + 4"
    case balanced = "Cmd + Option + 5"
    case cycle = "Cmd + Option + M"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .gaming: return "Gaming Profile"
        case .streaming: return "Streaming Profile"
        case .music: return "Music Profile"
        case .calls: return "Calls Profile"
        case .balanced: return "Balanced Profile"
        case .cycle: return "Cycle Profiles"
        }
    }
}

// MARK: - Previews

#Preview {
    KeyboardShortcutsSettingsView()
        .padding()
}
