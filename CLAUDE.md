# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FlClash is a multi-platform proxy client based on ClashMeta, built with Flutter. It's a cross-platform VPN/proxy application supporting Android, Windows, macOS, and Linux with Material You design.

## Development Commands

### Build Commands
- **Android**: `dart ./setup.dart android [--arch <arm64|arm|amd64>]`
- **Windows**: `dart ./setup.dart windows --arch <arm64|amd64>`
- **Linux**: `dart ./setup.dart linux --arch <arm64|amd64>`
- **macOS**: `dart ./setup.dart macos --arch <arm64|amd64>`

### Common Flutter Commands
- **Dependencies**: `flutter pub get`
- **Code Generation**: `flutter packages pub run build_runner build`
- **Clean Build**: `flutter clean`
- **Run on specific platform**: `flutter run -d <device_id>`

### Makefile Targets
- `make android_arm64` - Build Android ARM64 version
- `make macos_arm64` - Build macOS ARM64 version
- `make android_app` - Build Android app
- `make android_arm64_core` - Build core only for Android ARM64

## Architecture & Key Components

### Core Architecture
- **Flutter Frontend**: Multi-platform UI built with Flutter using Material Design 3
- **Go Backend**: ClashMeta core written in Go, compiled as native libraries
- **FFI Bridge**: Dart-Go communication via FFI (Foreign Function Interface)
- **State Management**: Riverpod for reactive state management
- **Platform Integration**: Native platform-specific features via method channels

### Key Directories
- `lib/clash/` - Core Clash integration and FFI bindings
- `lib/xboard/` - XBoard panel integration for subscription management
- `lib/manager/` - Platform-specific managers (Android, Desktop, VPN)
- `lib/providers/` - Riverpod state providers
- `lib/models/` - Data models with Freezed code generation
- `lib/views/` - UI screens and components
- `lib/widgets/` - Reusable UI components
- `core/` - Go-based ClashMeta core
- `plugins/` - Custom Flutter plugins

### State Management Pattern
Uses Riverpod with providers in `lib/providers/`:
- Generated providers use `@riverpod` annotations
- State classes use Freezed for immutability
- Global state managed through `globalState` singleton

### Platform-Specific Features
- **Desktop**: Window management, system tray, hotkeys, proxy settings
- **Mobile**: VPN service, tile service, foreground service notifications
- **Cross-platform**: WebDAV sync, profile management, network detection

### XBoard Integration
Includes a comprehensive XBoard panel system for subscription services:
- Authentication and user management
- Subscription and plan management
- Node selection and latency testing
- Profile import automation
- Payment gateway integration

## Development Guidelines

### Code Generation
Run `flutter packages pub run build_runner build` after modifying:
- Model classes with `@freezed` annotations
- Provider classes with `@riverpod` annotations
- JSON serialization classes

### Localization
- ARB files in `arb/` directory
- Generated localization in `lib/l10n/`
- Use `AppLocalizations.of(context)` for translations

### Platform Dependencies
Ensure required system dependencies are installed:
- **Linux**: `libayatana-appindicator3-dev`, `libkeybinder-3.0-dev`
- **Android**: Android SDK, NDK (set `ANDROID_NDK` environment variable)
- **Windows**: GCC compiler, Inno Setup for packaging
- **macOS**: Node.js with appdmg for DMG creation

### Core Integration
- ClashMeta core built as dynamic library
- FFI definitions in `lib/clash/generated/clash_ffi.dart`
- Core communication through `ClashLibHandler`
- Service/main process separation on Android

### Testing
No specific test framework is configured - implement tests as needed for new features.