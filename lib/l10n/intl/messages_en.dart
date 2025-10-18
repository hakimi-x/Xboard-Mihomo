// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(rate) => "Current commission rate: ${rate}%";

  static String m1(label) =>
      "Are you sure you want to delete the selected ${label}?";

  static String m2(label) =>
      "Are you sure you want to delete the current ${label}?";

  static String m3(label) => "${label} cannot be empty";

  static String m4(label) => "Current ${label} already exists";

  static String m5(error) => "Logout failed: ${error}";

  static String m6(amount) => "Max transferable: ¥${amount}";

  static String m7(label) => "No ${label} at the moment";

  static String m8(label) => "${label} must be a number";

  static String m9(statusCode) => "Failed to get messages: ${statusCode}";

  static String m10(error) => "Failed to select images: ${error}";

  static String m11(method) => "Unsupported HTTP method: ${method}";

  static String m12(error) => "Upload failed: ${error}";

  static String m13(amount) => "Order amount: ${amount}";

  static String m14(orderNo) => "Order: ${orderNo}";

  static String m15(page) => "Page ${page}";

  static String m16(label) => "${label} must be between 1024 and 49151";

  static String m17(e) => "Registration failed: ${e}";

  static String m18(count) => "${count} items have been selected";

  static String m19(e) => "Failed to send verification code: ${e}";

  static String m20(date) =>
      "Plan expired on ${date}, please renew to continue using";

  static String m21(days) =>
      "Plan will expire in ${days} days, please renew in time";

  static String m22(days) => "Subscription will expire in ${days} days";

  static String m23(count) => "Total ${count} records";

  static String m24(amount) => "Transfer amount cannot exceed ¥${amount}";

  static String m25(error) => "Transfer failed: ${error}";

  static String m26(amount) =>
      "Transfer success! Transferred ¥${amount} to wallet";

  static String m27(version) => "Current version: ${version}";

  static String m28(version) => "Force update: ${version}";

  static String m29(version) => "New version found: ${version}";

  static String m30(statusCode) =>
      "Server returned error status code ${statusCode}";

  static String m31(label) => "${label} must be a url";

  static String m32(email) =>
      "Verification code has been sent to ${email}, please check and enter the verification code and new password";

  static String m33(amount) => "Withdrawable amount: ${amount}";

  static String m34(time) => "Running time: ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accessControl": MessageLookupByLibrary.simpleMessage("AccessControl"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Only allow selected app to enter VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Configure application access proxy",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "The selected application will be excluded from VPN",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "action": MessageLookupByLibrary.simpleMessage("Action"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Switch mode"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "action_start": MessageLookupByLibrary.simpleMessage("Start/Stop"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("Show/Hide"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addRule": MessageLookupByLibrary.simpleMessage("Add rule"),
    "addedOriginRules": MessageLookupByLibrary.simpleMessage(
      "Attach on the original rules",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "addressHelp": MessageLookupByLibrary.simpleMessage(
      "WebDAV server address",
    ),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid WebDAV address",
    ),
    "adminAutoLaunch": MessageLookupByLibrary.simpleMessage(
      "Admin auto launch",
    ),
    "adminAutoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Boot up by using admin mode",
    ),
    "ago": MessageLookupByLibrary.simpleMessage(" Ago"),
    "agree": MessageLookupByLibrary.simpleMessage("Agree"),
    "allApps": MessageLookupByLibrary.simpleMessage("All apps"),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Allow applications to bypass VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Some apps can bypass VPN when turned on",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("AllowLan"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Allow access proxy through the LAN",
    ),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "app": MessageLookupByLibrary.simpleMessage("App"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "App access control",
    ),
    "appDesc": MessageLookupByLibrary.simpleMessage(
      "Processing app related settings",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Application"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Modify application related settings",
    ),
    "auto": MessageLookupByLibrary.simpleMessage("Auto"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Auto check updates",
    ),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "Auto check for updates when the app starts",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Auto close connections",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Auto close connections after change node",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Auto launch"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Follow the system self startup",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("AutoRun"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Auto run when the application is opened",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Auto set system DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Auto update"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Auto update interval (minutes)",
    ),
    "availableCommission": MessageLookupByLibrary.simpleMessage(
      "Available Commission",
    ),
    "backToLogin": MessageLookupByLibrary.simpleMessage("Back to Login"),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupAndRecovery": MessageLookupByLibrary.simpleMessage(
      "Backup and Recovery",
    ),
    "backupAndRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Sync data via WebDAV or file",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("Backup success"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Basic configuration"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the basic configuration globally",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Bind"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("Blacklist mode"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Bypass domain"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Only takes effect when the system proxy is enabled",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "The cache is corrupt. Do you want to clear it?",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelFilterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Cancel filter system app",
    ),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Cancel select all",
    ),
    "cannotGetWebUrl": MessageLookupByLibrary.simpleMessage(
      "Cannot get web URL, please contact support",
    ),
    "cannotOpenBrowser": MessageLookupByLibrary.simpleMessage(
      "Cannot open browser, please visit web manually",
    ),
    "checkError": MessageLookupByLibrary.simpleMessage("Check error"),
    "checkNetwork": MessageLookupByLibrary.simpleMessage(
      "Please check network and retry",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Check for updates"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "The current application is already the latest version",
    ),
    "checking": MessageLookupByLibrary.simpleMessage("Checking..."),
    "clearData": MessageLookupByLibrary.simpleMessage("Clear Data"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("Export clipboard"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("Clipboard import"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Color schemes"),
    "columns": MessageLookupByLibrary.simpleMessage("Columns"),
    "commissionHistory": MessageLookupByLibrary.simpleMessage(
      "Commission History",
    ),
    "commissionRate": MessageLookupByLibrary.simpleMessage("Commission Rate"),
    "commissionSettled": MessageLookupByLibrary.simpleMessage(
      "Commission settled after friend subscription",
    ),
    "compatible": MessageLookupByLibrary.simpleMessage("Compatibility mode"),
    "compatibleDesc": MessageLookupByLibrary.simpleMessage(
      "Opening it will lose part of its application ability and gain the support of full amount of Clash.",
    ),
    "complete": MessageLookupByLibrary.simpleMessage("Complete"),
    "completeWithdrawal": MessageLookupByLibrary.simpleMessage(
      "Web version provides complete withdrawal features",
    ),
    "configurationError": MessageLookupByLibrary.simpleMessage(
      "Application configuration error, please contact support",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmLogout": MessageLookupByLibrary.simpleMessage("Confirm Logout"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm New Password",
    ),
    "confirmTransfer": MessageLookupByLibrary.simpleMessage("Confirm Transfer"),
    "connections": MessageLookupByLibrary.simpleMessage("Connections"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "View current connections data",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Connectivity："),
    "contactMe": MessageLookupByLibrary.simpleMessage("Contact me"),
    "contactSupport": MessageLookupByLibrary.simpleMessage("Support"),
    "content": MessageLookupByLibrary.simpleMessage("Content"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Content"),
    "copiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "Copied to clipboard",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Copying environment variables",
    ),
    "copyInviteLink": MessageLookupByLibrary.simpleMessage("Copy Link"),
    "copyLink": MessageLookupByLibrary.simpleMessage("Copy link"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Copy success"),
    "core": MessageLookupByLibrary.simpleMessage("Core"),
    "coreInfo": MessageLookupByLibrary.simpleMessage("Core info"),
    "country": MessageLookupByLibrary.simpleMessage("Country"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Crash test"),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "credentialsSaved": MessageLookupByLibrary.simpleMessage(
      "Credentials saved",
    ),
    "currentCommissionRate": m0,
    "cut": MessageLookupByLibrary.simpleMessage("Cut"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "days": MessageLookupByLibrary.simpleMessage("Days"),
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Default nameserver",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving DNS server",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage("Sort by default"),
    "defaultText": MessageLookupByLibrary.simpleMessage("Default"),
    "delay": MessageLookupByLibrary.simpleMessage("Delay"),
    "delaySort": MessageLookupByLibrary.simpleMessage("Sort by delay"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteMultipTip": m1,
    "deleteTip": m2,
    "desc": MessageLookupByLibrary.simpleMessage(
      "A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.",
    ),
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Relying on third-party api is for reference only",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Developer mode"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Developer mode is enabled.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Direct"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Important Notice"),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "This software is currently in public beta. If you receive update reminders, please update promptly. Older versions may cause service instability or inability to use.",
    ),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Discover the new version",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Discovery a new version",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Update DNS related settings",
    ),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNS mode"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Do you want to pass",
    ),
    "domain": MessageLookupByLibrary.simpleMessage("Domain"),
    "domainStatusAvailable": MessageLookupByLibrary.simpleMessage(
      "Service Available",
    ),
    "domainStatusChecking": MessageLookupByLibrary.simpleMessage("Checking..."),
    "domainStatusUnavailable": MessageLookupByLibrary.simpleMessage(
      "Service Unavailable",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
    "emailVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Email Verification Code",
    ),
    "emptyTip": m3,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enableOverride": MessageLookupByLibrary.simpleMessage("Enable override"),
    "enterEmailForReset": MessageLookupByLibrary.simpleMessage(
      "Please enter your email address and we will send a verification code to your email",
    ),
    "enterTransferAmount": MessageLookupByLibrary.simpleMessage(
      "Enter transfer amount",
    ),
    "enterTransferAmountError": MessageLookupByLibrary.simpleMessage(
      "Please enter transfer amount",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" entries"),
    "exclude": MessageLookupByLibrary.simpleMessage("Hidden from recent tasks"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "When the app is in the background, the app is hidden from the recent task",
    ),
    "existsTip": m4,
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "expand": MessageLookupByLibrary.simpleMessage("Standard"),
    "expirationTime": MessageLookupByLibrary.simpleMessage("Expiration time"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Export file"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Export logs"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Export Success"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Expressive"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "ExternalController",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Once enabled, the Clash kernel can be controlled on port 9090",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("External link"),
    "externalResources": MessageLookupByLibrary.simpleMessage(
      "External resources",
    ),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeip filter"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip range"),
    "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Generally use offshore DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Fallback filter"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Fidelity"),
    "file": MessageLookupByLibrary.simpleMessage("File"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Directly upload profile"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "The file has been modified. Do you want to save the changes?",
    ),
    "fillInfoToRegister": MessageLookupByLibrary.simpleMessage(
      "Please fill in the following information to complete registration",
    ),
    "filterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Filter system app",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Find process"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "There is a certain performance loss after opening",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("FontFamily"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "fourColumns": MessageLookupByLibrary.simpleMessage("Four columns"),
    "friendInviteReward": MessageLookupByLibrary.simpleMessage(
      "Earn commission when your invited friends spend",
    ),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("FruitSalad"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "generalDesc": MessageLookupByLibrary.simpleMessage(
      "Modify general settings",
    ),
    "generatingInviteCode": MessageLookupByLibrary.simpleMessage(
      "Generating invite code...",
    ),
    "geoData": MessageLookupByLibrary.simpleMessage("GeoData"),
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo Low Memory Mode",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling will use the Geo low memory loader",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Geoip code"),
    "getOriginRules": MessageLookupByLibrary.simpleMessage(
      "Get original rules",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Global"),
    "go": MessageLookupByLibrary.simpleMessage("Go"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Go to download"),
    "goToWeb": MessageLookupByLibrary.simpleMessage("Go to Web"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Do you want to cache the changes?",
    ),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Add Hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("Hotkey conflict"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Hotkey Management",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Use keyboard to control applications",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Hours"),
    "iUnderstand": MessageLookupByLibrary.simpleMessage("I Understand"),
    "icon": MessageLookupByLibrary.simpleMessage("Icon"),
    "iconConfiguration": MessageLookupByLibrary.simpleMessage(
      "Icon configuration",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Icon style"),
    "import": MessageLookupByLibrary.simpleMessage("Import"),
    "importFile": MessageLookupByLibrary.simpleMessage("Import from file"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Long term effective"),
    "init": MessageLookupByLibrary.simpleMessage("Init"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Please enter the correct hotkey",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Intelligent selection",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Internet"),
    "interval": MessageLookupByLibrary.simpleMessage("Interval"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Intranet IP"),
    "invalidTransferAmount": MessageLookupByLibrary.simpleMessage(
      "Please enter valid transfer amount",
    ),
    "invite": MessageLookupByLibrary.simpleMessage("Invite"),
    "inviteCode": MessageLookupByLibrary.simpleMessage("Invite Code"),
    "inviteCodeGenFailed": MessageLookupByLibrary.simpleMessage(
      "Invite code generation failed",
    ),
    "inviteCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Invite Code (optional)",
    ),
    "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Invite Code Required",
    ),
    "inviteCodeRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Registration requires an invite code. Please contact a registered user to get an invite code before registering.",
    ),
    "inviteLinkCopied": MessageLookupByLibrary.simpleMessage(
      "Invite link copied, share with friends",
    ),
    "inviteRegisterReward": MessageLookupByLibrary.simpleMessage(
      "Invite friends to register and subscribe to earn commission",
    ),
    "inviteRules": MessageLookupByLibrary.simpleMessage("Invite Rules"),
    "inviteStats": MessageLookupByLibrary.simpleMessage("Invite Stats"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("Ipcidr"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "When turned on it will be able to receive IPv6 traffic",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Allow IPv6 inbound",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("Japanese"),
    "just": MessageLookupByLibrary.simpleMessage("Just"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Tcp keep alive interval",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Key"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "layout": MessageLookupByLibrary.simpleMessage("Layout"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "list": MessageLookupByLibrary.simpleMessage("List"),
    "listen": MessageLookupByLibrary.simpleMessage("Listen"),
    "loadMore": MessageLookupByLibrary.simpleMessage("Load More"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to local",
    ),
    "localRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Recovery data from file",
    ),
    "logLevel": MessageLookupByLibrary.simpleMessage("LogLevel"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Disabling will hide the log entry",
    ),
    "loggedOutSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged out successfully",
    ),
    "loginNow": MessageLookupByLibrary.simpleMessage("Login Now"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirmMsg": MessageLookupByLibrary.simpleMessage(
      "Are you sure to logout? You need to login again.",
    ),
    "logoutFailed": m5,
    "logs": MessageLookupByLibrary.simpleMessage("Logs"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Log capture records"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Logs test"),
    "loopback": MessageLookupByLibrary.simpleMessage("Loopback unlock tool"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Used for UWP loopback unlocking",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Loose"),
    "maxTransferable": m6,
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Memory info"),
    "messageTest": MessageLookupByLibrary.simpleMessage("Message test"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage(
      "This is a message.",
    ),
    "min": MessageLookupByLibrary.simpleMessage("Min"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("Minimize on exit"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the default system exit event",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Mixed Port"),
    "mode": MessageLookupByLibrary.simpleMessage("Mode"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Monochrome"),
    "months": MessageLookupByLibrary.simpleMessage("Months"),
    "more": MessageLookupByLibrary.simpleMessage("More"),
    "myInviteQr": MessageLookupByLibrary.simpleMessage("My Invite QR"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "nameSort": MessageLookupByLibrary.simpleMessage("Sort by name"),
    "nameserver": MessageLookupByLibrary.simpleMessage("Nameserver"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving domain",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Nameserver policy",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Specify the corresponding nameserver policy",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Network"),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Modify network-related settings",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Network detection",
    ),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Network speed"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Neutral"),
    "newMessageFromSupport": MessageLookupByLibrary.simpleMessage(
      "New message from support",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "noCommissionRecord": MessageLookupByLibrary.simpleMessage(
      "No commission records",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("No data"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("No HotKey"),
    "noIcon": MessageLookupByLibrary.simpleMessage("None"),
    "noInfo": MessageLookupByLibrary.simpleMessage("No info"),
    "noInvitationData": MessageLookupByLibrary.simpleMessage(
      "No invitation data",
    ),
    "noMoreInfoDesc": MessageLookupByLibrary.simpleMessage("No more info"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("No network"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("No network APP"),
    "noProxy": MessageLookupByLibrary.simpleMessage("No proxy"),
    "noProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Please create a profile or add a valid profile",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("No resolve IP"),
    "none": MessageLookupByLibrary.simpleMessage("none"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "The current proxy group cannot be selected.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "No profile, Please add a profile",
    ),
    "nullTip": m7,
    "numberTip": m8,
    "oneColumn": MessageLookupByLibrary.simpleMessage("One column"),
    "onlineSupport": MessageLookupByLibrary.simpleMessage("Online Support"),
    "onlineSupportAddMore": MessageLookupByLibrary.simpleMessage("Add More"),
    "onlineSupportApiConfigNotFound": MessageLookupByLibrary.simpleMessage(
      "Online support API configuration not found, please check configuration",
    ),
    "onlineSupportCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "onlineSupportClearHistory": MessageLookupByLibrary.simpleMessage(
      "Clear history",
    ),
    "onlineSupportClearHistoryConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to clear all chat history? This action cannot be undone.",
    ),
    "onlineSupportClickToSelect": MessageLookupByLibrary.simpleMessage(
      "Click to select images",
    ),
    "onlineSupportConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "onlineSupportConnected": MessageLookupByLibrary.simpleMessage(
      "Successfully connected to support system",
    ),
    "onlineSupportConnecting": MessageLookupByLibrary.simpleMessage(
      "Connecting...",
    ),
    "onlineSupportConnectionError": MessageLookupByLibrary.simpleMessage(
      "Connection error",
    ),
    "onlineSupportDisconnected": MessageLookupByLibrary.simpleMessage(
      "Disconnected",
    ),
    "onlineSupportGetMessagesFailed": m9,
    "onlineSupportInputHint": MessageLookupByLibrary.simpleMessage(
      "Please enter your question...",
    ),
    "onlineSupportNoMessages": MessageLookupByLibrary.simpleMessage(
      "No messages yet, send a message to start consultation",
    ),
    "onlineSupportSelectImages": MessageLookupByLibrary.simpleMessage(
      "Select Images",
    ),
    "onlineSupportSelectImagesFailed": m10,
    "onlineSupportSend": MessageLookupByLibrary.simpleMessage("Send"),
    "onlineSupportSendImage": MessageLookupByLibrary.simpleMessage(
      "Send image",
    ),
    "onlineSupportSendMessageFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to send message: Unable to get authentication token",
    ),
    "onlineSupportSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "Supports JPG, PNG, GIF, WebP, BMP\nMax 10MB",
    ),
    "onlineSupportTitle": MessageLookupByLibrary.simpleMessage(
      "Online Support",
    ),
    "onlineSupportTokenNotFound": MessageLookupByLibrary.simpleMessage(
      "Authentication token not found",
    ),
    "onlineSupportUnsupportedHttpMethod": m11,
    "onlineSupportUploadFailed": m12,
    "onlineSupportWebSocketConfigNotFound": MessageLookupByLibrary.simpleMessage(
      "Online support WebSocket configuration not found, please check configuration",
    ),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Icon"),
    "onlyOtherApps": MessageLookupByLibrary.simpleMessage(
      "Only third-party apps",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Only statistics proxy",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "When turned on, only statistics proxy traffic",
    ),
    "openWebFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to open web, please visit manually",
    ),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "orderAmount": m13,
    "orderNumber": m14,
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Other contributors",
    ),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Outbound mode"),
    "override": MessageLookupByLibrary.simpleMessage("Override"),
    "overrideDesc": MessageLookupByLibrary.simpleMessage(
      "Override Proxy related config",
    ),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Override Dns"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Turning it on will override the DNS options in the profile",
    ),
    "overrideInvalidTip": MessageLookupByLibrary.simpleMessage(
      "Does not take effect in script mode",
    ),
    "overrideOriginRules": MessageLookupByLibrary.simpleMessage(
      "Override the original rule",
    ),
    "pageNumber": m15,
    "palette": MessageLookupByLibrary.simpleMessage("Palette"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordMin8Chars": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "passwordResetFailed": MessageLookupByLibrary.simpleMessage(
      "Password reset failed",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Password reset successful! Please login with your new password",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "paste": MessageLookupByLibrary.simpleMessage("Paste"),
    "pendingCommission": MessageLookupByLibrary.simpleMessage(
      "Pending Commission",
    ),
    "plans": MessageLookupByLibrary.simpleMessage("Plans"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Please bind WebDAV",
    ),
    "pleaseConfirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Please re-enter new password",
    ),
    "pleaseConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Please confirm password",
    ),
    "pleaseEnterAtLeast8CharsPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter at least 8 characters password",
    ),
    "pleaseEnterEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter email address",
    ),
    "pleaseEnterEmailAddress": MessageLookupByLibrary.simpleMessage(
      "Please enter email address",
    ),
    "pleaseEnterEmailVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Please enter email verification code",
    ),
    "pleaseEnterInviteCode": MessageLookupByLibrary.simpleMessage(
      "Please enter invite code",
    ),
    "pleaseEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter new password",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter password",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Please enter a script name",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email address",
    ),
    "pleaseEnterValidEmailAddress": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email address",
    ),
    "pleaseEnterValidVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid verification code",
    ),
    "pleaseEnterVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Please enter email verification code",
    ),
    "pleaseEnterYourEmailAddress": MessageLookupByLibrary.simpleMessage(
      "Please enter your email address",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter the admin password",
    ),
    "pleaseReEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Please re-enter password",
    ),
    "pleaseUploadFile": MessageLookupByLibrary.simpleMessage(
      "Please upload file",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Please upload a valid QR code",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Port"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a different port",
    ),
    "portTip": m16,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Prioritize the use of DOH\'s http/3",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Please press the keyboard.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Preview"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Please input a valid interval time format",
        ),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Please enter the auto update interval time",
        ),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "The profile has been modified. Do you want to disable auto update?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile name",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "profile parse error",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input a valid profile URL",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile URL",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiles"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Profiles sort"),
    "project": MessageLookupByLibrary.simpleMessage("Project"),
    "providers": MessageLookupByLibrary.simpleMessage("Providers"),
    "proxies": MessageLookupByLibrary.simpleMessage("Proxies"),
    "proxiesSetting": MessageLookupByLibrary.simpleMessage("Proxies setting"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Proxy group"),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("Proxy nameserver"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Domain for resolving proxy nodes",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("ProxyPort"),
    "proxyPortDesc": MessageLookupByLibrary.simpleMessage(
      "Set the Clash listening port",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Proxy providers"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Pure black mode"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR code"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Scan QR code to obtain profile",
    ),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Rainbow"),
    "recovery": MessageLookupByLibrary.simpleMessage("Recovery"),
    "recoveryAll": MessageLookupByLibrary.simpleMessage("Recovery all data"),
    "recoveryProfiles": MessageLookupByLibrary.simpleMessage(
      "Only recovery profiles",
    ),
    "recoveryStrategy": MessageLookupByLibrary.simpleMessage(
      "Recovery strategy",
    ),
    "recoveryStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Compatible",
    ),
    "recoveryStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Override",
    ),
    "recoverySuccess": MessageLookupByLibrary.simpleMessage("Recovery success"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir Port"),
    "redo": MessageLookupByLibrary.simpleMessage("redo"),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "regExp": MessageLookupByLibrary.simpleMessage("RegExp"),
    "registerAccount": MessageLookupByLibrary.simpleMessage("Register Account"),
    "registerSuccessSaveCredentials": MessageLookupByLibrary.simpleMessage(
      "Registration successful - Saving credentials:",
    ),
    "registrationFailed": m17,
    "rememberPassword": MessageLookupByLibrary.simpleMessage(
      "Remember your password?",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Remote"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to WebDAV",
    ),
    "remoteRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Recovery data from WebDAV",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "rename": MessageLookupByLibrary.simpleMessage("Rename"),
    "requests": MessageLookupByLibrary.simpleMessage("Requests"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "View recently request records",
    ),
    "resendVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Resend Verification Code",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "resetTip": MessageLookupByLibrary.simpleMessage("Make sure to reset"),
    "resources": MessageLookupByLibrary.simpleMessage("Resources"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "External resource related info",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Respect rules"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS connection following rules, need to configure proxy-server-nameserver",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Route address"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Config listen route address",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Route mode"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Bypass private route address",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("Use config"),
    "ru": MessageLookupByLibrary.simpleMessage("Russian"),
    "rule": MessageLookupByLibrary.simpleMessage("Rule"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Rule name"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Rule providers"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Rule target"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Do you want to save the changes?",
    ),
    "saveQr": MessageLookupByLibrary.simpleMessage("Save QR"),
    "saveQrCodeFeature": MessageLookupByLibrary.simpleMessage(
      "Save QR feature coming soon",
    ),
    "saveTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to save?",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Script"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "seconds": MessageLookupByLibrary.simpleMessage("Seconds"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
    "selectTheme": MessageLookupByLibrary.simpleMessage("Select Theme"),
    "selected": MessageLookupByLibrary.simpleMessage("Selected"),
    "selectedCountTitle": m18,
    "sendCodeFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to send verification code",
    ),
    "sendVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Send Verification Code",
    ),
    "sendVerificationCodeFailed": m19,
    "setNewPassword": MessageLookupByLibrary.simpleMessage("Set New Password"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "show": MessageLookupByLibrary.simpleMessage("Show"),
    "shrink": MessageLookupByLibrary.simpleMessage("Shrink"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("SilentLaunch"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Start in the background",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Size"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socks Port"),
    "sort": MessageLookupByLibrary.simpleMessage("Sort"),
    "source": MessageLookupByLibrary.simpleMessage("Source"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Source IP"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Stack mode"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "start": MessageLookupByLibrary.simpleMessage("Start"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Starting VPN..."),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "System DNS will be used when turned off",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Stop"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Stopping VPN..."),
    "style": MessageLookupByLibrary.simpleMessage("Style"),
    "subRule": MessageLookupByLibrary.simpleMessage("Sub rule"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "subscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "Subscription expired",
    ),
    "subscriptionExpiredDetail": m20,
    "subscriptionExpiresToday": MessageLookupByLibrary.simpleMessage(
      "Subscription expires today",
    ),
    "subscriptionExpiresTodayDetail": MessageLookupByLibrary.simpleMessage(
      "Plan will expire today, please renew immediately to avoid service interruption",
    ),
    "subscriptionExpiringInDays": MessageLookupByLibrary.simpleMessage(
      "Subscription expiring soon",
    ),
    "subscriptionExpiringInDaysDetail": m21,
    "subscriptionNoSubscription": MessageLookupByLibrary.simpleMessage(
      "No subscription",
    ),
    "subscriptionNoSubscriptionDetail": MessageLookupByLibrary.simpleMessage(
      "No available subscription plan found, please purchase a plan to use",
    ),
    "subscriptionNotLoggedIn": MessageLookupByLibrary.simpleMessage(
      "Not logged in",
    ),
    "subscriptionNotLoggedInDetail": MessageLookupByLibrary.simpleMessage(
      "Please login first",
    ),
    "subscriptionTrafficExhausted": MessageLookupByLibrary.simpleMessage(
      "Traffic exhausted",
    ),
    "subscriptionTrafficExhaustedDetail": MessageLookupByLibrary.simpleMessage(
      "Plan traffic has been used up, please purchase more traffic or upgrade plan",
    ),
    "subscriptionValid": MessageLookupByLibrary.simpleMessage(
      "Subscription valid",
    ),
    "subscriptionValidDetail": m22,
    "switchTheme": MessageLookupByLibrary.simpleMessage("Switch Theme"),
    "sync": MessageLookupByLibrary.simpleMessage("Sync"),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "systemApp": MessageLookupByLibrary.simpleMessage("System APP"),
    "systemFont": MessageLookupByLibrary.simpleMessage("System font"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Attach HTTP proxy to VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Tab"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Tab animation"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Effective only in mobile view",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP concurrent"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling it will allow TCP concurrency",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("Test url"),
    "textScale": MessageLookupByLibrary.simpleMessage("Text Scaling"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Theme color"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Set dark mode,adjust the color",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Theme mode"),
    "threeColumns": MessageLookupByLibrary.simpleMessage("Three columns"),
    "tight": MessageLookupByLibrary.simpleMessage("Tight"),
    "time": MessageLookupByLibrary.simpleMessage("Time"),
    "tip": MessageLookupByLibrary.simpleMessage("tip"),
    "toggle": MessageLookupByLibrary.simpleMessage("Toggle"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("TonalSpot"),
    "tools": MessageLookupByLibrary.simpleMessage("Tools"),
    "totalCommission": MessageLookupByLibrary.simpleMessage("Total Commission"),
    "totalInvites": MessageLookupByLibrary.simpleMessage("Total Invites"),
    "totalRecords": m23,
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxy Port"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Traffic usage"),
    "transfer": MessageLookupByLibrary.simpleMessage("Transfer"),
    "transferAmount": MessageLookupByLibrary.simpleMessage("Transfer Amount"),
    "transferAmountExceeded": m24,
    "transferFailed": m25,
    "transferNote": MessageLookupByLibrary.simpleMessage(
      "Transferred balance can be used for in-app purchases",
    ),
    "transferSuccess": MessageLookupByLibrary.simpleMessage(
      "Transfer Success!",
    ),
    "transferSuccessMsg": m26,
    "transferToWallet": MessageLookupByLibrary.simpleMessage(
      "Transfer to Wallet",
    ),
    "transferring": MessageLookupByLibrary.simpleMessage("Transferring..."),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "only effective in administrator mode",
    ),
    "twoColumns": MessageLookupByLibrary.simpleMessage("Two columns"),
    "unableToUpdateCurrentProfileDesc": MessageLookupByLibrary.simpleMessage(
      "unable to update current profile",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("undo"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Unified delay"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Remove extra delays such as handshaking",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Unnamed"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateCheckAllServersUnavailable": MessageLookupByLibrary.simpleMessage(
      "All configured update servers are unavailable",
    ),
    "updateCheckCurrentVersion": m27,
    "updateCheckForceUpdate": m28,
    "updateCheckMustUpdate": MessageLookupByLibrary.simpleMessage(
      "Must Update",
    ),
    "updateCheckNewVersionFound": m29,
    "updateCheckNoServerUrlsConfigured": MessageLookupByLibrary.simpleMessage(
      "No update server URLs configured, please check configuration",
    ),
    "updateCheckReleaseNotes": MessageLookupByLibrary.simpleMessage(
      "Release Notes:",
    ),
    "updateCheckServerError": m30,
    "updateCheckServerTemporarilyUnavailable":
        MessageLookupByLibrary.simpleMessage(
          "Server temporarily unavailable, please try again later",
        ),
    "updateCheckServerUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Update server URL not configured, please check configuration",
    ),
    "updateCheckUpdateLater": MessageLookupByLibrary.simpleMessage(
      "Update Later",
    ),
    "updateCheckUpdateNow": MessageLookupByLibrary.simpleMessage("Update Now"),
    "upload": MessageLookupByLibrary.simpleMessage("Upload"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Obtain profile through URL",
    ),
    "urlTip": m31,
    "useHosts": MessageLookupByLibrary.simpleMessage("Use hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("Use system hosts"),
    "userCenter": MessageLookupByLibrary.simpleMessage("User Center"),
    "value": MessageLookupByLibrary.simpleMessage("Value"),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Verification Code",
    ),
    "verificationCode6Digits": MessageLookupByLibrary.simpleMessage(
      "Verification code should be 6 digits",
    ),
    "verificationCodeSent": MessageLookupByLibrary.simpleMessage(
      "Verification code has been sent to your email, please check",
    ),
    "verificationCodeSentCheckEmail": MessageLookupByLibrary.simpleMessage(
      "Verification code sent, please check your email",
    ),
    "verificationCodeSentTo": m32,
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Vibrant"),
    "view": MessageLookupByLibrary.simpleMessage("View"),
    "viewHistory": MessageLookupByLibrary.simpleMessage("View History"),
    "visitWebVersion": MessageLookupByLibrary.simpleMessage(
      "Please visit web version to withdraw",
    ),
    "vpnDesc": MessageLookupByLibrary.simpleMessage(
      "Modify VPN related settings",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Auto routes all system traffic through VpnService",
    ),
    "vpnSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Attach HTTP proxy to VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Changes take effect after restarting the VPN",
    ),
    "walletBalance": MessageLookupByLibrary.simpleMessage("Wallet Balance"),
    "walletDetails": MessageLookupByLibrary.simpleMessage("Wallet Details"),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "WebDAV configuration",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("Whitelist mode"),
    "withdraw": MessageLookupByLibrary.simpleMessage("Withdraw"),
    "withdrawCommission": MessageLookupByLibrary.simpleMessage(
      "Withdraw Commission",
    ),
    "withdrawableAmount": m33,
    "withdrawalAvailable": MessageLookupByLibrary.simpleMessage(
      "Available commission can be withdrawn",
    ),
    "xboard24HourCustomerService": MessageLookupByLibrary.simpleMessage(
      "24-hour customer service support",
    ),
    "xboardAccountBalance": MessageLookupByLibrary.simpleMessage(
      "Account balance",
    ),
    "xboardAddLinkToConfig": MessageLookupByLibrary.simpleMessage(
      "Add this subscription link to your configuration",
    ),
    "xboardAddingToConfigList": MessageLookupByLibrary.simpleMessage(
      "Adding to configuration list",
    ),
    "xboardAfterPurchasingPlan": MessageLookupByLibrary.simpleMessage(
      "After purchasing a plan, you will enjoy:",
    ),
    "xboardApiUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "API URL not configured",
    ),
    "xboardAutoCheckEvery5Seconds": MessageLookupByLibrary.simpleMessage(
      "System checks every 5 seconds, will redirect automatically after payment",
    ),
    "xboardAutoDetectPaymentStatus": MessageLookupByLibrary.simpleMessage(
      "Auto-detect payment status",
    ),
    "xboardAutoOpeningPaymentPage": MessageLookupByLibrary.simpleMessage(
      "Auto-opening payment page, please return to app after payment",
    ),
    "xboardAutoTesting": MessageLookupByLibrary.simpleMessage("Auto testing"),
    "xboardBack": MessageLookupByLibrary.simpleMessage("Back"),
    "xboardBrowserNotOpenedTip": MessageLookupByLibrary.simpleMessage(
      "If browser doesn\'t open automatically, click \\\"Reopen\\\" or copy link manually",
    ),
    "xboardBuyMoreTrafficOrUpgrade": MessageLookupByLibrary.simpleMessage(
      "Please buy more traffic or upgrade plan",
    ),
    "xboardBuyNow": MessageLookupByLibrary.simpleMessage("Buy Now"),
    "xboardBuyoutPlan": MessageLookupByLibrary.simpleMessage("Buyout plan"),
    "xboardCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "xboardCancelPayment": MessageLookupByLibrary.simpleMessage(
      "Cancel payment",
    ),
    "xboardCheckPaymentFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to check payment status",
    ),
    "xboardCheckStatus": MessageLookupByLibrary.simpleMessage("Check status"),
    "xboardChecking": MessageLookupByLibrary.simpleMessage("Checking"),
    "xboardCleaningOldConfig": MessageLookupByLibrary.simpleMessage(
      "Cleaning old configuration",
    ),
    "xboardClearError": MessageLookupByLibrary.simpleMessage("Clear error"),
    "xboardClickToCopy": MessageLookupByLibrary.simpleMessage("Click to copy"),
    "xboardClickToSetupNodes": MessageLookupByLibrary.simpleMessage(
      "Click to setup nodes",
    ),
    "xboardCompletePaymentInBrowser": MessageLookupByLibrary.simpleMessage(
      "2. Please complete payment in your browser",
    ),
    "xboardConfigDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Configuration download failed, please check subscription link",
    ),
    "xboardConfigFormatError": MessageLookupByLibrary.simpleMessage(
      "Configuration format error, please contact service provider",
    ),
    "xboardConfigSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Configuration save failed, please check storage space",
    ),
    "xboardConfigurationError": MessageLookupByLibrary.simpleMessage(
      "Configuration error",
    ),
    "xboardConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "xboardConfirmAction": MessageLookupByLibrary.simpleMessage("Confirm"),
    "xboardConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "xboardConfirmPurchase": MessageLookupByLibrary.simpleMessage(
      "Confirm purchase",
    ),
    "xboardCongratulationsSubscriptionActivated":
        MessageLookupByLibrary.simpleMessage(
          "Congratulations! Your subscription has been successfully purchased and activated",
        ),
    "xboardConnectGlobalQualityNodes": MessageLookupByLibrary.simpleMessage(
      "Connect to global quality nodes",
    ),
    "xboardConnectionTimeout": MessageLookupByLibrary.simpleMessage(
      "Connection timeout, please check network connection",
    ),
    "xboardCopyFailed": MessageLookupByLibrary.simpleMessage("Copy failed"),
    "xboardCopyLink": MessageLookupByLibrary.simpleMessage("Copy Link"),
    "xboardCopyPaymentLink": MessageLookupByLibrary.simpleMessage("Copy Link"),
    "xboardCopySubscriptionLinkAbove": MessageLookupByLibrary.simpleMessage(
      "Copy the subscription link above",
    ),
    "xboardCouponExpired": MessageLookupByLibrary.simpleMessage(
      "Coupon expired",
    ),
    "xboardCouponNotYetActive": MessageLookupByLibrary.simpleMessage(
      "Coupon not yet active",
    ),
    "xboardCouponOptional": MessageLookupByLibrary.simpleMessage(
      "Coupon (optional)",
    ),
    "xboardCreatingOrder": MessageLookupByLibrary.simpleMessage(
      "Creating order",
    ),
    "xboardCreatingOrderPleaseWait": MessageLookupByLibrary.simpleMessage(
      "We are creating a new order for you, please wait",
    ),
    "xboardCurrentNode": MessageLookupByLibrary.simpleMessage("Current Node"),
    "xboardCurrentVersion": MessageLookupByLibrary.simpleMessage(
      "Current version",
    ),
    "xboardDays": MessageLookupByLibrary.simpleMessage("days"),
    "xboardDeductibleDuringPayment": MessageLookupByLibrary.simpleMessage(
      "Deductible during payment",
    ),
    "xboardDiscounted": MessageLookupByLibrary.simpleMessage("Discounted"),
    "xboardDownloadingConfig": MessageLookupByLibrary.simpleMessage(
      "Downloading configuration file",
    ),
    "xboardEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "xboardEnableTun": MessageLookupByLibrary.simpleMessage("Enable TUN"),
    "xboardEnjoyFastNetworkExperience": MessageLookupByLibrary.simpleMessage(
      "Enjoy fast network experience",
    ),
    "xboardEnterCouponCode": MessageLookupByLibrary.simpleMessage(
      "Enter coupon code",
    ),
    "xboardExcellent": MessageLookupByLibrary.simpleMessage("Excellent"),
    "xboardExpiryTime": MessageLookupByLibrary.simpleMessage("Expiry time"),
    "xboardFailedToCheckPaymentStatus": MessageLookupByLibrary.simpleMessage(
      "Failed to check payment status",
    ),
    "xboardFailedToGetSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Failed to get subscription information",
    ),
    "xboardFailedToOpenPaymentLink": MessageLookupByLibrary.simpleMessage(
      "Failed to open payment link",
    ),
    "xboardFailedToOpenPaymentPage": MessageLookupByLibrary.simpleMessage(
      "Failed to open payment page",
    ),
    "xboardFair": MessageLookupByLibrary.simpleMessage("Fair"),
    "xboardForceUpdate": MessageLookupByLibrary.simpleMessage("Force update"),
    "xboardForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot Password",
    ),
    "xboardGettingIP": MessageLookupByLibrary.simpleMessage("Getting..."),
    "xboardGlobalNodes": MessageLookupByLibrary.simpleMessage("Global nodes"),
    "xboardGood": MessageLookupByLibrary.simpleMessage("Good"),
    "xboardGroup": MessageLookupByLibrary.simpleMessage("Group"),
    "xboardHalfYearlyPayment": MessageLookupByLibrary.simpleMessage(
      "Half-yearly",
    ),
    "xboardHandleLater": MessageLookupByLibrary.simpleMessage("Handle later"),
    "xboardHighSpeedNetwork": MessageLookupByLibrary.simpleMessage(
      "High-speed network",
    ),
    "xboardImportFailed": MessageLookupByLibrary.simpleMessage("Import failed"),
    "xboardImportSuccess": MessageLookupByLibrary.simpleMessage(
      "Import successful",
    ),
    "xboardInsufficientBalance": MessageLookupByLibrary.simpleMessage(
      "Insufficient balance",
    ),
    "xboardInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Invalid username or password",
    ),
    "xboardInvalidOrExpiredCoupon": MessageLookupByLibrary.simpleMessage(
      "Invalid or expired coupon code",
    ),
    "xboardInvalidResponseFormat": MessageLookupByLibrary.simpleMessage(
      "Invalid response format from server",
    ),
    "xboardInviteCode": MessageLookupByLibrary.simpleMessage("Invite Code"),
    "xboardKeepSubscriptionLinkSafe": MessageLookupByLibrary.simpleMessage(
      "Please keep your subscription link safe and don\'t share with others",
    ),
    "xboardLater": MessageLookupByLibrary.simpleMessage("Later"),
    "xboardLoadingFailed": MessageLookupByLibrary.simpleMessage(
      "Loading failed",
    ),
    "xboardLoadingPaymentPage": MessageLookupByLibrary.simpleMessage(
      "Loading payment page",
    ),
    "xboardLocalIP": MessageLookupByLibrary.simpleMessage("Local IP"),
    "xboardLoggedIn": MessageLookupByLibrary.simpleMessage("Logged In"),
    "xboardLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "xboardLoginExpired": MessageLookupByLibrary.simpleMessage(
      "Login expired, please login again",
    ),
    "xboardLoginFailed": MessageLookupByLibrary.simpleMessage("Login failed"),
    "xboardLoginSuccess": MessageLookupByLibrary.simpleMessage(
      "Login successful",
    ),
    "xboardLoginToViewSubscription": MessageLookupByLibrary.simpleMessage(
      "Please login to view subscription usage",
    ),
    "xboardLogout": MessageLookupByLibrary.simpleMessage("Logout"),
    "xboardLogoutConfirmContent": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to logout? You will need to re-enter your credentials.",
    ),
    "xboardLogoutConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Logout",
    ),
    "xboardLogoutFailed": MessageLookupByLibrary.simpleMessage("Logout failed"),
    "xboardLogoutSuccess": MessageLookupByLibrary.simpleMessage(
      "Successfully logged out",
    ),
    "xboardMissingRequiredField": MessageLookupByLibrary.simpleMessage(
      "Missing required field",
    ),
    "xboardMonthlyPayment": MessageLookupByLibrary.simpleMessage("Monthly"),
    "xboardMonthlyRenewal": MessageLookupByLibrary.simpleMessage(
      "Monthly renewal",
    ),
    "xboardMustUpdate": MessageLookupByLibrary.simpleMessage("Must update"),
    "xboardNetworkConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "Network connection failed, please check network settings",
    ),
    "xboardNewVersionFound": MessageLookupByLibrary.simpleMessage(
      "New version found",
    ),
    "xboardNext": MessageLookupByLibrary.simpleMessage("Next"),
    "xboardNoAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "No available nodes",
    ),
    "xboardNoAvailablePlan": MessageLookupByLibrary.simpleMessage(
      "No available plan",
    ),
    "xboardNoAvailableSubscription": MessageLookupByLibrary.simpleMessage(
      "No available subscription",
    ),
    "xboardNoInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection, please check network settings",
    ),
    "xboardNoSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "No subscription information",
    ),
    "xboardNoSubscriptionPlans": MessageLookupByLibrary.simpleMessage(
      "No subscription plans",
    ),
    "xboardNodeName": MessageLookupByLibrary.simpleMessage("Node Name"),
    "xboardNone": MessageLookupByLibrary.simpleMessage("None"),
    "xboardNotLoggedIn": MessageLookupByLibrary.simpleMessage("Not Logged In"),
    "xboardOneTimePayment": MessageLookupByLibrary.simpleMessage("One-time"),
    "xboardOpenPaymentFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to open payment page",
    ),
    "xboardOpenPaymentLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to open payment link",
    ),
    "xboardOperationFailed": MessageLookupByLibrary.simpleMessage(
      "Operation failed",
    ),
    "xboardOperationTips": MessageLookupByLibrary.simpleMessage(
      "Operation tips",
    ),
    "xboardOrderCreationFailed": MessageLookupByLibrary.simpleMessage(
      "Order creation failed",
    ),
    "xboardOrderNotFound": MessageLookupByLibrary.simpleMessage(
      "Order not found",
    ),
    "xboardOrderNumber": MessageLookupByLibrary.simpleMessage("Order number"),
    "xboardOrderStatusPending": MessageLookupByLibrary.simpleMessage(
      "Order status: Pending payment",
    ),
    "xboardPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "xboardPaymentCancelled": MessageLookupByLibrary.simpleMessage(
      "Payment cancelled",
    ),
    "xboardPaymentComplete": MessageLookupByLibrary.simpleMessage(
      "Payment Complete",
    ),
    "xboardPaymentCompleted": MessageLookupByLibrary.simpleMessage(
      "Payment completed!",
    ),
    "xboardPaymentFailed": MessageLookupByLibrary.simpleMessage(
      "Payment failed",
    ),
    "xboardPaymentGateway": MessageLookupByLibrary.simpleMessage(
      "Payment gateway",
    ),
    "xboardPaymentInfo": MessageLookupByLibrary.simpleMessage(
      "Payment information",
    ),
    "xboardPaymentInstructions1": MessageLookupByLibrary.simpleMessage(
      "1. Payment page has been opened automatically",
    ),
    "xboardPaymentInstructions2": MessageLookupByLibrary.simpleMessage(
      "2. Please complete payment in your browser",
    ),
    "xboardPaymentInstructions3": MessageLookupByLibrary.simpleMessage(
      "3. Return to app after payment, system will detect automatically",
    ),
    "xboardPaymentLink": MessageLookupByLibrary.simpleMessage("Payment link"),
    "xboardPaymentLinkCopied": MessageLookupByLibrary.simpleMessage(
      "Payment link copied to clipboard",
    ),
    "xboardPaymentMethodVerified": MessageLookupByLibrary.simpleMessage(
      "Payment method verified",
    ),
    "xboardPaymentMethodVerifiedPreparing":
        MessageLookupByLibrary.simpleMessage(
          "Payment method verified, preparing to redirect to payment page",
        ),
    "xboardPaymentPageAutoOpened": MessageLookupByLibrary.simpleMessage(
      "1. Payment page has been opened automatically",
    ),
    "xboardPaymentPageOpenedCompleteAndReturn":
        MessageLookupByLibrary.simpleMessage(
          "Payment page opened, please complete payment and return to app",
        ),
    "xboardPaymentPageOpenedInBrowser": MessageLookupByLibrary.simpleMessage(
      "Payment page opened in browser, please return to app after payment",
    ),
    "xboardPaymentSuccess": MessageLookupByLibrary.simpleMessage(
      "Payment successful",
    ),
    "xboardPaymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "🎉 Payment successful!",
    ),
    "xboardPlanInfo": MessageLookupByLibrary.simpleMessage("Plan Information"),
    "xboardPlanNotFound": MessageLookupByLibrary.simpleMessage(
      "Plan not found",
    ),
    "xboardPlans": MessageLookupByLibrary.simpleMessage("Plans"),
    "xboardPleaseSelectPaymentPeriod": MessageLookupByLibrary.simpleMessage(
      "Please select payment period",
    ),
    "xboardPoor": MessageLookupByLibrary.simpleMessage("Poor"),
    "xboardPreparingImport": MessageLookupByLibrary.simpleMessage(
      "Preparing import",
    ),
    "xboardPreparingPaymentPage": MessageLookupByLibrary.simpleMessage(
      "Preparing payment page, redirecting soon",
    ),
    "xboardPrevious": MessageLookupByLibrary.simpleMessage("Previous"),
    "xboardProcessing": MessageLookupByLibrary.simpleMessage("Processing..."),
    "xboardProfessionalSupport": MessageLookupByLibrary.simpleMessage(
      "Professional support",
    ),
    "xboardProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "xboardProtectNetworkPrivacy": MessageLookupByLibrary.simpleMessage(
      "Protect your network privacy",
    ),
    "xboardProxy": MessageLookupByLibrary.simpleMessage("Proxy"),
    "xboardProxyMode": MessageLookupByLibrary.simpleMessage("Proxy Mode"),
    "xboardProxyModeDirectDescription": MessageLookupByLibrary.simpleMessage(
      "All traffic connects directly without proxy",
    ),
    "xboardProxyModeGlobalDescription": MessageLookupByLibrary.simpleMessage(
      "All traffic goes through proxy server",
    ),
    "xboardProxyModeRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Automatically select direct or proxy based on rules",
    ),
    "xboardPurchasePlan": MessageLookupByLibrary.simpleMessage("Purchase plan"),
    "xboardPurchaseSubscription": MessageLookupByLibrary.simpleMessage(
      "Purchase subscription",
    ),
    "xboardPurchaseSubscriptionToUse": MessageLookupByLibrary.simpleMessage(
      "Please purchase a subscription to use",
    ),
    "xboardPurchaseTraffic": MessageLookupByLibrary.simpleMessage(
      "Purchase traffic",
    ),
    "xboardQuarterlyPayment": MessageLookupByLibrary.simpleMessage("Quarterly"),
    "xboardRefresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "xboardRefreshStatus": MessageLookupByLibrary.simpleMessage(
      "Refresh status",
    ),
    "xboardRegister": MessageLookupByLibrary.simpleMessage("Register"),
    "xboardRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Registration failed",
    ),
    "xboardRegisterSuccess": MessageLookupByLibrary.simpleMessage(
      "Registration successful! Redirecting to login page...",
    ),
    "xboardReload": MessageLookupByLibrary.simpleMessage("Reload"),
    "xboardRelogin": MessageLookupByLibrary.simpleMessage("Login Again"),
    "xboardRememberPassword": MessageLookupByLibrary.simpleMessage(
      "Remember Password",
    ),
    "xboardRenewPlan": MessageLookupByLibrary.simpleMessage("Renew plan"),
    "xboardRenewToContinue": MessageLookupByLibrary.simpleMessage(
      "Please renew to continue using",
    ),
    "xboardReopen": MessageLookupByLibrary.simpleMessage("Reopen"),
    "xboardReopenPayment": MessageLookupByLibrary.simpleMessage(
      "Reopen Payment",
    ),
    "xboardReopenPaymentPageTip": MessageLookupByLibrary.simpleMessage(
      "To reopen, click the \\\"Reopen\\\" button below",
    ),
    "xboardRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "xboardRetryGet": MessageLookupByLibrary.simpleMessage("Retry"),
    "xboardReturn": MessageLookupByLibrary.simpleMessage("Return"),
    "xboardReturnAfterPaymentAutoDetect": MessageLookupByLibrary.simpleMessage(
      "3. Return to app after payment, system will detect automatically",
    ),
    "xboardRunningTime": m34,
    "xboardSecureEncryption": MessageLookupByLibrary.simpleMessage(
      "Secure encryption",
    ),
    "xboardSelectPaymentPeriod": MessageLookupByLibrary.simpleMessage(
      "Select payment period",
    ),
    "xboardSelectPeriod": MessageLookupByLibrary.simpleMessage(
      "Please select purchase period",
    ),
    "xboardSendVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Send Verification Code",
    ),
    "xboardServerError": MessageLookupByLibrary.simpleMessage("Server error"),
    "xboardSetup": MessageLookupByLibrary.simpleMessage("Setup"),
    "xboardSixMonthCycle": MessageLookupByLibrary.simpleMessage(
      "6-month cycle",
    ),
    "xboardSpeedLimit": MessageLookupByLibrary.simpleMessage("Speed"),
    "xboardStartProxy": MessageLookupByLibrary.simpleMessage("Start Proxy"),
    "xboardStop": MessageLookupByLibrary.simpleMessage("Stop"),
    "xboardStopProxy": MessageLookupByLibrary.simpleMessage("Stop Proxy"),
    "xboardSubscription": MessageLookupByLibrary.simpleMessage("Subscription"),
    "xboardSubscriptionCopied": MessageLookupByLibrary.simpleMessage(
      "Subscription link copied to clipboard",
    ),
    "xboardSubscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "Subscription expired",
    ),
    "xboardSubscriptionHasExpired": MessageLookupByLibrary.simpleMessage(
      "Subscription has expired",
    ),
    "xboardSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Subscription information",
    ),
    "xboardSubscriptionLink": MessageLookupByLibrary.simpleMessage(
      "Subscription link",
    ),
    "xboardSubscriptionLinkCopied": MessageLookupByLibrary.simpleMessage(
      "Subscription link copied to clipboard",
    ),
    "xboardSubscriptionPurchase": MessageLookupByLibrary.simpleMessage(
      "Subscription purchase",
    ),
    "xboardSubscriptionStatus": MessageLookupByLibrary.simpleMessage(
      "Subscription status",
    ),
    "xboardSwitch": MessageLookupByLibrary.simpleMessage("Switch"),
    "xboardTesting": MessageLookupByLibrary.simpleMessage("Testing"),
    "xboardThirtySixMonthCycle": MessageLookupByLibrary.simpleMessage(
      "36-month cycle",
    ),
    "xboardThreeMonthCycle": MessageLookupByLibrary.simpleMessage(
      "3-month cycle",
    ),
    "xboardThreeYearPayment": MessageLookupByLibrary.simpleMessage(
      "Three-year",
    ),
    "xboardTimeout": MessageLookupByLibrary.simpleMessage("Timeout"),
    "xboardTokenExpiredContent": MessageLookupByLibrary.simpleMessage(
      "Your login session has expired. Please login again to continue.",
    ),
    "xboardTokenExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Login Expired",
    ),
    "xboardTraffic": MessageLookupByLibrary.simpleMessage("Traffic"),
    "xboardTrafficExhausted": MessageLookupByLibrary.simpleMessage(
      "Traffic exhausted",
    ),
    "xboardTrafficUsedUp": MessageLookupByLibrary.simpleMessage(
      "Traffic used up",
    ),
    "xboardTunEnabled": MessageLookupByLibrary.simpleMessage("TUN enabled"),
    "xboardTwelveMonthCycle": MessageLookupByLibrary.simpleMessage(
      "12-month cycle",
    ),
    "xboardTwentyFourMonthCycle": MessageLookupByLibrary.simpleMessage(
      "24-month cycle",
    ),
    "xboardTwoYearPayment": MessageLookupByLibrary.simpleMessage("Two-year"),
    "xboardUnauthorizedAccess": MessageLookupByLibrary.simpleMessage(
      "Unauthorized access, please login first",
    ),
    "xboardUnknownErrorRetry": MessageLookupByLibrary.simpleMessage(
      "Unknown error, please retry",
    ),
    "xboardUnknownUser": MessageLookupByLibrary.simpleMessage("Unknown User"),
    "xboardUnselected": MessageLookupByLibrary.simpleMessage("Unselected"),
    "xboardUnsupportedCouponType": MessageLookupByLibrary.simpleMessage(
      "Unsupported coupon type",
    ),
    "xboardUpdateContent": MessageLookupByLibrary.simpleMessage(
      "Update content:",
    ),
    "xboardUpdateLater": MessageLookupByLibrary.simpleMessage("Update Later"),
    "xboardUpdateNow": MessageLookupByLibrary.simpleMessage("Update Now"),
    "xboardUpdateSubscriptionRegularly": MessageLookupByLibrary.simpleMessage(
      "Update subscription regularly to get latest nodes",
    ),
    "xboardUsageInstructions": MessageLookupByLibrary.simpleMessage(
      "Usage instructions",
    ),
    "xboardUsed": MessageLookupByLibrary.simpleMessage("Used"),
    "xboardUsedTraffic": MessageLookupByLibrary.simpleMessage("Used"),
    "xboardValidatingConfigFormat": MessageLookupByLibrary.simpleMessage(
      "Validating configuration format",
    ),
    "xboardValidationFailed": MessageLookupByLibrary.simpleMessage(
      "Validation failed",
    ),
    "xboardValidityPeriod": MessageLookupByLibrary.simpleMessage("Expires"),
    "xboardVerify": MessageLookupByLibrary.simpleMessage("Verify"),
    "xboardVeryPoor": MessageLookupByLibrary.simpleMessage("Very poor"),
    "xboardWaitingForPayment": MessageLookupByLibrary.simpleMessage(
      "Waiting for payment",
    ),
    "xboardWaitingPaymentCompletion": MessageLookupByLibrary.simpleMessage(
      "Waiting for payment completion",
    ),
    "xboardYearlyPayment": MessageLookupByLibrary.simpleMessage("Yearly"),
    "years": MessageLookupByLibrary.simpleMessage("Years"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Simplified Chinese"),
  };
}
