# sofaudiomixer v1.1.0 Release Notes

**Release Date:** February 8, 2026  
**Version:** 1.1.0  
**Status:** Stable

## What's New

### Audio Profiles System
Introducing **Audio Profiles** - a powerful feature that lets you quickly switch between pre-configured audio settings optimized for different use cases:

- **Gaming**: Optimized for immersive gaming
  - System audio: 80% (boost game audio)
  - Apps: 30% (minimize distractions)
  - EQ: Bass boost for immersion
  
- **Streaming**: Perfect for content creators
  - System audio: 70% (balanced)
  - Apps: 50% (moderate)
  - EQ: Vocal clarity for clear commentary
  
- **Music**: For music enthusiasts
  - System audio: 90% (maximize quality)
  - Apps: 50% (balanced)
  - EQ: Flat response (preserve original audio)
  
- **Calls**: Optimized for communication
  - System audio: 60% (reduced volume)
  - Apps: 0% (muted - focus on call)
  - EQ: Vocal clarity for clear speech
  
- **Balanced**: Standard settings
  - System audio: 70% (standard)
  - Apps: 50% (standard)
  - EQ: Flat response

**Features:**
- Quick profile switching from menu bar buttons
- Save custom profiles with your own settings
- One-click profile application to all apps
- Keyboard shortcuts for power users (see below)

### Global Keyboard Shortcuts

New keyboard shortcuts for power users:

- **Cmd+Option+1-5**: Switch to Gaming/Streaming/Music/Calls/Balanced profiles
- **Cmd+Option+M**: Cycle through all profiles
- Works globally - doesn't require menu bar visible
- Perfect for quick context switching

### Bug Fixes

#### Critical Fixes from v1.0.1

1. **App Registration Fix**
   - App now properly registers with macOS
   - Shows in Force Quit dialog (Cmd+Option+Esc)
   - Fixes: "App appears frozen but can't quit" issue
   
2. **Volume Change Stability**
   - Fixed crashes when adjusting volume sliders
   - Added safety checks and volume clamping
   - Prevents invalid volume values (0.0-4.0 range enforced)
   
3. **Settings Change Stability**
   - Fixed crashes when changing app settings
   - Implemented optional chaining for safer state management
   - All settings updates now stable

4. **DMG Installer Improvements**
   - DMG now shows Applications folder
   - Proper drag-and-drop installation support
   - Professional installer layout

## Technical Details

### Changed Files
- **Models**: New `AudioProfile.swift` with complete profile system
- **Views**: New `ProfileSelectorView.swift` for profile UI
- **Utilities**: New `KeyboardShortcutsManager.swift` for hotkey handling
- **Settings**: Extended `SettingsManager.swift` with profile storage
- **App**: Updated `SoAudioMixerApp.swift` to initialize keyboard shortcuts

### Storage
- All profiles saved persistently in ~/Library/Application Support/SoAudioMixer/settings.json
- No settings lost between app restarts
- Easy reset to defaults via Settings → Reset All

### Performance
- Profiles apply instantly (< 100ms)
- No audio interruption when switching profiles
- Memory efficient profile system

## Security and Stability

- **Ad-hoc Code Signing**: Maintain local-only signing (users right-click → Open once)
- **Crash Fixes**: All identified crash scenarios resolved
- **Memory Safety**: No unsafe pointers or force unwrapping in critical paths
- **Audio Safety**: Volume clamping prevents system damage

## Development Notes

Commits in this release:
- `452cc86` - v1.1.0: Critical bug fixes (app registration, volume changes, proper DMG)
- `246d597` - feat: Add audio profile system (Gaming/Streaming/Music/Calls)
- `348ab86` - feat: Add global keyboard shortcuts for profiles

## Credits

**sofaudiomixer** v1.1.0 is built on the excellent **FineTune** codebase by Ronit Singh, with significant enhancements for stability and user experience.

## Distribution

**Download:** [sofaudiomixer-v1.1.0.dmg](https://github.com/sofiasanjose/sofaudiomixer/releases/download/v1.1.0/sofaudiomixer-v1.1.0.dmg)

**Installation:**
1. Mount sofaudiomixer-v1.1.0.dmg
2. Drag sofaudiomixer.app to Applications folder
3. Run sofaudiomixer from Applications
4. Right-click → Open (first launch only, due to ad-hoc signing)

## Known Issues

None identified - please report any issues on GitHub!

## Roadmap

Potential future features being considered:
- Audio routing profiles (route specific apps to different devices)
- Macro recording for complex profile switching scenarios
- MIDI controller support for profile switching
- Cloud sync for saved profiles

## Support

For issues, feature requests, or questions:
- Open an issue on GitHub: https://github.com/sofiasanjose/sofaudiomixer/issues
- Check README.md for detailed usage guide

---

Happy audio mixing!
