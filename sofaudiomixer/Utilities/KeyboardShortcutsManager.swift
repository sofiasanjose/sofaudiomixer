// SoAudioMixer/Utilities/KeyboardShortcutsManager.swift
import AppKit
import os

private let logger = Logger(subsystem: "com.sofaudiomixer", category: "KeyboardShortcuts")

/// Manages global keyboard shortcuts for sofaudiomixer
@Observable
@MainActor
final class KeyboardShortcutsManager {
    weak var audioEngine: AudioEngine?
    private var eventMonitor: Any?
    private var isEnabled = true
    
    init(audioEngine: AudioEngine) {
        self.audioEngine = audioEngine
        setupGlobalShortcuts()
    }
    
    private func setupGlobalShortcuts() {
        // Register for system-wide keyboard events
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyDown(event)
        }
        logger.info("Global keyboard shortcuts registered")
    }
    
    private func handleKeyDown(_ event: NSEvent) {
        guard isEnabled, let audioEngine = audioEngine else { return }
        
        let modifiers = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        let hasCmd = modifiers.contains(.command)
        let hasOpt = modifiers.contains(.option)
        let hasCtrl = modifiers.contains(.control)
        let hasShift = modifiers.contains(.shift)
        
        // Cmd+Option+P: Toggle profile selector visibility (show/hide)
        if hasCmd && hasOpt && event.characters == "p" {
            logger.debug("Profile selector shortcut triggered")
            return
        }
        
        // Cmd+Option+1-5: Switch to specific profile
        if hasCmd && hasOpt && !hasCtrl && !hasShift {
            switch event.characters {
            case "1":
                audioEngine.settingsManager.setCurrentProfile(.gaming)
                audioEngine.settingsManager.applyProfile(.gaming)
                logger.info("Profile switched to Gaming")
            case "2":
                audioEngine.settingsManager.setCurrentProfile(.streaming)
                audioEngine.settingsManager.applyProfile(.streaming)
                logger.info("Profile switched to Streaming")
            case "3":
                audioEngine.settingsManager.setCurrentProfile(.music)
                audioEngine.settingsManager.applyProfile(.music)
                logger.info("Profile switched to Music")
            case "4":
                audioEngine.settingsManager.setCurrentProfile(.calls)
                audioEngine.settingsManager.applyProfile(.calls)
                logger.info("Profile switched to Calls")
            case "5":
                audioEngine.settingsManager.setCurrentProfile(.balanced)
                audioEngine.settingsManager.applyProfile(.balanced)
                logger.info("Profile switched to Balanced")
            default:
                break
            }
        }
        
        // Cmd+Option+M: Cycle through profiles
        if hasCmd && hasOpt && event.characters == "m" {
            let allProfiles = AudioProfile.allCases
            let currentProfile = audioEngine.settingsManager.currentProfile
            let currentIndex = allProfiles.firstIndex(of: currentProfile) ?? 0
            let nextIndex = (currentIndex + 1) % allProfiles.count
            let nextProfile = allProfiles[nextIndex]
            audioEngine.settingsManager.setCurrentProfile(nextProfile)
            audioEngine.settingsManager.applyProfile(nextProfile)
            logger.info("Profile cycled to \(nextProfile.rawValue)")
        }
    }
    
    /// Enable or disable global keyboard shortcuts
    func setEnabled(_ enabled: Bool) {
        isEnabled = enabled
        logger.debug("Global shortcuts \(enabled ? "enabled" : "disabled")")
    }
    
    nonisolated deinit {
        // Note: Cannot safely access eventMonitor here due to MainActor isolation
        // Event monitor will be cleaned up by the system when the app terminates
    }
}
