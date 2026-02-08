<p align="center">
  <img src="assets/icon.png" width="128" height="128" alt="SoAudioMixer app icon">
</p>

<h1 align="center">SoAudioMixer 🥭</h1>

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

<p align="center">
  <img src="assets/screenshot-main.png" alt="SoAudioMixer showing per-app volume control" width="750">
</p>

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
