<h1 align="center">🥭 SoAudioMixer</h1>

<p align="center">
  <strong>Per-app volume control for macOS</strong>
</p>

<p align="center">
  <em>A modern audio mixer built with SwiftUI | by Sofia Claudia Bonoan</em>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-GPLv3-blue.svg" alt="License: GPL v3"></a>
  <a href="https://www.apple.com/macos/"><img src="https://img.shields.io/badge/macOS-14%2B-brightgreen" alt="macOS 14+"></a>
</p>

<p align="center">
  Control the volume of individual applications independently.<br>
  Free, open-source, and beautiful.
</p>

---

## 💡 About SoAudioMixer

**SoAudioMixer** is a sleek, native macOS application designed to give you granular control over individual application volumes. No more adjusting your system volume and affecting everything at once!

Built with SwiftUI and CoreAudio, this app provides an intuitive menu bar interface to manage audio routing, volume levels, and EQ settings for each app on your Mac.

## ✨ Features

- **Per-app volume control** — Independent volume sliders for each application
- **Mute individual apps** — Quick mute buttons for each audio source
- **10-band EQ** — 20 audio presets across multiple categories
- **Multi-device output** — Route different apps to different speakers
- **Input monitoring** — Manage microphone levels independently
- **Volume boost** — Amplify audio up to 400%
- **Menu bar interface** — Lightweight, always-accessible control
- **Smart pinning** — Pre-configure apps before they play
- **URL scheme support** — Cross-app scripting for automation
- **Beautiful glass-morphism UI** — Modern design with smooth animations

## 🚀 Quick Start

1. Clone this repository
2. Open `sofaudiomixer.xcodeproj` in Xcode
3. Build and run (⌘R)
4. Grant audio permissions when prompted
5. Start any audio application to see it appear in the mixer

## 🎯 System Requirements

- **macOS 14.0+** (Sonoma or later)
- Audio capture permission (prompted on first launch)

## ❓ FAQ

<details>
<summary><strong>Why isn't my app showing up?</strong></summary>
Only apps actively playing audio appear in the mixer. Start playing audio in your app first.
</details>

<details>
<summary><strong>How do I grant audio permissions?</strong></summary>
SoAudioMixer will request audio capture permission on first launch. Click "Allow" in the system dialog.
</details>

<details>
<summary><strong>Can I control microphone input?</strong></summary>
Yes! Switch to the "Input" tab in the mixer to monitor and adjust microphone levels.
</details>

<details>
<summary><strong>Does this work with Bluetooth speakers?</strong></summary>
Absolutely. SoAudioMixer works with all macOS audio devices, including Bluetooth speakers.
</details>

## 🛠️ Building from Source

```bash
git clone https://github.com/yourusername/sofaudiomixer.git
cd sofaudiomixer
open sofaudiomixer.xcodeproj
```

Press **Cmd+R** to build and run.

## 📦 Distribution for Public Use

### For Users (Download & Install)

**Coming Soon:** Pre-built releases will be available on the [GitHub Releases](https://github.com/sofiasanjose/sofaudiomixer/releases) page.

Once available:
1. Download the latest `.dmg` file
2. Open the DMG and drag SoAudioMixer to Applications
3. Launch from Applications folder
4. Grant audio permissions when prompted

### For Developers (Building for Distribution)

To make SoAudioMixer available for public download, you need to properly sign and notarize the app:

#### Prerequisites

1. **Apple Developer Program** ($99/year)
   - Enroll at [developer.apple.com](https://developer.apple.com/programs/)
   - Required for code signing certificates and notarization

2. **Developer ID Certificate**
   - Log into [developer.apple.com/account](https://developer.apple.com/account)
   - Go to "Certificates, Identifiers & Profiles"
   - Create a new "Developer ID Application" certificate
   - Download and install in Keychain Access

#### Build & Sign Process

**1. Update Code Signing in Xcode**
```
1. Open sofaudiomixer.xcodeproj
2. Select project in navigator → sofaudiomixer target
3. Go to "Signing & Capabilities" tab
4. Uncheck "Automatically manage signing"
5. Select your "Developer ID Application" certificate
6. Set Provisioning Profile to "None"
```

**2. Build Release Version**
```bash
xcodebuild -project sofaudiomixer.xcodeproj \
  -scheme sofaudiomixer \
  -configuration Release \
  -derivedDataPath build \
  CODE_SIGN_IDENTITY="Developer ID Application: Your Name (TEAMID)" \
  clean build
```

**3. Create DMG Installer**
```bash
# Use the included build script
./scripts/build-dmg.sh
```

Or manually with `create-dmg`:
```bash
brew install create-dmg

create-dmg \
  --volname "SoAudioMixer" \
  --window-pos 200 120 \
  --window-size 600 400 \
  --icon-size 100 \
  --app-drop-link 450 185 \
  "SoAudioMixer.dmg" \
  "build/Build/Products/Release/sofaudiomixer.app"
```

**4. Notarize the App**

```bash
# Store credentials (one-time setup)
xcrun notarytool store-credentials "AC_PASSWORD" \
  --apple-id "your@email.com" \
  --team-id "TEAMID" \
  --password "app-specific-password"

# Submit for notarization
xcrun notarytool submit SoAudioMixer.dmg \
  --keychain-profile "AC_PASSWORD" \
  --wait

# Staple notarization ticket
xcrun stapler staple SoAudioMixer.dmg
```

**5. Verify Notarization**
```bash
spctl --assess --type open --context context:primary-signature -v SoAudioMixer.dmg
```

Should show: `SoAudioMixer.dmg: accepted`

**6. Publish Release**

1. Create a new release on GitHub
2. Upload the notarized `SoAudioMixer.dmg`
3. Add release notes with features and changes
4. Tag the release (e.g., `v1.0.0`)

#### Alternative: Distribution via GitHub Only

If you don't want to pay for Apple Developer Program:

⚠️ **Users will need to:**
1. Download the app
2. Right-click → Open (first time only)
3. Click "Open" in the security warning
4. macOS Gatekeeper will block normal double-click

**To enable this:**
- Keep "Sign to Run Locally" in Xcode
- Users must bypass Gatekeeper manually
- Not recommended for public distribution

#### Automated Releases (Optional)

The included `.github/workflows/release.yml` can automate builds:

1. Add secrets to GitHub repo:
   - `APPLE_ID`
   - `APPLE_APP_PASSWORD`
   - `APPLE_TEAM_ID`
   - `CERTIFICATES_P12` (base64-encoded Developer ID cert)
   - `CERT_PASSWORD`

2. Push a git tag to trigger build:
```bash
git tag v1.0.0
git push origin v1.0.0
```

3. GitHub Actions will build, sign, notarize, and create release automatically

## 📦 Architecture

The app uses several key components:

- **AudioEngine** — Core audio processing coordinator
- **ProcessTapController** — Per-app audio tap for volume/EQ control
- **DeviceVolumeMonitor** — System device state tracking
- **MenuBarPopupView** — User interface for control

## 📄 License

This project is licensed under the **GPLv3 License** — see [LICENSE](LICENSE) for details.

---

**Made with ❤️ by Sofia Claudia Bonoan** | [GitHub](https://github.com/sofiaclaudiabonoan)


## License

[GPL v3](LICENSE)
