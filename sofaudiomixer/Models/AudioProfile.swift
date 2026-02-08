// SoAudioMixer/Models/AudioProfile.swift
import Foundation

enum AudioProfile: String, CaseIterable, Identifiable, Codable {
    case gaming = "Gaming"
    case streaming = "Streaming"
    case music = "Music"
    case calls = "Calls"
    case balanced = "Balanced"
    
    var id: String { rawValue }
    
    // MARK: - Profile Information
    
    var displayName: String {
        switch self {
        case .gaming:
            return "🎮 Gaming"
        case .streaming:
            return "📹 Streaming"
        case .music:
            return "🎵 Music"
        case .calls:
            return "☎️ Calls"
        case .balanced:
            return "⚖️ Balanced"
        }
    }
    
    var description: String {
        switch self {
        case .gaming:
            return "Optimized for gaming - low latency, system audio priority"
        case .streaming:
            return "Optimized for streaming - clear voice, balanced audio"
        case .music:
            return "Optimized for music - rich audio, higher volume"
        case .calls:
            return "Optimized for calls - clear voice, other apps muted"
        case .balanced:
            return "Balanced profile - standard audio settings"
        }
    }
    
    // MARK: - Default Volume Settings
    
    var systemAudioVolume: Float {
        switch self {
        case .gaming: return 0.8      // 80% - boost game audio
        case .streaming: return 0.7   // 70% - standard for streaming
        case .music: return 0.9       // 90% - maximize music
        case .calls: return 0.6       // 60% - reduce overall volume for calls
        case .balanced: return 0.7    // 70% - standard
        }
    }
    
    var defaultNewAppVolume: Float {
        switch self {
        case .gaming: return 0.3      // 30% - minimize game distractions
        case .streaming: return 0.5   // 50% - half volume for other apps
        case .music: return 0.5       // 50% - preserve music quality
        case .calls: return 0.0       // 0% - mute other apps during calls
        case .balanced: return 0.5    // 50% - standard
        }
    }
    
    var maxVolumeBoost: Float {
        switch self {
        case .gaming: return 1.5      // 150% - moderate boost
        case .streaming: return 2.0   // 200% - standard boost
        case .music: return 2.0       // 200% - allow volume flexibility
        case .calls: return 1.5       // 150% - limited boost for safety
        case .balanced: return 2.0    // 200% - standard
        }
    }
    
    // MARK: - Recommended EQ Settings
    
    var recommendedEQPreset: EQPreset {
        switch self {
        case .gaming:
            return .bassBoost  // Enhanced bass for immersion
        case .streaming:
            return .vocalClarity  // Clear voice for commentary
        case .music:
            return .flat  // Preserve original audio
        case .calls:
            return .vocalClarity  // Maximum clarity for calls
        case .balanced:
            return .flat  // Standard flat response
        }
    }
    
    // MARK: - Profile Presets (for future app list configuration)
    
    struct PresetAppVolumes {
        let appVolumes: [String: Float]  // bundleID → volume
    }
    
    /// Get recommended app-specific volume settings
    func getPresetAppVolumes() -> [String: Float] {
        switch self {
        case .gaming:
            return [
                "com.blizzard.d2": 0.8,      // Diablo
                "com.activision.CallOfDuty": 0.8,
                "com.epicgames.launcher": 0.7,
            ]
        case .streaming:
            return [
                "com.apple.systempreferences": 0.2,  // System sounds quiet during stream
                "com.spotify.client": 0.7,
                "com.dcpokie.loopback": 0.5,  // Audio routing apps
            ]
        case .music:
            return [
                "com.spotify.client": 0.95,   // Music apps at max
                "com.apple.Music": 0.95,
                "com.sublimetext": 0.2,      // Reduce notifications from other apps
            ]
        case .calls:
            return [
                "com.apple.FaceTime": 0.9,    // Call app at max
                "com.apple.Skype": 0.9,
                "com.discord.mainapp": 0.9,
                // Most other apps should be at 0% (muted)
            ]
        case .balanced:
            return [:]  // Use default settings
        }
    }
}

// MARK: - Profile Storage Model

struct SavedAudioProfile: Codable, Equatable, Identifiable {
    var id: String { name }
    let name: String
    let baseProfile: AudioProfile
    var customSystemAudioVolume: Float?  // nil = use profile default
    var customDefaultNewAppVolume: Float?
    var customMaxVolumeBoost: Float?
    var customAppVolumes: [String: Float] = [:]
    var createdDate: Date = Date()
    var lastModifiedDate: Date = Date()
    
    init(name: String, baseProfile: AudioProfile) {
        self.name = name
        self.baseProfile = baseProfile
    }
    
    /// Get the effective system audio volume (custom or default)
    func getEffectiveSystemAudioVolume() -> Float {
        customSystemAudioVolume ?? baseProfile.systemAudioVolume
    }
    
    /// Get the effective new app volume (custom or default)
    func getEffectiveDefaultNewAppVolume() -> Float {
        customDefaultNewAppVolume ?? baseProfile.defaultNewAppVolume
    }
    
    /// Get the effective max volume boost (custom or default)
    func getEffectiveMaxVolumeBoost() -> Float {
        customMaxVolumeBoost ?? baseProfile.maxVolumeBoost
    }
}
