// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Rule`
  String get rule {
    return Intl.message('Rule', name: 'rule', desc: '', args: []);
  }

  /// `Global`
  String get global {
    return Intl.message('Global', name: 'global', desc: '', args: []);
  }

  /// `Direct`
  String get direct {
    return Intl.message('Direct', name: 'direct', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Proxies`
  String get proxies {
    return Intl.message('Proxies', name: 'proxies', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Profiles`
  String get profiles {
    return Intl.message('Profiles', name: 'profiles', desc: '', args: []);
  }

  /// `Tools`
  String get tools {
    return Intl.message('Tools', name: 'tools', desc: '', args: []);
  }

  /// `Logs`
  String get logs {
    return Intl.message('Logs', name: 'logs', desc: '', args: []);
  }

  /// `Log capture records`
  String get logsDesc {
    return Intl.message(
      'Log capture records',
      name: 'logsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Resources`
  String get resources {
    return Intl.message('Resources', name: 'resources', desc: '', args: []);
  }

  /// `External resource related info`
  String get resourcesDesc {
    return Intl.message(
      'External resource related info',
      name: 'resourcesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Traffic usage`
  String get trafficUsage {
    return Intl.message(
      'Traffic usage',
      name: 'trafficUsage',
      desc: '',
      args: [],
    );
  }

  /// `Core info`
  String get coreInfo {
    return Intl.message('Core info', name: 'coreInfo', desc: '', args: []);
  }

  /// `Network speed`
  String get networkSpeed {
    return Intl.message(
      'Network speed',
      name: 'networkSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Outbound mode`
  String get outboundMode {
    return Intl.message(
      'Outbound mode',
      name: 'outboundMode',
      desc: '',
      args: [],
    );
  }

  /// `Network detection`
  String get networkDetection {
    return Intl.message(
      'Network detection',
      name: 'networkDetection',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message('Upload', name: 'upload', desc: '', args: []);
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `No proxy`
  String get noProxy {
    return Intl.message('No proxy', name: 'noProxy', desc: '', args: []);
  }

  /// `Please create a profile or add a valid profile`
  String get noProxyDesc {
    return Intl.message(
      'Please create a profile or add a valid profile',
      name: 'noProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `No profile, Please add a profile`
  String get nullProfileDesc {
    return Intl.message(
      'No profile, Please add a profile',
      name: 'nullProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Default`
  String get defaultText {
    return Intl.message('Default', name: 'defaultText', desc: '', args: []);
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Checking...`
  String get domainStatusChecking {
    return Intl.message(
      'Checking...',
      name: 'domainStatusChecking',
      desc: '',
      args: [],
    );
  }

  /// `Service Available`
  String get domainStatusAvailable {
    return Intl.message(
      'Service Available',
      name: 'domainStatusAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Service Unavailable`
  String get domainStatusUnavailable {
    return Intl.message(
      'Service Unavailable',
      name: 'domainStatusUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message('English', name: 'en', desc: '', args: []);
  }

  /// `Japanese`
  String get ja {
    return Intl.message('Japanese', name: 'ja', desc: '', args: []);
  }

  /// `Russian`
  String get ru {
    return Intl.message('Russian', name: 'ru', desc: '', args: []);
  }

  /// `Simplified Chinese`
  String get zh_CN {
    return Intl.message(
      'Simplified Chinese',
      name: 'zh_CN',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Set dark mode,adjust the color`
  String get themeDesc {
    return Intl.message(
      'Set dark mode,adjust the color',
      name: 'themeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Override`
  String get override {
    return Intl.message('Override', name: 'override', desc: '', args: []);
  }

  /// `Override Proxy related config`
  String get overrideDesc {
    return Intl.message(
      'Override Proxy related config',
      name: 'overrideDesc',
      desc: '',
      args: [],
    );
  }

  /// `AllowLan`
  String get allowLan {
    return Intl.message('AllowLan', name: 'allowLan', desc: '', args: []);
  }

  /// `Allow access proxy through the LAN`
  String get allowLanDesc {
    return Intl.message(
      'Allow access proxy through the LAN',
      name: 'allowLanDesc',
      desc: '',
      args: [],
    );
  }

  /// `TUN`
  String get tun {
    return Intl.message('TUN', name: 'tun', desc: '', args: []);
  }

  /// `only effective in administrator mode`
  String get tunDesc {
    return Intl.message(
      'only effective in administrator mode',
      name: 'tunDesc',
      desc: '',
      args: [],
    );
  }

  /// `Minimize on exit`
  String get minimizeOnExit {
    return Intl.message(
      'Minimize on exit',
      name: 'minimizeOnExit',
      desc: '',
      args: [],
    );
  }

  /// `Modify the default system exit event`
  String get minimizeOnExitDesc {
    return Intl.message(
      'Modify the default system exit event',
      name: 'minimizeOnExitDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto launch`
  String get autoLaunch {
    return Intl.message('Auto launch', name: 'autoLaunch', desc: '', args: []);
  }

  /// `Follow the system self startup`
  String get autoLaunchDesc {
    return Intl.message(
      'Follow the system self startup',
      name: 'autoLaunchDesc',
      desc: '',
      args: [],
    );
  }

  /// `SilentLaunch`
  String get silentLaunch {
    return Intl.message(
      'SilentLaunch',
      name: 'silentLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Start in the background`
  String get silentLaunchDesc {
    return Intl.message(
      'Start in the background',
      name: 'silentLaunchDesc',
      desc: '',
      args: [],
    );
  }

  /// `AutoRun`
  String get autoRun {
    return Intl.message('AutoRun', name: 'autoRun', desc: '', args: []);
  }

  /// `Auto run when the application is opened`
  String get autoRunDesc {
    return Intl.message(
      'Auto run when the application is opened',
      name: 'autoRunDesc',
      desc: '',
      args: [],
    );
  }

  /// `Logcat`
  String get logcat {
    return Intl.message('Logcat', name: 'logcat', desc: '', args: []);
  }

  /// `Disabling will hide the log entry`
  String get logcatDesc {
    return Intl.message(
      'Disabling will hide the log entry',
      name: 'logcatDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto check updates`
  String get autoCheckUpdate {
    return Intl.message(
      'Auto check updates',
      name: 'autoCheckUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Auto check for updates when the app starts`
  String get autoCheckUpdateDesc {
    return Intl.message(
      'Auto check for updates when the app starts',
      name: 'autoCheckUpdateDesc',
      desc: '',
      args: [],
    );
  }

  /// `AccessControl`
  String get accessControl {
    return Intl.message(
      'AccessControl',
      name: 'accessControl',
      desc: '',
      args: [],
    );
  }

  /// `Configure application access proxy`
  String get accessControlDesc {
    return Intl.message(
      'Configure application access proxy',
      name: 'accessControlDesc',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get application {
    return Intl.message('Application', name: 'application', desc: '', args: []);
  }

  /// `Modify application related settings`
  String get applicationDesc {
    return Intl.message(
      'Modify application related settings',
      name: 'applicationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Years`
  String get years {
    return Intl.message('Years', name: 'years', desc: '', args: []);
  }

  /// `Months`
  String get months {
    return Intl.message('Months', name: 'months', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Minutes`
  String get minutes {
    return Intl.message('Minutes', name: 'minutes', desc: '', args: []);
  }

  /// `Seconds`
  String get seconds {
    return Intl.message('Seconds', name: 'seconds', desc: '', args: []);
  }

  /// ` Ago`
  String get ago {
    return Intl.message(' Ago', name: 'ago', desc: '', args: []);
  }

  /// `Just`
  String get just {
    return Intl.message('Just', name: 'just', desc: '', args: []);
  }

  /// `QR code`
  String get qrcode {
    return Intl.message('QR code', name: 'qrcode', desc: '', args: []);
  }

  /// `Scan QR code to obtain profile`
  String get qrcodeDesc {
    return Intl.message(
      'Scan QR code to obtain profile',
      name: 'qrcodeDesc',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get url {
    return Intl.message('URL', name: 'url', desc: '', args: []);
  }

  /// `Obtain profile through URL`
  String get urlDesc {
    return Intl.message(
      'Obtain profile through URL',
      name: 'urlDesc',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get file {
    return Intl.message('File', name: 'file', desc: '', args: []);
  }

  /// `Directly upload profile`
  String get fileDesc {
    return Intl.message(
      'Directly upload profile',
      name: 'fileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Please input the profile name`
  String get profileNameNullValidationDesc {
    return Intl.message(
      'Please input the profile name',
      name: 'profileNameNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input the profile URL`
  String get profileUrlNullValidationDesc {
    return Intl.message(
      'Please input the profile URL',
      name: 'profileUrlNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input a valid profile URL`
  String get profileUrlInvalidValidationDesc {
    return Intl.message(
      'Please input a valid profile URL',
      name: 'profileUrlInvalidValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto update`
  String get autoUpdate {
    return Intl.message('Auto update', name: 'autoUpdate', desc: '', args: []);
  }

  /// `Auto update interval (minutes)`
  String get autoUpdateInterval {
    return Intl.message(
      'Auto update interval (minutes)',
      name: 'autoUpdateInterval',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the auto update interval time`
  String get profileAutoUpdateIntervalNullValidationDesc {
    return Intl.message(
      'Please enter the auto update interval time',
      name: 'profileAutoUpdateIntervalNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input a valid interval time format`
  String get profileAutoUpdateIntervalInvalidValidationDesc {
    return Intl.message(
      'Please input a valid interval time format',
      name: 'profileAutoUpdateIntervalInvalidValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Theme mode`
  String get themeMode {
    return Intl.message('Theme mode', name: 'themeMode', desc: '', args: []);
  }

  /// `Theme color`
  String get themeColor {
    return Intl.message('Theme color', name: 'themeColor', desc: '', args: []);
  }

  /// `Preview`
  String get preview {
    return Intl.message('Preview', name: 'preview', desc: '', args: []);
  }

  /// `Auto`
  String get auto {
    return Intl.message('Auto', name: 'auto', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Import from URL`
  String get importFromURL {
    return Intl.message(
      'Import from URL',
      name: 'importFromURL',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Do you want to pass`
  String get doYouWantToPass {
    return Intl.message(
      'Do you want to pass',
      name: 'doYouWantToPass',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Sort by default`
  String get defaultSort {
    return Intl.message(
      'Sort by default',
      name: 'defaultSort',
      desc: '',
      args: [],
    );
  }

  /// `Sort by delay`
  String get delaySort {
    return Intl.message('Sort by delay', name: 'delaySort', desc: '', args: []);
  }

  /// `Sort by name`
  String get nameSort {
    return Intl.message('Sort by name', name: 'nameSort', desc: '', args: []);
  }

  /// `Please upload file`
  String get pleaseUploadFile {
    return Intl.message(
      'Please upload file',
      name: 'pleaseUploadFile',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a valid QR code`
  String get pleaseUploadValidQrcode {
    return Intl.message(
      'Please upload a valid QR code',
      name: 'pleaseUploadValidQrcode',
      desc: '',
      args: [],
    );
  }

  /// `Blacklist mode`
  String get blacklistMode {
    return Intl.message(
      'Blacklist mode',
      name: 'blacklistMode',
      desc: '',
      args: [],
    );
  }

  /// `Whitelist mode`
  String get whitelistMode {
    return Intl.message(
      'Whitelist mode',
      name: 'whitelistMode',
      desc: '',
      args: [],
    );
  }

  /// `Filter system app`
  String get filterSystemApp {
    return Intl.message(
      'Filter system app',
      name: 'filterSystemApp',
      desc: '',
      args: [],
    );
  }

  /// `Cancel filter system app`
  String get cancelFilterSystemApp {
    return Intl.message(
      'Cancel filter system app',
      name: 'cancelFilterSystemApp',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get selectAll {
    return Intl.message('Select all', name: 'selectAll', desc: '', args: []);
  }

  /// `Cancel select all`
  String get cancelSelectAll {
    return Intl.message(
      'Cancel select all',
      name: 'cancelSelectAll',
      desc: '',
      args: [],
    );
  }

  /// `App access control`
  String get appAccessControl {
    return Intl.message(
      'App access control',
      name: 'appAccessControl',
      desc: '',
      args: [],
    );
  }

  /// `Only allow selected app to enter VPN`
  String get accessControlAllowDesc {
    return Intl.message(
      'Only allow selected app to enter VPN',
      name: 'accessControlAllowDesc',
      desc: '',
      args: [],
    );
  }

  /// `The selected application will be excluded from VPN`
  String get accessControlNotAllowDesc {
    return Intl.message(
      'The selected application will be excluded from VPN',
      name: 'accessControlNotAllowDesc',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `unable to update current profile`
  String get unableToUpdateCurrentProfileDesc {
    return Intl.message(
      'unable to update current profile',
      name: 'unableToUpdateCurrentProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `No more info`
  String get noMoreInfoDesc {
    return Intl.message(
      'No more info',
      name: 'noMoreInfoDesc',
      desc: '',
      args: [],
    );
  }

  /// `profile parse error`
  String get profileParseErrorDesc {
    return Intl.message(
      'profile parse error',
      name: 'profileParseErrorDesc',
      desc: '',
      args: [],
    );
  }

  /// `ProxyPort`
  String get proxyPort {
    return Intl.message('ProxyPort', name: 'proxyPort', desc: '', args: []);
  }

  /// `Set the Clash listening port`
  String get proxyPortDesc {
    return Intl.message(
      'Set the Clash listening port',
      name: 'proxyPortDesc',
      desc: '',
      args: [],
    );
  }

  /// `Port`
  String get port {
    return Intl.message('Port', name: 'port', desc: '', args: []);
  }

  /// `LogLevel`
  String get logLevel {
    return Intl.message('LogLevel', name: 'logLevel', desc: '', args: []);
  }

  /// `Show`
  String get show {
    return Intl.message('Show', name: 'show', desc: '', args: []);
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `System proxy`
  String get systemProxy {
    return Intl.message(
      'System proxy',
      name: 'systemProxy',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get project {
    return Intl.message('Project', name: 'project', desc: '', args: []);
  }

  /// `Core`
  String get core {
    return Intl.message('Core', name: 'core', desc: '', args: []);
  }

  /// `Tab animation`
  String get tabAnimation {
    return Intl.message(
      'Tab animation',
      name: 'tabAnimation',
      desc: '',
      args: [],
    );
  }

  /// `A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.`
  String get desc {
    return Intl.message(
      'A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Starting VPN...`
  String get startVpn {
    return Intl.message(
      'Starting VPN...',
      name: 'startVpn',
      desc: '',
      args: [],
    );
  }

  /// `Stopping VPN...`
  String get stopVpn {
    return Intl.message('Stopping VPN...', name: 'stopVpn', desc: '', args: []);
  }

  /// `Discovery a new version`
  String get discovery {
    return Intl.message(
      'Discovery a new version',
      name: 'discovery',
      desc: '',
      args: [],
    );
  }

  /// `Compatibility mode`
  String get compatible {
    return Intl.message(
      'Compatibility mode',
      name: 'compatible',
      desc: '',
      args: [],
    );
  }

  /// `Opening it will lose part of its application ability and gain the support of full amount of Clash.`
  String get compatibleDesc {
    return Intl.message(
      'Opening it will lose part of its application ability and gain the support of full amount of Clash.',
      name: 'compatibleDesc',
      desc: '',
      args: [],
    );
  }

  /// `The current proxy group cannot be selected.`
  String get notSelectedTip {
    return Intl.message(
      'The current proxy group cannot be selected.',
      name: 'notSelectedTip',
      desc: '',
      args: [],
    );
  }

  /// `tip`
  String get tip {
    return Intl.message('tip', name: 'tip', desc: '', args: []);
  }

  /// `Backup and Recovery`
  String get backupAndRecovery {
    return Intl.message(
      'Backup and Recovery',
      name: 'backupAndRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Sync data via WebDAV or file`
  String get backupAndRecoveryDesc {
    return Intl.message(
      'Sync data via WebDAV or file',
      name: 'backupAndRecoveryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Backup`
  String get backup {
    return Intl.message('Backup', name: 'backup', desc: '', args: []);
  }

  /// `Recovery`
  String get recovery {
    return Intl.message('Recovery', name: 'recovery', desc: '', args: []);
  }

  /// `Only recovery profiles`
  String get recoveryProfiles {
    return Intl.message(
      'Only recovery profiles',
      name: 'recoveryProfiles',
      desc: '',
      args: [],
    );
  }

  /// `Recovery all data`
  String get recoveryAll {
    return Intl.message(
      'Recovery all data',
      name: 'recoveryAll',
      desc: '',
      args: [],
    );
  }

  /// `Recovery success`
  String get recoverySuccess {
    return Intl.message(
      'Recovery success',
      name: 'recoverySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Backup success`
  String get backupSuccess {
    return Intl.message(
      'Backup success',
      name: 'backupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No info`
  String get noInfo {
    return Intl.message('No info', name: 'noInfo', desc: '', args: []);
  }

  /// `Please bind WebDAV`
  String get pleaseBindWebDAV {
    return Intl.message(
      'Please bind WebDAV',
      name: 'pleaseBindWebDAV',
      desc: '',
      args: [],
    );
  }

  /// `Bind`
  String get bind {
    return Intl.message('Bind', name: 'bind', desc: '', args: []);
  }

  /// `Connectivity：`
  String get connectivity {
    return Intl.message(
      'Connectivity：',
      name: 'connectivity',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV configuration`
  String get webDAVConfiguration {
    return Intl.message(
      'WebDAV configuration',
      name: 'webDAVConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `WebDAV server address`
  String get addressHelp {
    return Intl.message(
      'WebDAV server address',
      name: 'addressHelp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid WebDAV address`
  String get addressTip {
    return Intl.message(
      'Please enter a valid WebDAV address',
      name: 'addressTip',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Check for updates`
  String get checkUpdate {
    return Intl.message(
      'Check for updates',
      name: 'checkUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Discover the new version`
  String get discoverNewVersion {
    return Intl.message(
      'Discover the new version',
      name: 'discoverNewVersion',
      desc: '',
      args: [],
    );
  }

  /// `The current application is already the latest version`
  String get checkUpdateError {
    return Intl.message(
      'The current application is already the latest version',
      name: 'checkUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Go to download`
  String get goDownload {
    return Intl.message(
      'Go to download',
      name: 'goDownload',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `GeoData`
  String get geoData {
    return Intl.message('GeoData', name: 'geoData', desc: '', args: []);
  }

  /// `External resources`
  String get externalResources {
    return Intl.message(
      'External resources',
      name: 'externalResources',
      desc: '',
      args: [],
    );
  }

  /// `Checking...`
  String get checking {
    return Intl.message('Checking...', name: 'checking', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Check error`
  String get checkError {
    return Intl.message('Check error', name: 'checkError', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Allow applications to bypass VPN`
  String get allowBypass {
    return Intl.message(
      'Allow applications to bypass VPN',
      name: 'allowBypass',
      desc: '',
      args: [],
    );
  }

  /// `Some apps can bypass VPN when turned on`
  String get allowBypassDesc {
    return Intl.message(
      'Some apps can bypass VPN when turned on',
      name: 'allowBypassDesc',
      desc: '',
      args: [],
    );
  }

  /// `ExternalController`
  String get externalController {
    return Intl.message(
      'ExternalController',
      name: 'externalController',
      desc: '',
      args: [],
    );
  }

  /// `Once enabled, the Clash kernel can be controlled on port 9090`
  String get externalControllerDesc {
    return Intl.message(
      'Once enabled, the Clash kernel can be controlled on port 9090',
      name: 'externalControllerDesc',
      desc: '',
      args: [],
    );
  }

  /// `When turned on it will be able to receive IPv6 traffic`
  String get ipv6Desc {
    return Intl.message(
      'When turned on it will be able to receive IPv6 traffic',
      name: 'ipv6Desc',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get app {
    return Intl.message('App', name: 'app', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Attach HTTP proxy to VpnService`
  String get vpnSystemProxyDesc {
    return Intl.message(
      'Attach HTTP proxy to VpnService',
      name: 'vpnSystemProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Attach HTTP proxy to VpnService`
  String get systemProxyDesc {
    return Intl.message(
      'Attach HTTP proxy to VpnService',
      name: 'systemProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Unified delay`
  String get unifiedDelay {
    return Intl.message(
      'Unified delay',
      name: 'unifiedDelay',
      desc: '',
      args: [],
    );
  }

  /// `Remove extra delays such as handshaking`
  String get unifiedDelayDesc {
    return Intl.message(
      'Remove extra delays such as handshaking',
      name: 'unifiedDelayDesc',
      desc: '',
      args: [],
    );
  }

  /// `TCP concurrent`
  String get tcpConcurrent {
    return Intl.message(
      'TCP concurrent',
      name: 'tcpConcurrent',
      desc: '',
      args: [],
    );
  }

  /// `Enabling it will allow TCP concurrency`
  String get tcpConcurrentDesc {
    return Intl.message(
      'Enabling it will allow TCP concurrency',
      name: 'tcpConcurrentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Geo Low Memory Mode`
  String get geodataLoader {
    return Intl.message(
      'Geo Low Memory Mode',
      name: 'geodataLoader',
      desc: '',
      args: [],
    );
  }

  /// `Enabling will use the Geo low memory loader`
  String get geodataLoaderDesc {
    return Intl.message(
      'Enabling will use the Geo low memory loader',
      name: 'geodataLoaderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message('Requests', name: 'requests', desc: '', args: []);
  }

  /// `View recently request records`
  String get requestsDesc {
    return Intl.message(
      'View recently request records',
      name: 'requestsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Find process`
  String get findProcessMode {
    return Intl.message(
      'Find process',
      name: 'findProcessMode',
      desc: '',
      args: [],
    );
  }

  /// `Init`
  String get init {
    return Intl.message('Init', name: 'init', desc: '', args: []);
  }

  /// `Long term effective`
  String get infiniteTime {
    return Intl.message(
      'Long term effective',
      name: 'infiniteTime',
      desc: '',
      args: [],
    );
  }

  /// `Expiration time`
  String get expirationTime {
    return Intl.message(
      'Expiration time',
      name: 'expirationTime',
      desc: '',
      args: [],
    );
  }

  /// `Connections`
  String get connections {
    return Intl.message('Connections', name: 'connections', desc: '', args: []);
  }

  /// `View current connections data`
  String get connectionsDesc {
    return Intl.message(
      'View current connections data',
      name: 'connectionsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Plans`
  String get plans {
    return Intl.message('Plans', name: 'plans', desc: '', args: []);
  }

  /// `Online Support`
  String get onlineSupport {
    return Intl.message(
      'Online Support',
      name: 'onlineSupport',
      desc: '',
      args: [],
    );
  }

  /// `Intranet IP`
  String get intranetIP {
    return Intl.message('Intranet IP', name: 'intranetIP', desc: '', args: []);
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Cut`
  String get cut {
    return Intl.message('Cut', name: 'cut', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Paste`
  String get paste {
    return Intl.message('Paste', name: 'paste', desc: '', args: []);
  }

  /// `Test url`
  String get testUrl {
    return Intl.message('Test url', name: 'testUrl', desc: '', args: []);
  }

  /// `Sync`
  String get sync {
    return Intl.message('Sync', name: 'sync', desc: '', args: []);
  }

  /// `Hidden from recent tasks`
  String get exclude {
    return Intl.message(
      'Hidden from recent tasks',
      name: 'exclude',
      desc: '',
      args: [],
    );
  }

  /// `When the app is in the background, the app is hidden from the recent task`
  String get excludeDesc {
    return Intl.message(
      'When the app is in the background, the app is hidden from the recent task',
      name: 'excludeDesc',
      desc: '',
      args: [],
    );
  }

  /// `One column`
  String get oneColumn {
    return Intl.message('One column', name: 'oneColumn', desc: '', args: []);
  }

  /// `Two columns`
  String get twoColumns {
    return Intl.message('Two columns', name: 'twoColumns', desc: '', args: []);
  }

  /// `Three columns`
  String get threeColumns {
    return Intl.message(
      'Three columns',
      name: 'threeColumns',
      desc: '',
      args: [],
    );
  }

  /// `Four columns`
  String get fourColumns {
    return Intl.message(
      'Four columns',
      name: 'fourColumns',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get expand {
    return Intl.message('Standard', name: 'expand', desc: '', args: []);
  }

  /// `Shrink`
  String get shrink {
    return Intl.message('Shrink', name: 'shrink', desc: '', args: []);
  }

  /// `Min`
  String get min {
    return Intl.message('Min', name: 'min', desc: '', args: []);
  }

  /// `Tab`
  String get tab {
    return Intl.message('Tab', name: 'tab', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `Delay`
  String get delay {
    return Intl.message('Delay', name: 'delay', desc: '', args: []);
  }

  /// `Style`
  String get style {
    return Intl.message('Style', name: 'style', desc: '', args: []);
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `Sort`
  String get sort {
    return Intl.message('Sort', name: 'sort', desc: '', args: []);
  }

  /// `Columns`
  String get columns {
    return Intl.message('Columns', name: 'columns', desc: '', args: []);
  }

  /// `Proxies setting`
  String get proxiesSetting {
    return Intl.message(
      'Proxies setting',
      name: 'proxiesSetting',
      desc: '',
      args: [],
    );
  }

  /// `Proxy group`
  String get proxyGroup {
    return Intl.message('Proxy group', name: 'proxyGroup', desc: '', args: []);
  }

  /// `Go`
  String get go {
    return Intl.message('Go', name: 'go', desc: '', args: []);
  }

  /// `External link`
  String get externalLink {
    return Intl.message(
      'External link',
      name: 'externalLink',
      desc: '',
      args: [],
    );
  }

  /// `Other contributors`
  String get otherContributors {
    return Intl.message(
      'Other contributors',
      name: 'otherContributors',
      desc: '',
      args: [],
    );
  }

  /// `Auto close connections`
  String get autoCloseConnections {
    return Intl.message(
      'Auto close connections',
      name: 'autoCloseConnections',
      desc: '',
      args: [],
    );
  }

  /// `Auto close connections after change node`
  String get autoCloseConnectionsDesc {
    return Intl.message(
      'Auto close connections after change node',
      name: 'autoCloseConnectionsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Only statistics proxy`
  String get onlyStatisticsProxy {
    return Intl.message(
      'Only statistics proxy',
      name: 'onlyStatisticsProxy',
      desc: '',
      args: [],
    );
  }

  /// `When turned on, only statistics proxy traffic`
  String get onlyStatisticsProxyDesc {
    return Intl.message(
      'When turned on, only statistics proxy traffic',
      name: 'onlyStatisticsProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Pure black mode`
  String get pureBlackMode {
    return Intl.message(
      'Pure black mode',
      name: 'pureBlackMode',
      desc: '',
      args: [],
    );
  }

  /// `Tcp keep alive interval`
  String get keepAliveIntervalDesc {
    return Intl.message(
      'Tcp keep alive interval',
      name: 'keepAliveIntervalDesc',
      desc: '',
      args: [],
    );
  }

  /// ` entries`
  String get entries {
    return Intl.message(' entries', name: 'entries', desc: '', args: []);
  }

  /// `Local`
  String get local {
    return Intl.message('Local', name: 'local', desc: '', args: []);
  }

  /// `Remote`
  String get remote {
    return Intl.message('Remote', name: 'remote', desc: '', args: []);
  }

  /// `Backup local data to WebDAV`
  String get remoteBackupDesc {
    return Intl.message(
      'Backup local data to WebDAV',
      name: 'remoteBackupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Recovery data from WebDAV`
  String get remoteRecoveryDesc {
    return Intl.message(
      'Recovery data from WebDAV',
      name: 'remoteRecoveryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Backup local data to local`
  String get localBackupDesc {
    return Intl.message(
      'Backup local data to local',
      name: 'localBackupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Recovery data from file`
  String get localRecoveryDesc {
    return Intl.message(
      'Recovery data from file',
      name: 'localRecoveryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get mode {
    return Intl.message('Mode', name: 'mode', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Source`
  String get source {
    return Intl.message('Source', name: 'source', desc: '', args: []);
  }

  /// `All apps`
  String get allApps {
    return Intl.message('All apps', name: 'allApps', desc: '', args: []);
  }

  /// `Only third-party apps`
  String get onlyOtherApps {
    return Intl.message(
      'Only third-party apps',
      name: 'onlyOtherApps',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message('Action', name: 'action', desc: '', args: []);
  }

  /// `Intelligent selection`
  String get intelligentSelected {
    return Intl.message(
      'Intelligent selection',
      name: 'intelligentSelected',
      desc: '',
      args: [],
    );
  }

  /// `Clipboard import`
  String get clipboardImport {
    return Intl.message(
      'Clipboard import',
      name: 'clipboardImport',
      desc: '',
      args: [],
    );
  }

  /// `Export clipboard`
  String get clipboardExport {
    return Intl.message(
      'Export clipboard',
      name: 'clipboardExport',
      desc: '',
      args: [],
    );
  }

  /// `Layout`
  String get layout {
    return Intl.message('Layout', name: 'layout', desc: '', args: []);
  }

  /// `Tight`
  String get tight {
    return Intl.message('Tight', name: 'tight', desc: '', args: []);
  }

  /// `Standard`
  String get standard {
    return Intl.message('Standard', name: 'standard', desc: '', args: []);
  }

  /// `Loose`
  String get loose {
    return Intl.message('Loose', name: 'loose', desc: '', args: []);
  }

  /// `Profiles sort`
  String get profilesSort {
    return Intl.message(
      'Profiles sort',
      name: 'profilesSort',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Stop`
  String get stop {
    return Intl.message('Stop', name: 'stop', desc: '', args: []);
  }

  /// `Processing app related settings`
  String get appDesc {
    return Intl.message(
      'Processing app related settings',
      name: 'appDesc',
      desc: '',
      args: [],
    );
  }

  /// `Modify VPN related settings`
  String get vpnDesc {
    return Intl.message(
      'Modify VPN related settings',
      name: 'vpnDesc',
      desc: '',
      args: [],
    );
  }

  /// `Update DNS related settings`
  String get dnsDesc {
    return Intl.message(
      'Update DNS related settings',
      name: 'dnsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Key`
  String get key {
    return Intl.message('Key', name: 'key', desc: '', args: []);
  }

  /// `Value`
  String get value {
    return Intl.message('Value', name: 'value', desc: '', args: []);
  }

  /// `Add Hosts`
  String get hostsDesc {
    return Intl.message('Add Hosts', name: 'hostsDesc', desc: '', args: []);
  }

  /// `Changes take effect after restarting the VPN`
  String get vpnTip {
    return Intl.message(
      'Changes take effect after restarting the VPN',
      name: 'vpnTip',
      desc: '',
      args: [],
    );
  }

  /// `Auto routes all system traffic through VpnService`
  String get vpnEnableDesc {
    return Intl.message(
      'Auto routes all system traffic through VpnService',
      name: 'vpnEnableDesc',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message('Options', name: 'options', desc: '', args: []);
  }

  /// `Loopback unlock tool`
  String get loopback {
    return Intl.message(
      'Loopback unlock tool',
      name: 'loopback',
      desc: '',
      args: [],
    );
  }

  /// `Used for UWP loopback unlocking`
  String get loopbackDesc {
    return Intl.message(
      'Used for UWP loopback unlocking',
      name: 'loopbackDesc',
      desc: '',
      args: [],
    );
  }

  /// `Providers`
  String get providers {
    return Intl.message('Providers', name: 'providers', desc: '', args: []);
  }

  /// `Proxy providers`
  String get proxyProviders {
    return Intl.message(
      'Proxy providers',
      name: 'proxyProviders',
      desc: '',
      args: [],
    );
  }

  /// `Rule providers`
  String get ruleProviders {
    return Intl.message(
      'Rule providers',
      name: 'ruleProviders',
      desc: '',
      args: [],
    );
  }

  /// `Override Dns`
  String get overrideDns {
    return Intl.message(
      'Override Dns',
      name: 'overrideDns',
      desc: '',
      args: [],
    );
  }

  /// `Turning it on will override the DNS options in the profile`
  String get overrideDnsDesc {
    return Intl.message(
      'Turning it on will override the DNS options in the profile',
      name: 'overrideDnsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `System DNS will be used when turned off`
  String get statusDesc {
    return Intl.message(
      'System DNS will be used when turned off',
      name: 'statusDesc',
      desc: '',
      args: [],
    );
  }

  /// `Prioritize the use of DOH's http/3`
  String get preferH3Desc {
    return Intl.message(
      'Prioritize the use of DOH\'s http/3',
      name: 'preferH3Desc',
      desc: '',
      args: [],
    );
  }

  /// `Respect rules`
  String get respectRules {
    return Intl.message(
      'Respect rules',
      name: 'respectRules',
      desc: '',
      args: [],
    );
  }

  /// `DNS connection following rules, need to configure proxy-server-nameserver`
  String get respectRulesDesc {
    return Intl.message(
      'DNS connection following rules, need to configure proxy-server-nameserver',
      name: 'respectRulesDesc',
      desc: '',
      args: [],
    );
  }

  /// `DNS mode`
  String get dnsMode {
    return Intl.message('DNS mode', name: 'dnsMode', desc: '', args: []);
  }

  /// `Fakeip range`
  String get fakeipRange {
    return Intl.message(
      'Fakeip range',
      name: 'fakeipRange',
      desc: '',
      args: [],
    );
  }

  /// `Fakeip filter`
  String get fakeipFilter {
    return Intl.message(
      'Fakeip filter',
      name: 'fakeipFilter',
      desc: '',
      args: [],
    );
  }

  /// `Default nameserver`
  String get defaultNameserver {
    return Intl.message(
      'Default nameserver',
      name: 'defaultNameserver',
      desc: '',
      args: [],
    );
  }

  /// `For resolving DNS server`
  String get defaultNameserverDesc {
    return Intl.message(
      'For resolving DNS server',
      name: 'defaultNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Nameserver`
  String get nameserver {
    return Intl.message('Nameserver', name: 'nameserver', desc: '', args: []);
  }

  /// `For resolving domain`
  String get nameserverDesc {
    return Intl.message(
      'For resolving domain',
      name: 'nameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Use hosts`
  String get useHosts {
    return Intl.message('Use hosts', name: 'useHosts', desc: '', args: []);
  }

  /// `Use system hosts`
  String get useSystemHosts {
    return Intl.message(
      'Use system hosts',
      name: 'useSystemHosts',
      desc: '',
      args: [],
    );
  }

  /// `Nameserver policy`
  String get nameserverPolicy {
    return Intl.message(
      'Nameserver policy',
      name: 'nameserverPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Specify the corresponding nameserver policy`
  String get nameserverPolicyDesc {
    return Intl.message(
      'Specify the corresponding nameserver policy',
      name: 'nameserverPolicyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Proxy nameserver`
  String get proxyNameserver {
    return Intl.message(
      'Proxy nameserver',
      name: 'proxyNameserver',
      desc: '',
      args: [],
    );
  }

  /// `Domain for resolving proxy nodes`
  String get proxyNameserverDesc {
    return Intl.message(
      'Domain for resolving proxy nodes',
      name: 'proxyNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fallback`
  String get fallback {
    return Intl.message('Fallback', name: 'fallback', desc: '', args: []);
  }

  /// `Generally use offshore DNS`
  String get fallbackDesc {
    return Intl.message(
      'Generally use offshore DNS',
      name: 'fallbackDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fallback filter`
  String get fallbackFilter {
    return Intl.message(
      'Fallback filter',
      name: 'fallbackFilter',
      desc: '',
      args: [],
    );
  }

  /// `Geoip code`
  String get geoipCode {
    return Intl.message('Geoip code', name: 'geoipCode', desc: '', args: []);
  }

  /// `Ipcidr`
  String get ipcidr {
    return Intl.message('Ipcidr', name: 'ipcidr', desc: '', args: []);
  }

  /// `Domain`
  String get domain {
    return Intl.message('Domain', name: 'domain', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Show/Hide`
  String get action_view {
    return Intl.message('Show/Hide', name: 'action_view', desc: '', args: []);
  }

  /// `Start/Stop`
  String get action_start {
    return Intl.message('Start/Stop', name: 'action_start', desc: '', args: []);
  }

  /// `Switch mode`
  String get action_mode {
    return Intl.message('Switch mode', name: 'action_mode', desc: '', args: []);
  }

  /// `System proxy`
  String get action_proxy {
    return Intl.message(
      'System proxy',
      name: 'action_proxy',
      desc: '',
      args: [],
    );
  }

  /// `TUN`
  String get action_tun {
    return Intl.message('TUN', name: 'action_tun', desc: '', args: []);
  }

  /// `Important Notice`
  String get disclaimer {
    return Intl.message(
      'Important Notice',
      name: 'disclaimer',
      desc: '',
      args: [],
    );
  }

  /// `This software is currently in public beta. If you receive update reminders, please update promptly. Older versions may cause service instability or inability to use.`
  String get disclaimerDesc {
    return Intl.message(
      'This software is currently in public beta. If you receive update reminders, please update promptly. Older versions may cause service instability or inability to use.',
      name: 'disclaimerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message('Agree', name: 'agree', desc: '', args: []);
  }

  /// `Hotkey Management`
  String get hotkeyManagement {
    return Intl.message(
      'Hotkey Management',
      name: 'hotkeyManagement',
      desc: '',
      args: [],
    );
  }

  /// `Use keyboard to control applications`
  String get hotkeyManagementDesc {
    return Intl.message(
      'Use keyboard to control applications',
      name: 'hotkeyManagementDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please press the keyboard.`
  String get pressKeyboard {
    return Intl.message(
      'Please press the keyboard.',
      name: 'pressKeyboard',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the correct hotkey`
  String get inputCorrectHotkey {
    return Intl.message(
      'Please enter the correct hotkey',
      name: 'inputCorrectHotkey',
      desc: '',
      args: [],
    );
  }

  /// `Hotkey conflict`
  String get hotkeyConflict {
    return Intl.message(
      'Hotkey conflict',
      name: 'hotkeyConflict',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `No HotKey`
  String get noHotKey {
    return Intl.message('No HotKey', name: 'noHotKey', desc: '', args: []);
  }

  /// `No network`
  String get noNetwork {
    return Intl.message('No network', name: 'noNetwork', desc: '', args: []);
  }

  /// `Allow IPv6 inbound`
  String get ipv6InboundDesc {
    return Intl.message(
      'Allow IPv6 inbound',
      name: 'ipv6InboundDesc',
      desc: '',
      args: [],
    );
  }

  /// `Export logs`
  String get exportLogs {
    return Intl.message('Export logs', name: 'exportLogs', desc: '', args: []);
  }

  /// `Export Success`
  String get exportSuccess {
    return Intl.message(
      'Export Success',
      name: 'exportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Icon style`
  String get iconStyle {
    return Intl.message('Icon style', name: 'iconStyle', desc: '', args: []);
  }

  /// `Icon`
  String get onlyIcon {
    return Intl.message('Icon', name: 'onlyIcon', desc: '', args: []);
  }

  /// `None`
  String get noIcon {
    return Intl.message('None', name: 'noIcon', desc: '', args: []);
  }

  /// `Stack mode`
  String get stackMode {
    return Intl.message('Stack mode', name: 'stackMode', desc: '', args: []);
  }

  /// `Network`
  String get network {
    return Intl.message('Network', name: 'network', desc: '', args: []);
  }

  /// `Modify network-related settings`
  String get networkDesc {
    return Intl.message(
      'Modify network-related settings',
      name: 'networkDesc',
      desc: '',
      args: [],
    );
  }

  /// `Bypass domain`
  String get bypassDomain {
    return Intl.message(
      'Bypass domain',
      name: 'bypassDomain',
      desc: '',
      args: [],
    );
  }

  /// `Only takes effect when the system proxy is enabled`
  String get bypassDomainDesc {
    return Intl.message(
      'Only takes effect when the system proxy is enabled',
      name: 'bypassDomainDesc',
      desc: '',
      args: [],
    );
  }

  /// `Make sure to reset`
  String get resetTip {
    return Intl.message(
      'Make sure to reset',
      name: 'resetTip',
      desc: '',
      args: [],
    );
  }

  /// `RegExp`
  String get regExp {
    return Intl.message('RegExp', name: 'regExp', desc: '', args: []);
  }

  /// `Icon`
  String get icon {
    return Intl.message('Icon', name: 'icon', desc: '', args: []);
  }

  /// `Icon configuration`
  String get iconConfiguration {
    return Intl.message(
      'Icon configuration',
      name: 'iconConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message('No data', name: 'noData', desc: '', args: []);
  }

  /// `Admin auto launch`
  String get adminAutoLaunch {
    return Intl.message(
      'Admin auto launch',
      name: 'adminAutoLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Boot up by using admin mode`
  String get adminAutoLaunchDesc {
    return Intl.message(
      'Boot up by using admin mode',
      name: 'adminAutoLaunchDesc',
      desc: '',
      args: [],
    );
  }

  /// `FontFamily`
  String get fontFamily {
    return Intl.message('FontFamily', name: 'fontFamily', desc: '', args: []);
  }

  /// `System font`
  String get systemFont {
    return Intl.message('System font', name: 'systemFont', desc: '', args: []);
  }

  /// `Toggle`
  String get toggle {
    return Intl.message('Toggle', name: 'toggle', desc: '', args: []);
  }

  /// `System`
  String get system {
    return Intl.message('System', name: 'system', desc: '', args: []);
  }

  /// `Route mode`
  String get routeMode {
    return Intl.message('Route mode', name: 'routeMode', desc: '', args: []);
  }

  /// `Bypass private route address`
  String get routeMode_bypassPrivate {
    return Intl.message(
      'Bypass private route address',
      name: 'routeMode_bypassPrivate',
      desc: '',
      args: [],
    );
  }

  /// `Use config`
  String get routeMode_config {
    return Intl.message(
      'Use config',
      name: 'routeMode_config',
      desc: '',
      args: [],
    );
  }

  /// `Route address`
  String get routeAddress {
    return Intl.message(
      'Route address',
      name: 'routeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Config listen route address`
  String get routeAddressDesc {
    return Intl.message(
      'Config listen route address',
      name: 'routeAddressDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the admin password`
  String get pleaseInputAdminPassword {
    return Intl.message(
      'Please enter the admin password',
      name: 'pleaseInputAdminPassword',
      desc: '',
      args: [],
    );
  }

  /// `Copying environment variables`
  String get copyEnvVar {
    return Intl.message(
      'Copying environment variables',
      name: 'copyEnvVar',
      desc: '',
      args: [],
    );
  }

  /// `Memory info`
  String get memoryInfo {
    return Intl.message('Memory info', name: 'memoryInfo', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `The file has been modified. Do you want to save the changes?`
  String get fileIsUpdate {
    return Intl.message(
      'The file has been modified. Do you want to save the changes?',
      name: 'fileIsUpdate',
      desc: '',
      args: [],
    );
  }

  /// `The profile has been modified. Do you want to disable auto update?`
  String get profileHasUpdate {
    return Intl.message(
      'The profile has been modified. Do you want to disable auto update?',
      name: 'profileHasUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cache the changes?`
  String get hasCacheChange {
    return Intl.message(
      'Do you want to cache the changes?',
      name: 'hasCacheChange',
      desc: '',
      args: [],
    );
  }

  /// `Copy success`
  String get copySuccess {
    return Intl.message(
      'Copy success',
      name: 'copySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Copy link`
  String get copyLink {
    return Intl.message('Copy link', name: 'copyLink', desc: '', args: []);
  }

  /// `Export file`
  String get exportFile {
    return Intl.message('Export file', name: 'exportFile', desc: '', args: []);
  }

  /// `The cache is corrupt. Do you want to clear it?`
  String get cacheCorrupt {
    return Intl.message(
      'The cache is corrupt. Do you want to clear it?',
      name: 'cacheCorrupt',
      desc: '',
      args: [],
    );
  }

  /// `Relying on third-party api is for reference only`
  String get detectionTip {
    return Intl.message(
      'Relying on third-party api is for reference only',
      name: 'detectionTip',
      desc: '',
      args: [],
    );
  }

  /// `Listen`
  String get listen {
    return Intl.message('Listen', name: 'listen', desc: '', args: []);
  }

  /// `undo`
  String get undo {
    return Intl.message('undo', name: 'undo', desc: '', args: []);
  }

  /// `redo`
  String get redo {
    return Intl.message('redo', name: 'redo', desc: '', args: []);
  }

  /// `none`
  String get none {
    return Intl.message('none', name: 'none', desc: '', args: []);
  }

  /// `Basic configuration`
  String get basicConfig {
    return Intl.message(
      'Basic configuration',
      name: 'basicConfig',
      desc: '',
      args: [],
    );
  }

  /// `Modify the basic configuration globally`
  String get basicConfigDesc {
    return Intl.message(
      'Modify the basic configuration globally',
      name: 'basicConfigDesc',
      desc: '',
      args: [],
    );
  }

  /// `{count} items have been selected`
  String selectedCountTitle(Object count) {
    return Intl.message(
      '$count items have been selected',
      name: 'selectedCountTitle',
      desc: '',
      args: [count],
    );
  }

  /// `Add rule`
  String get addRule {
    return Intl.message('Add rule', name: 'addRule', desc: '', args: []);
  }

  /// `Rule name`
  String get ruleName {
    return Intl.message('Rule name', name: 'ruleName', desc: '', args: []);
  }

  /// `Content`
  String get content {
    return Intl.message('Content', name: 'content', desc: '', args: []);
  }

  /// `Sub rule`
  String get subRule {
    return Intl.message('Sub rule', name: 'subRule', desc: '', args: []);
  }

  /// `Rule target`
  String get ruleTarget {
    return Intl.message('Rule target', name: 'ruleTarget', desc: '', args: []);
  }

  /// `Source IP`
  String get sourceIp {
    return Intl.message('Source IP', name: 'sourceIp', desc: '', args: []);
  }

  /// `No resolve IP`
  String get noResolve {
    return Intl.message('No resolve IP', name: 'noResolve', desc: '', args: []);
  }

  /// `Get original rules`
  String get getOriginRules {
    return Intl.message(
      'Get original rules',
      name: 'getOriginRules',
      desc: '',
      args: [],
    );
  }

  /// `Override the original rule`
  String get overrideOriginRules {
    return Intl.message(
      'Override the original rule',
      name: 'overrideOriginRules',
      desc: '',
      args: [],
    );
  }

  /// `Attach on the original rules`
  String get addedOriginRules {
    return Intl.message(
      'Attach on the original rules',
      name: 'addedOriginRules',
      desc: '',
      args: [],
    );
  }

  /// `Enable override`
  String get enableOverride {
    return Intl.message(
      'Enable override',
      name: 'enableOverride',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to save the changes?`
  String get saveChanges {
    return Intl.message(
      'Do you want to save the changes?',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Modify general settings`
  String get generalDesc {
    return Intl.message(
      'Modify general settings',
      name: 'generalDesc',
      desc: '',
      args: [],
    );
  }

  /// `There is a certain performance loss after opening`
  String get findProcessModeDesc {
    return Intl.message(
      'There is a certain performance loss after opening',
      name: 'findProcessModeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Effective only in mobile view`
  String get tabAnimationDesc {
    return Intl.message(
      'Effective only in mobile view',
      name: 'tabAnimationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to save?`
  String get saveTip {
    return Intl.message(
      'Are you sure you want to save?',
      name: 'saveTip',
      desc: '',
      args: [],
    );
  }

  /// `Color schemes`
  String get colorSchemes {
    return Intl.message(
      'Color schemes',
      name: 'colorSchemes',
      desc: '',
      args: [],
    );
  }

  /// `Palette`
  String get palette {
    return Intl.message('Palette', name: 'palette', desc: '', args: []);
  }

  /// `TonalSpot`
  String get tonalSpotScheme {
    return Intl.message(
      'TonalSpot',
      name: 'tonalSpotScheme',
      desc: '',
      args: [],
    );
  }

  /// `Fidelity`
  String get fidelityScheme {
    return Intl.message('Fidelity', name: 'fidelityScheme', desc: '', args: []);
  }

  /// `Monochrome`
  String get monochromeScheme {
    return Intl.message(
      'Monochrome',
      name: 'monochromeScheme',
      desc: '',
      args: [],
    );
  }

  /// `Neutral`
  String get neutralScheme {
    return Intl.message('Neutral', name: 'neutralScheme', desc: '', args: []);
  }

  /// `Vibrant`
  String get vibrantScheme {
    return Intl.message('Vibrant', name: 'vibrantScheme', desc: '', args: []);
  }

  /// `Expressive`
  String get expressiveScheme {
    return Intl.message(
      'Expressive',
      name: 'expressiveScheme',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get contentScheme {
    return Intl.message('Content', name: 'contentScheme', desc: '', args: []);
  }

  /// `Rainbow`
  String get rainbowScheme {
    return Intl.message('Rainbow', name: 'rainbowScheme', desc: '', args: []);
  }

  /// `FruitSalad`
  String get fruitSaladScheme {
    return Intl.message(
      'FruitSalad',
      name: 'fruitSaladScheme',
      desc: '',
      args: [],
    );
  }

  /// `Developer mode`
  String get developerMode {
    return Intl.message(
      'Developer mode',
      name: 'developerMode',
      desc: '',
      args: [],
    );
  }

  /// `Developer mode is enabled.`
  String get developerModeEnableTip {
    return Intl.message(
      'Developer mode is enabled.',
      name: 'developerModeEnableTip',
      desc: '',
      args: [],
    );
  }

  /// `Message test`
  String get messageTest {
    return Intl.message(
      'Message test',
      name: 'messageTest',
      desc: '',
      args: [],
    );
  }

  /// `This is a message.`
  String get messageTestTip {
    return Intl.message(
      'This is a message.',
      name: 'messageTestTip',
      desc: '',
      args: [],
    );
  }

  /// `Crash test`
  String get crashTest {
    return Intl.message('Crash test', name: 'crashTest', desc: '', args: []);
  }

  /// `Clear Data`
  String get clearData {
    return Intl.message('Clear Data', name: 'clearData', desc: '', args: []);
  }

  /// `Text Scaling`
  String get textScale {
    return Intl.message('Text Scaling', name: 'textScale', desc: '', args: []);
  }

  /// `Internet`
  String get internet {
    return Intl.message('Internet', name: 'internet', desc: '', args: []);
  }

  /// `System APP`
  String get systemApp {
    return Intl.message('System APP', name: 'systemApp', desc: '', args: []);
  }

  /// `No network APP`
  String get noNetworkApp {
    return Intl.message(
      'No network APP',
      name: 'noNetworkApp',
      desc: '',
      args: [],
    );
  }

  /// `Contact me`
  String get contactMe {
    return Intl.message('Contact me', name: 'contactMe', desc: '', args: []);
  }

  /// `Recovery strategy`
  String get recoveryStrategy {
    return Intl.message(
      'Recovery strategy',
      name: 'recoveryStrategy',
      desc: '',
      args: [],
    );
  }

  /// `Override`
  String get recoveryStrategy_override {
    return Intl.message(
      'Override',
      name: 'recoveryStrategy_override',
      desc: '',
      args: [],
    );
  }

  /// `Compatible`
  String get recoveryStrategy_compatible {
    return Intl.message(
      'Compatible',
      name: 'recoveryStrategy_compatible',
      desc: '',
      args: [],
    );
  }

  /// `Logs test`
  String get logsTest {
    return Intl.message('Logs test', name: 'logsTest', desc: '', args: []);
  }

  /// `{label} cannot be empty`
  String emptyTip(Object label) {
    return Intl.message(
      '$label cannot be empty',
      name: 'emptyTip',
      desc: '',
      args: [label],
    );
  }

  /// `{label} must be a url`
  String urlTip(Object label) {
    return Intl.message(
      '$label must be a url',
      name: 'urlTip',
      desc: '',
      args: [label],
    );
  }

  /// `{label} must be a number`
  String numberTip(Object label) {
    return Intl.message(
      '$label must be a number',
      name: 'numberTip',
      desc: '',
      args: [label],
    );
  }

  /// `Interval`
  String get interval {
    return Intl.message('Interval', name: 'interval', desc: '', args: []);
  }

  /// `Current {label} already exists`
  String existsTip(Object label) {
    return Intl.message(
      'Current $label already exists',
      name: 'existsTip',
      desc: '',
      args: [label],
    );
  }

  /// `Are you sure you want to delete the current {label}?`
  String deleteTip(Object label) {
    return Intl.message(
      'Are you sure you want to delete the current $label?',
      name: 'deleteTip',
      desc: '',
      args: [label],
    );
  }

  /// `Are you sure you want to delete the selected {label}?`
  String deleteMultipTip(Object label) {
    return Intl.message(
      'Are you sure you want to delete the selected $label?',
      name: 'deleteMultipTip',
      desc: '',
      args: [label],
    );
  }

  /// `No {label} at the moment`
  String nullTip(Object label) {
    return Intl.message(
      'No $label at the moment',
      name: 'nullTip',
      desc: '',
      args: [label],
    );
  }

  /// `Script`
  String get script {
    return Intl.message('Script', name: 'script', desc: '', args: []);
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Rename`
  String get rename {
    return Intl.message('Rename', name: 'rename', desc: '', args: []);
  }

  /// `Unnamed`
  String get unnamed {
    return Intl.message('Unnamed', name: 'unnamed', desc: '', args: []);
  }

  /// `Please enter a script name`
  String get pleaseEnterScriptName {
    return Intl.message(
      'Please enter a script name',
      name: 'pleaseEnterScriptName',
      desc: '',
      args: [],
    );
  }

  /// `Does not take effect in script mode`
  String get overrideInvalidTip {
    return Intl.message(
      'Does not take effect in script mode',
      name: 'overrideInvalidTip',
      desc: '',
      args: [],
    );
  }

  /// `Mixed Port`
  String get mixedPort {
    return Intl.message('Mixed Port', name: 'mixedPort', desc: '', args: []);
  }

  /// `Socks Port`
  String get socksPort {
    return Intl.message('Socks Port', name: 'socksPort', desc: '', args: []);
  }

  /// `Redir Port`
  String get redirPort {
    return Intl.message('Redir Port', name: 'redirPort', desc: '', args: []);
  }

  /// `Tproxy Port`
  String get tproxyPort {
    return Intl.message('Tproxy Port', name: 'tproxyPort', desc: '', args: []);
  }

  /// `{label} must be between 1024 and 49151`
  String portTip(Object label) {
    return Intl.message(
      '$label must be between 1024 and 49151',
      name: 'portTip',
      desc: '',
      args: [label],
    );
  }

  /// `Please enter a different port`
  String get portConflictTip {
    return Intl.message(
      'Please enter a different port',
      name: 'portConflictTip',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message('Import', name: 'import', desc: '', args: []);
  }

  /// `Import from file`
  String get importFile {
    return Intl.message(
      'Import from file',
      name: 'importFile',
      desc: '',
      args: [],
    );
  }

  /// `Import from URL`
  String get importUrl {
    return Intl.message(
      'Import from URL',
      name: 'importUrl',
      desc: '',
      args: [],
    );
  }

  /// `Auto set system DNS`
  String get autoSetSystemDns {
    return Intl.message(
      'Auto set system DNS',
      name: 'autoSetSystemDns',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get xboardLogin {
    return Intl.message('Login', name: 'xboardLogin', desc: '', args: []);
  }

  /// `Register`
  String get xboardRegister {
    return Intl.message('Register', name: 'xboardRegister', desc: '', args: []);
  }

  /// `Logout`
  String get xboardLogout {
    return Intl.message('Logout', name: 'xboardLogout', desc: '', args: []);
  }

  /// `Email`
  String get xboardEmail {
    return Intl.message('Email', name: 'xboardEmail', desc: '', args: []);
  }

  /// `Password`
  String get xboardPassword {
    return Intl.message('Password', name: 'xboardPassword', desc: '', args: []);
  }

  /// `Confirm Password`
  String get xboardConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'xboardConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invite Code`
  String get xboardInviteCode {
    return Intl.message(
      'Invite Code',
      name: 'xboardInviteCode',
      desc: '',
      args: [],
    );
  }

  /// `Remember Password`
  String get xboardRememberPassword {
    return Intl.message(
      'Remember Password',
      name: 'xboardRememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get xboardForgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'xboardForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get xboardLoginSuccess {
    return Intl.message(
      'Login successful',
      name: 'xboardLoginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get xboardLoginFailed {
    return Intl.message(
      'Login failed',
      name: 'xboardLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful! Redirecting to login page...`
  String get xboardRegisterSuccess {
    return Intl.message(
      'Registration successful! Redirecting to login page...',
      name: 'xboardRegisterSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get xboardRegisterFailed {
    return Intl.message(
      'Registration failed',
      name: 'xboardRegisterFailed',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get xboardLogoutConfirmTitle {
    return Intl.message(
      'Confirm Logout',
      name: 'xboardLogoutConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout? You will need to re-enter your credentials.`
  String get xboardLogoutConfirmContent {
    return Intl.message(
      'Are you sure you want to logout? You will need to re-enter your credentials.',
      name: 'xboardLogoutConfirmContent',
      desc: '',
      args: [],
    );
  }

  /// `Successfully logged out`
  String get xboardLogoutSuccess {
    return Intl.message(
      'Successfully logged out',
      name: 'xboardLogoutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Logout failed`
  String get xboardLogoutFailed {
    return Intl.message(
      'Logout failed',
      name: 'xboardLogoutFailed',
      desc: '',
      args: [],
    );
  }

  /// `Login Expired`
  String get xboardTokenExpiredTitle {
    return Intl.message(
      'Login Expired',
      name: 'xboardTokenExpiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your login session has expired. Please login again to continue.`
  String get xboardTokenExpiredContent {
    return Intl.message(
      'Your login session has expired. Please login again to continue.',
      name: 'xboardTokenExpiredContent',
      desc: '',
      args: [],
    );
  }

  /// `Login Again`
  String get xboardRelogin {
    return Intl.message(
      'Login Again',
      name: 'xboardRelogin',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get xboardCancel {
    return Intl.message('Cancel', name: 'xboardCancel', desc: '', args: []);
  }

  /// `Confirm`
  String get xboardConfirm {
    return Intl.message('Confirm', name: 'xboardConfirm', desc: '', args: []);
  }

  /// `Plans`
  String get xboardPlans {
    return Intl.message('Plans', name: 'xboardPlans', desc: '', args: []);
  }

  /// `Subscription`
  String get xboardSubscription {
    return Intl.message(
      'Subscription',
      name: 'xboardSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Current Node`
  String get xboardCurrentNode {
    return Intl.message(
      'Current Node',
      name: 'xboardCurrentNode',
      desc: '',
      args: [],
    );
  }

  /// `Node Name`
  String get xboardNodeName {
    return Intl.message(
      'Node Name',
      name: 'xboardNodeName',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get xboardGroup {
    return Intl.message('Group', name: 'xboardGroup', desc: '', args: []);
  }

  /// `Profile`
  String get xboardProfile {
    return Intl.message('Profile', name: 'xboardProfile', desc: '', args: []);
  }

  /// `Local IP`
  String get xboardLocalIP {
    return Intl.message('Local IP', name: 'xboardLocalIP', desc: '', args: []);
  }

  /// `Getting...`
  String get xboardGettingIP {
    return Intl.message(
      'Getting...',
      name: 'xboardGettingIP',
      desc: '',
      args: [],
    );
  }

  /// `Unknown User`
  String get xboardUnknownUser {
    return Intl.message(
      'Unknown User',
      name: 'xboardUnknownUser',
      desc: '',
      args: [],
    );
  }

  /// `Logged In`
  String get xboardLoggedIn {
    return Intl.message(
      'Logged In',
      name: 'xboardLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Not Logged In`
  String get xboardNotLoggedIn {
    return Intl.message(
      'Not Logged In',
      name: 'xboardNotLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Unselected`
  String get xboardUnselected {
    return Intl.message(
      'Unselected',
      name: 'xboardUnselected',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get xboardNone {
    return Intl.message('None', name: 'xboardNone', desc: '', args: []);
  }

  /// `Plan Information`
  String get xboardPlanInfo {
    return Intl.message(
      'Plan Information',
      name: 'xboardPlanInfo',
      desc: '',
      args: [],
    );
  }

  /// `Subscription purchase`
  String get xboardSubscriptionPurchase {
    return Intl.message(
      'Subscription purchase',
      name: 'xboardSubscriptionPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get xboardBuyNow {
    return Intl.message('Buy Now', name: 'xboardBuyNow', desc: '', args: []);
  }

  /// `Retry`
  String get xboardRetry {
    return Intl.message('Retry', name: 'xboardRetry', desc: '', args: []);
  }

  /// `Refresh`
  String get xboardRefresh {
    return Intl.message('Refresh', name: 'xboardRefresh', desc: '', args: []);
  }

  /// `Copy Link`
  String get xboardCopyLink {
    return Intl.message(
      'Copy Link',
      name: 'xboardCopyLink',
      desc: '',
      args: [],
    );
  }

  /// `Subscription link copied to clipboard`
  String get xboardSubscriptionCopied {
    return Intl.message(
      'Subscription link copied to clipboard',
      name: 'xboardSubscriptionCopied',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get xboardReload {
    return Intl.message('Reload', name: 'xboardReload', desc: '', args: []);
  }

  /// `Processing...`
  String get xboardProcessing {
    return Intl.message(
      'Processing...',
      name: 'xboardProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Please select purchase period`
  String get xboardSelectPeriod {
    return Intl.message(
      'Please select purchase period',
      name: 'xboardSelectPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Operation failed`
  String get xboardOperationFailed {
    return Intl.message(
      'Operation failed',
      name: 'xboardOperationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open payment page`
  String get xboardOpenPaymentFailed {
    return Intl.message(
      'Failed to open payment page',
      name: 'xboardOpenPaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `1. Payment page has been opened automatically`
  String get xboardPaymentInstructions1 {
    return Intl.message(
      '1. Payment page has been opened automatically',
      name: 'xboardPaymentInstructions1',
      desc: '',
      args: [],
    );
  }

  /// `2. Please complete payment in your browser`
  String get xboardPaymentInstructions2 {
    return Intl.message(
      '2. Please complete payment in your browser',
      name: 'xboardPaymentInstructions2',
      desc: '',
      args: [],
    );
  }

  /// `3. Return to app after payment, system will detect automatically`
  String get xboardPaymentInstructions3 {
    return Intl.message(
      '3. Return to app after payment, system will detect automatically',
      name: 'xboardPaymentInstructions3',
      desc: '',
      args: [],
    );
  }

  /// `Order number`
  String get xboardOrderNumber {
    return Intl.message(
      'Order number',
      name: 'xboardOrderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Reopen Payment`
  String get xboardReopenPayment {
    return Intl.message(
      'Reopen Payment',
      name: 'xboardReopenPayment',
      desc: '',
      args: [],
    );
  }

  /// `Copy Link`
  String get xboardCopyPaymentLink {
    return Intl.message(
      'Copy Link',
      name: 'xboardCopyPaymentLink',
      desc: '',
      args: [],
    );
  }

  /// `Payment Complete`
  String get xboardPaymentComplete {
    return Intl.message(
      'Payment Complete',
      name: 'xboardPaymentComplete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel payment`
  String get xboardCancelPayment {
    return Intl.message(
      'Cancel payment',
      name: 'xboardCancelPayment',
      desc: '',
      args: [],
    );
  }

  /// `Payment successful`
  String get xboardPaymentSuccess {
    return Intl.message(
      'Payment successful',
      name: 'xboardPaymentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Payment cancelled`
  String get xboardPaymentCancelled {
    return Intl.message(
      'Payment cancelled',
      name: 'xboardPaymentCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Order not found`
  String get xboardOrderNotFound {
    return Intl.message(
      'Order not found',
      name: 'xboardOrderNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to check payment status`
  String get xboardCheckPaymentFailed {
    return Intl.message(
      'Failed to check payment status',
      name: 'xboardCheckPaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Payment completed!`
  String get xboardPaymentCompleted {
    return Intl.message(
      'Payment completed!',
      name: 'xboardPaymentCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get xboardBack {
    return Intl.message('Back', name: 'xboardBack', desc: '', args: []);
  }

  /// `Copy failed`
  String get xboardCopyFailed {
    return Intl.message(
      'Copy failed',
      name: 'xboardCopyFailed',
      desc: '',
      args: [],
    );
  }

  /// `Payment link copied to clipboard`
  String get xboardPaymentLinkCopied {
    return Intl.message(
      'Payment link copied to clipboard',
      name: 'xboardPaymentLinkCopied',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open payment link`
  String get xboardOpenPaymentLinkFailed {
    return Intl.message(
      'Failed to open payment link',
      name: 'xboardOpenPaymentLinkFailed',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification Code`
  String get xboardSendVerificationCode {
    return Intl.message(
      'Send Verification Code',
      name: 'xboardSendVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Enable TUN`
  String get xboardEnableTun {
    return Intl.message(
      'Enable TUN',
      name: 'xboardEnableTun',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get xboardPrevious {
    return Intl.message('Previous', name: 'xboardPrevious', desc: '', args: []);
  }

  /// `Next`
  String get xboardNext {
    return Intl.message('Next', name: 'xboardNext', desc: '', args: []);
  }

  /// `Later`
  String get xboardLater {
    return Intl.message('Later', name: 'xboardLater', desc: '', args: []);
  }

  /// `Clear error`
  String get xboardClearError {
    return Intl.message(
      'Clear error',
      name: 'xboardClearError',
      desc: '',
      args: [],
    );
  }

  /// `Update Later`
  String get xboardUpdateLater {
    return Intl.message(
      'Update Later',
      name: 'xboardUpdateLater',
      desc: '',
      args: [],
    );
  }

  /// `Force update`
  String get xboardForceUpdate {
    return Intl.message(
      'Force update',
      name: 'xboardForceUpdate',
      desc: '',
      args: [],
    );
  }

  /// `New version found`
  String get xboardNewVersionFound {
    return Intl.message(
      'New version found',
      name: 'xboardNewVersionFound',
      desc: '',
      args: [],
    );
  }

  /// `Current version`
  String get xboardCurrentVersion {
    return Intl.message(
      'Current version',
      name: 'xboardCurrentVersion',
      desc: '',
      args: [],
    );
  }

  /// `Update content:`
  String get xboardUpdateContent {
    return Intl.message(
      'Update content:',
      name: 'xboardUpdateContent',
      desc: '',
      args: [],
    );
  }

  /// `Must update`
  String get xboardMustUpdate {
    return Intl.message(
      'Must update',
      name: 'xboardMustUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get xboardUpdateNow {
    return Intl.message(
      'Update Now',
      name: 'xboardUpdateNow',
      desc: '',
      args: [],
    );
  }

  /// `No subscription information`
  String get xboardNoSubscriptionInfo {
    return Intl.message(
      'No subscription information',
      name: 'xboardNoSubscriptionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Please login to view subscription usage`
  String get xboardLoginToViewSubscription {
    return Intl.message(
      'Please login to view subscription usage',
      name: 'xboardLoginToViewSubscription',
      desc: '',
      args: [],
    );
  }

  /// `No available subscription`
  String get xboardNoAvailableSubscription {
    return Intl.message(
      'No available subscription',
      name: 'xboardNoAvailableSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Please purchase a subscription to use`
  String get xboardPurchaseSubscriptionToUse {
    return Intl.message(
      'Please purchase a subscription to use',
      name: 'xboardPurchaseSubscriptionToUse',
      desc: '',
      args: [],
    );
  }

  /// `Subscription expired`
  String get xboardSubscriptionExpired {
    return Intl.message(
      'Subscription expired',
      name: 'xboardSubscriptionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Please renew to continue using`
  String get xboardRenewToContinue {
    return Intl.message(
      'Please renew to continue using',
      name: 'xboardRenewToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Traffic exhausted`
  String get xboardTrafficExhausted {
    return Intl.message(
      'Traffic exhausted',
      name: 'xboardTrafficExhausted',
      desc: '',
      args: [],
    );
  }

  /// `Please buy more traffic or upgrade plan`
  String get xboardBuyMoreTrafficOrUpgrade {
    return Intl.message(
      'Please buy more traffic or upgrade plan',
      name: 'xboardBuyMoreTrafficOrUpgrade',
      desc: '',
      args: [],
    );
  }

  /// `Expiry time`
  String get xboardExpiryTime {
    return Intl.message(
      'Expiry time',
      name: 'xboardExpiryTime',
      desc: '',
      args: [],
    );
  }

  /// `Used`
  String get xboardUsed {
    return Intl.message('Used', name: 'xboardUsed', desc: '', args: []);
  }

  /// `Used`
  String get xboardUsedTraffic {
    return Intl.message('Used', name: 'xboardUsedTraffic', desc: '', args: []);
  }

  /// `Expires`
  String get xboardValidityPeriod {
    return Intl.message(
      'Expires',
      name: 'xboardValidityPeriod',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get xboardDays {
    return Intl.message('days', name: 'xboardDays', desc: '', args: []);
  }

  /// `Monthly`
  String get xboardMonthlyPayment {
    return Intl.message(
      'Monthly',
      name: 'xboardMonthlyPayment',
      desc: '',
      args: [],
    );
  }

  /// `Monthly renewal`
  String get xboardMonthlyRenewal {
    return Intl.message(
      'Monthly renewal',
      name: 'xboardMonthlyRenewal',
      desc: '',
      args: [],
    );
  }

  /// `Quarterly`
  String get xboardQuarterlyPayment {
    return Intl.message(
      'Quarterly',
      name: 'xboardQuarterlyPayment',
      desc: '',
      args: [],
    );
  }

  /// `3-month cycle`
  String get xboardThreeMonthCycle {
    return Intl.message(
      '3-month cycle',
      name: 'xboardThreeMonthCycle',
      desc: '',
      args: [],
    );
  }

  /// `Half-yearly`
  String get xboardHalfYearlyPayment {
    return Intl.message(
      'Half-yearly',
      name: 'xboardHalfYearlyPayment',
      desc: '',
      args: [],
    );
  }

  /// `6-month cycle`
  String get xboardSixMonthCycle {
    return Intl.message(
      '6-month cycle',
      name: 'xboardSixMonthCycle',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get xboardYearlyPayment {
    return Intl.message(
      'Yearly',
      name: 'xboardYearlyPayment',
      desc: '',
      args: [],
    );
  }

  /// `12-month cycle`
  String get xboardTwelveMonthCycle {
    return Intl.message(
      '12-month cycle',
      name: 'xboardTwelveMonthCycle',
      desc: '',
      args: [],
    );
  }

  /// `Two-year`
  String get xboardTwoYearPayment {
    return Intl.message(
      'Two-year',
      name: 'xboardTwoYearPayment',
      desc: '',
      args: [],
    );
  }

  /// `24-month cycle`
  String get xboardTwentyFourMonthCycle {
    return Intl.message(
      '24-month cycle',
      name: 'xboardTwentyFourMonthCycle',
      desc: '',
      args: [],
    );
  }

  /// `Three-year`
  String get xboardThreeYearPayment {
    return Intl.message(
      'Three-year',
      name: 'xboardThreeYearPayment',
      desc: '',
      args: [],
    );
  }

  /// `36-month cycle`
  String get xboardThirtySixMonthCycle {
    return Intl.message(
      '36-month cycle',
      name: 'xboardThirtySixMonthCycle',
      desc: '',
      args: [],
    );
  }

  /// `One-time`
  String get xboardOneTimePayment {
    return Intl.message(
      'One-time',
      name: 'xboardOneTimePayment',
      desc: '',
      args: [],
    );
  }

  /// `Buyout plan`
  String get xboardBuyoutPlan {
    return Intl.message(
      'Buyout plan',
      name: 'xboardBuyoutPlan',
      desc: '',
      args: [],
    );
  }

  /// `Please select payment period`
  String get xboardPleaseSelectPaymentPeriod {
    return Intl.message(
      'Please select payment period',
      name: 'xboardPleaseSelectPaymentPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Order creation failed`
  String get xboardOrderCreationFailed {
    return Intl.message(
      'Order creation failed',
      name: 'xboardOrderCreationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open payment page`
  String get xboardFailedToOpenPaymentPage {
    return Intl.message(
      'Failed to open payment page',
      name: 'xboardFailedToOpenPaymentPage',
      desc: '',
      args: [],
    );
  }

  /// `Select payment period`
  String get xboardSelectPaymentPeriod {
    return Intl.message(
      'Select payment period',
      name: 'xboardSelectPaymentPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Coupon not yet active`
  String get xboardCouponNotYetActive {
    return Intl.message(
      'Coupon not yet active',
      name: 'xboardCouponNotYetActive',
      desc: '',
      args: [],
    );
  }

  /// `Coupon expired`
  String get xboardCouponExpired {
    return Intl.message(
      'Coupon expired',
      name: 'xboardCouponExpired',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported coupon type`
  String get xboardUnsupportedCouponType {
    return Intl.message(
      'Unsupported coupon type',
      name: 'xboardUnsupportedCouponType',
      desc: '',
      args: [],
    );
  }

  /// `Invalid or expired coupon code`
  String get xboardInvalidOrExpiredCoupon {
    return Intl.message(
      'Invalid or expired coupon code',
      name: 'xboardInvalidOrExpiredCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Validation failed`
  String get xboardValidationFailed {
    return Intl.message(
      'Validation failed',
      name: 'xboardValidationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Account balance`
  String get xboardAccountBalance {
    return Intl.message(
      'Account balance',
      name: 'xboardAccountBalance',
      desc: '',
      args: [],
    );
  }

  /// `Deductible during payment`
  String get xboardDeductibleDuringPayment {
    return Intl.message(
      'Deductible during payment',
      name: 'xboardDeductibleDuringPayment',
      desc: '',
      args: [],
    );
  }

  /// `Coupon (optional)`
  String get xboardCouponOptional {
    return Intl.message(
      'Coupon (optional)',
      name: 'xboardCouponOptional',
      desc: '',
      args: [],
    );
  }

  /// `Discounted`
  String get xboardDiscounted {
    return Intl.message(
      'Discounted',
      name: 'xboardDiscounted',
      desc: '',
      args: [],
    );
  }

  /// `Enter coupon code`
  String get xboardEnterCouponCode {
    return Intl.message(
      'Enter coupon code',
      name: 'xboardEnterCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get xboardVerify {
    return Intl.message('Verify', name: 'xboardVerify', desc: '', args: []);
  }

  /// `Purchase subscription`
  String get xboardPurchaseSubscription {
    return Intl.message(
      'Purchase subscription',
      name: 'xboardPurchaseSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Traffic`
  String get xboardTraffic {
    return Intl.message('Traffic', name: 'xboardTraffic', desc: '', args: []);
  }

  /// `Speed`
  String get xboardSpeedLimit {
    return Intl.message('Speed', name: 'xboardSpeedLimit', desc: '', args: []);
  }

  /// `Confirm purchase`
  String get xboardConfirmPurchase {
    return Intl.message(
      'Confirm purchase',
      name: 'xboardConfirmPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Auto-opening payment page, please return to app after payment`
  String get xboardAutoOpeningPaymentPage {
    return Intl.message(
      'Auto-opening payment page, please return to app after payment',
      name: 'xboardAutoOpeningPaymentPage',
      desc: '',
      args: [],
    );
  }

  /// `Payment page opened in browser, please return to app after payment`
  String get xboardPaymentPageOpenedInBrowser {
    return Intl.message(
      'Payment page opened in browser, please return to app after payment',
      name: 'xboardPaymentPageOpenedInBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open payment link`
  String get xboardFailedToOpenPaymentLink {
    return Intl.message(
      'Failed to open payment link',
      name: 'xboardFailedToOpenPaymentLink',
      desc: '',
      args: [],
    );
  }

  /// `🎉 Payment successful!`
  String get xboardPaymentSuccessful {
    return Intl.message(
      '🎉 Payment successful!',
      name: 'xboardPaymentSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for payment`
  String get xboardWaitingForPayment {
    return Intl.message(
      'Waiting for payment',
      name: 'xboardWaitingForPayment',
      desc: '',
      args: [],
    );
  }

  /// `Order status: Pending payment`
  String get xboardOrderStatusPending {
    return Intl.message(
      'Order status: Pending payment',
      name: 'xboardOrderStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Failed to check payment status`
  String get xboardFailedToCheckPaymentStatus {
    return Intl.message(
      'Failed to check payment status',
      name: 'xboardFailedToCheckPaymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Payment gateway`
  String get xboardPaymentGateway {
    return Intl.message(
      'Payment gateway',
      name: 'xboardPaymentGateway',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get xboardReturn {
    return Intl.message('Return', name: 'xboardReturn', desc: '', args: []);
  }

  /// `Payment information`
  String get xboardPaymentInfo {
    return Intl.message(
      'Payment information',
      name: 'xboardPaymentInfo',
      desc: '',
      args: [],
    );
  }

  /// `Payment link`
  String get xboardPaymentLink {
    return Intl.message(
      'Payment link',
      name: 'xboardPaymentLink',
      desc: '',
      args: [],
    );
  }

  /// `Click to copy`
  String get xboardClickToCopy {
    return Intl.message(
      'Click to copy',
      name: 'xboardClickToCopy',
      desc: '',
      args: [],
    );
  }

  /// `Auto-detect payment status`
  String get xboardAutoDetectPaymentStatus {
    return Intl.message(
      'Auto-detect payment status',
      name: 'xboardAutoDetectPaymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `System checks every 5 seconds, will redirect automatically after payment`
  String get xboardAutoCheckEvery5Seconds {
    return Intl.message(
      'System checks every 5 seconds, will redirect automatically after payment',
      name: 'xboardAutoCheckEvery5Seconds',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get xboardStop {
    return Intl.message('Stop', name: 'xboardStop', desc: '', args: []);
  }

  /// `Operation tips`
  String get xboardOperationTips {
    return Intl.message(
      'Operation tips',
      name: 'xboardOperationTips',
      desc: '',
      args: [],
    );
  }

  /// `1. Payment page has been opened automatically`
  String get xboardPaymentPageAutoOpened {
    return Intl.message(
      '1. Payment page has been opened automatically',
      name: 'xboardPaymentPageAutoOpened',
      desc: '',
      args: [],
    );
  }

  /// `2. Please complete payment in your browser`
  String get xboardCompletePaymentInBrowser {
    return Intl.message(
      '2. Please complete payment in your browser',
      name: 'xboardCompletePaymentInBrowser',
      desc: '',
      args: [],
    );
  }

  /// `3. Return to app after payment, system will detect automatically`
  String get xboardReturnAfterPaymentAutoDetect {
    return Intl.message(
      '3. Return to app after payment, system will detect automatically',
      name: 'xboardReturnAfterPaymentAutoDetect',
      desc: '',
      args: [],
    );
  }

  /// `To reopen, click the \"Reopen\" button below`
  String get xboardReopenPaymentPageTip {
    return Intl.message(
      'To reopen, click the \\"Reopen\\" button below',
      name: 'xboardReopenPaymentPageTip',
      desc: '',
      args: [],
    );
  }

  /// `If browser doesn't open automatically, click \"Reopen\" or copy link manually`
  String get xboardBrowserNotOpenedTip {
    return Intl.message(
      'If browser doesn\'t open automatically, click \\"Reopen\\" or copy link manually',
      name: 'xboardBrowserNotOpenedTip',
      desc: '',
      args: [],
    );
  }

  /// `Reopen`
  String get xboardReopen {
    return Intl.message('Reopen', name: 'xboardReopen', desc: '', args: []);
  }

  /// `Checking`
  String get xboardChecking {
    return Intl.message('Checking', name: 'xboardChecking', desc: '', args: []);
  }

  /// `Check status`
  String get xboardCheckStatus {
    return Intl.message(
      'Check status',
      name: 'xboardCheckStatus',
      desc: '',
      args: [],
    );
  }

  /// `Creating order`
  String get xboardCreatingOrder {
    return Intl.message(
      'Creating order',
      name: 'xboardCreatingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Loading payment page`
  String get xboardLoadingPaymentPage {
    return Intl.message(
      'Loading payment page',
      name: 'xboardLoadingPaymentPage',
      desc: '',
      args: [],
    );
  }

  /// `Payment method verified`
  String get xboardPaymentMethodVerified {
    return Intl.message(
      'Payment method verified',
      name: 'xboardPaymentMethodVerified',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for payment completion`
  String get xboardWaitingPaymentCompletion {
    return Intl.message(
      'Waiting for payment completion',
      name: 'xboardWaitingPaymentCompletion',
      desc: '',
      args: [],
    );
  }

  /// `We are creating a new order for you, please wait`
  String get xboardCreatingOrderPleaseWait {
    return Intl.message(
      'We are creating a new order for you, please wait',
      name: 'xboardCreatingOrderPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Preparing payment page, redirecting soon`
  String get xboardPreparingPaymentPage {
    return Intl.message(
      'Preparing payment page, redirecting soon',
      name: 'xboardPreparingPaymentPage',
      desc: '',
      args: [],
    );
  }

  /// `Payment method verified, preparing to redirect to payment page`
  String get xboardPaymentMethodVerifiedPreparing {
    return Intl.message(
      'Payment method verified, preparing to redirect to payment page',
      name: 'xboardPaymentMethodVerifiedPreparing',
      desc: '',
      args: [],
    );
  }

  /// `Payment page opened, please complete payment and return to app`
  String get xboardPaymentPageOpenedCompleteAndReturn {
    return Intl.message(
      'Payment page opened, please complete payment and return to app',
      name: 'xboardPaymentPageOpenedCompleteAndReturn',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! Your subscription has been successfully purchased and activated`
  String get xboardCongratulationsSubscriptionActivated {
    return Intl.message(
      'Congratulations! Your subscription has been successfully purchased and activated',
      name: 'xboardCongratulationsSubscriptionActivated',
      desc: '',
      args: [],
    );
  }

  /// `Handle later`
  String get xboardHandleLater {
    return Intl.message(
      'Handle later',
      name: 'xboardHandleLater',
      desc: '',
      args: [],
    );
  }

  /// `Subscription link copied to clipboard`
  String get xboardSubscriptionLinkCopied {
    return Intl.message(
      'Subscription link copied to clipboard',
      name: 'xboardSubscriptionLinkCopied',
      desc: '',
      args: [],
    );
  }

  /// `Subscription information`
  String get xboardSubscriptionInfo {
    return Intl.message(
      'Subscription information',
      name: 'xboardSubscriptionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get subscription information`
  String get xboardFailedToGetSubscriptionInfo {
    return Intl.message(
      'Failed to get subscription information',
      name: 'xboardFailedToGetSubscriptionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get xboardRetryGet {
    return Intl.message('Retry', name: 'xboardRetryGet', desc: '', args: []);
  }

  /// `Subscription link`
  String get xboardSubscriptionLink {
    return Intl.message(
      'Subscription link',
      name: 'xboardSubscriptionLink',
      desc: '',
      args: [],
    );
  }

  /// `Usage instructions`
  String get xboardUsageInstructions {
    return Intl.message(
      'Usage instructions',
      name: 'xboardUsageInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Copy the subscription link above`
  String get xboardCopySubscriptionLinkAbove {
    return Intl.message(
      'Copy the subscription link above',
      name: 'xboardCopySubscriptionLinkAbove',
      desc: '',
      args: [],
    );
  }

  /// `Add this subscription link to your configuration`
  String get xboardAddLinkToConfig {
    return Intl.message(
      'Add this subscription link to your configuration',
      name: 'xboardAddLinkToConfig',
      desc: '',
      args: [],
    );
  }

  /// `Update subscription regularly to get latest nodes`
  String get xboardUpdateSubscriptionRegularly {
    return Intl.message(
      'Update subscription regularly to get latest nodes',
      name: 'xboardUpdateSubscriptionRegularly',
      desc: '',
      args: [],
    );
  }

  /// `Please keep your subscription link safe and don't share with others`
  String get xboardKeepSubscriptionLinkSafe {
    return Intl.message(
      'Please keep your subscription link safe and don\'t share with others',
      name: 'xboardKeepSubscriptionLinkSafe',
      desc: '',
      args: [],
    );
  }

  /// `Loading failed`
  String get xboardLoadingFailed {
    return Intl.message(
      'Loading failed',
      name: 'xboardLoadingFailed',
      desc: '',
      args: [],
    );
  }

  /// `No subscription plans`
  String get xboardNoSubscriptionPlans {
    return Intl.message(
      'No subscription plans',
      name: 'xboardNoSubscriptionPlans',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout, please check network connection`
  String get xboardConnectionTimeout {
    return Intl.message(
      'Connection timeout, please check network connection',
      name: 'xboardConnectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection, please check network settings`
  String get xboardNoInternetConnection {
    return Intl.message(
      'No internet connection, please check network settings',
      name: 'xboardNoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Server error`
  String get xboardServerError {
    return Intl.message(
      'Server error',
      name: 'xboardServerError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username or password`
  String get xboardInvalidCredentials {
    return Intl.message(
      'Invalid username or password',
      name: 'xboardInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Login expired, please login again`
  String get xboardLoginExpired {
    return Intl.message(
      'Login expired, please login again',
      name: 'xboardLoginExpired',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized access, please login first`
  String get xboardUnauthorizedAccess {
    return Intl.message(
      'Unauthorized access, please login first',
      name: 'xboardUnauthorizedAccess',
      desc: '',
      args: [],
    );
  }

  /// `Plan not found`
  String get xboardPlanNotFound {
    return Intl.message(
      'Plan not found',
      name: 'xboardPlanNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Payment failed`
  String get xboardPaymentFailed {
    return Intl.message(
      'Payment failed',
      name: 'xboardPaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient balance`
  String get xboardInsufficientBalance {
    return Intl.message(
      'Insufficient balance',
      name: 'xboardInsufficientBalance',
      desc: '',
      args: [],
    );
  }

  /// `Invalid response format from server`
  String get xboardInvalidResponseFormat {
    return Intl.message(
      'Invalid response format from server',
      name: 'xboardInvalidResponseFormat',
      desc: '',
      args: [],
    );
  }

  /// `Missing required field`
  String get xboardMissingRequiredField {
    return Intl.message(
      'Missing required field',
      name: 'xboardMissingRequiredField',
      desc: '',
      args: [],
    );
  }

  /// `API URL not configured`
  String get xboardApiUrlNotConfigured {
    return Intl.message(
      'API URL not configured',
      name: 'xboardApiUrlNotConfigured',
      desc: '',
      args: [],
    );
  }

  /// `Configuration error`
  String get xboardConfigurationError {
    return Intl.message(
      'Configuration error',
      name: 'xboardConfigurationError',
      desc: '',
      args: [],
    );
  }

  /// `Testing`
  String get xboardTesting {
    return Intl.message('Testing', name: 'xboardTesting', desc: '', args: []);
  }

  /// `Auto testing`
  String get xboardAutoTesting {
    return Intl.message(
      'Auto testing',
      name: 'xboardAutoTesting',
      desc: '',
      args: [],
    );
  }

  /// `Timeout`
  String get xboardTimeout {
    return Intl.message('Timeout', name: 'xboardTimeout', desc: '', args: []);
  }

  /// `Excellent`
  String get xboardExcellent {
    return Intl.message(
      'Excellent',
      name: 'xboardExcellent',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get xboardGood {
    return Intl.message('Good', name: 'xboardGood', desc: '', args: []);
  }

  /// `Fair`
  String get xboardFair {
    return Intl.message('Fair', name: 'xboardFair', desc: '', args: []);
  }

  /// `Poor`
  String get xboardPoor {
    return Intl.message('Poor', name: 'xboardPoor', desc: '', args: []);
  }

  /// `Very poor`
  String get xboardVeryPoor {
    return Intl.message(
      'Very poor',
      name: 'xboardVeryPoor',
      desc: '',
      args: [],
    );
  }

  /// `Preparing import`
  String get xboardPreparingImport {
    return Intl.message(
      'Preparing import',
      name: 'xboardPreparingImport',
      desc: '',
      args: [],
    );
  }

  /// `Cleaning old configuration`
  String get xboardCleaningOldConfig {
    return Intl.message(
      'Cleaning old configuration',
      name: 'xboardCleaningOldConfig',
      desc: '',
      args: [],
    );
  }

  /// `Downloading configuration file`
  String get xboardDownloadingConfig {
    return Intl.message(
      'Downloading configuration file',
      name: 'xboardDownloadingConfig',
      desc: '',
      args: [],
    );
  }

  /// `Validating configuration format`
  String get xboardValidatingConfigFormat {
    return Intl.message(
      'Validating configuration format',
      name: 'xboardValidatingConfigFormat',
      desc: '',
      args: [],
    );
  }

  /// `Adding to configuration list`
  String get xboardAddingToConfigList {
    return Intl.message(
      'Adding to configuration list',
      name: 'xboardAddingToConfigList',
      desc: '',
      args: [],
    );
  }

  /// `Import successful`
  String get xboardImportSuccess {
    return Intl.message(
      'Import successful',
      name: 'xboardImportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Import failed`
  String get xboardImportFailed {
    return Intl.message(
      'Import failed',
      name: 'xboardImportFailed',
      desc: '',
      args: [],
    );
  }

  /// `Network connection failed, please check network settings`
  String get xboardNetworkConnectionFailed {
    return Intl.message(
      'Network connection failed, please check network settings',
      name: 'xboardNetworkConnectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Configuration download failed, please check subscription link`
  String get xboardConfigDownloadFailed {
    return Intl.message(
      'Configuration download failed, please check subscription link',
      name: 'xboardConfigDownloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Configuration format error, please contact service provider`
  String get xboardConfigFormatError {
    return Intl.message(
      'Configuration format error, please contact service provider',
      name: 'xboardConfigFormatError',
      desc: '',
      args: [],
    );
  }

  /// `Configuration save failed, please check storage space`
  String get xboardConfigSaveFailed {
    return Intl.message(
      'Configuration save failed, please check storage space',
      name: 'xboardConfigSaveFailed',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error, please retry`
  String get xboardUnknownErrorRetry {
    return Intl.message(
      'Unknown error, please retry',
      name: 'xboardUnknownErrorRetry',
      desc: '',
      args: [],
    );
  }

  /// `Proxy Mode`
  String get xboardProxyMode {
    return Intl.message(
      'Proxy Mode',
      name: 'xboardProxyMode',
      desc: '',
      args: [],
    );
  }

  /// `Automatically select direct or proxy based on rules`
  String get xboardProxyModeRuleDescription {
    return Intl.message(
      'Automatically select direct or proxy based on rules',
      name: 'xboardProxyModeRuleDescription',
      desc: '',
      args: [],
    );
  }

  /// `All traffic goes through proxy server`
  String get xboardProxyModeGlobalDescription {
    return Intl.message(
      'All traffic goes through proxy server',
      name: 'xboardProxyModeGlobalDescription',
      desc: '',
      args: [],
    );
  }

  /// `All traffic connects directly without proxy`
  String get xboardProxyModeDirectDescription {
    return Intl.message(
      'All traffic connects directly without proxy',
      name: 'xboardProxyModeDirectDescription',
      desc: '',
      args: [],
    );
  }

  /// `TUN enabled`
  String get xboardTunEnabled {
    return Intl.message(
      'TUN enabled',
      name: 'xboardTunEnabled',
      desc: '',
      args: [],
    );
  }

  /// `No available nodes`
  String get xboardNoAvailableNodes {
    return Intl.message(
      'No available nodes',
      name: 'xboardNoAvailableNodes',
      desc: '',
      args: [],
    );
  }

  /// `Click to setup nodes`
  String get xboardClickToSetupNodes {
    return Intl.message(
      'Click to setup nodes',
      name: 'xboardClickToSetupNodes',
      desc: '',
      args: [],
    );
  }

  /// `Proxy`
  String get xboardProxy {
    return Intl.message('Proxy', name: 'xboardProxy', desc: '', args: []);
  }

  /// `Switch`
  String get xboardSwitch {
    return Intl.message('Switch', name: 'xboardSwitch', desc: '', args: []);
  }

  /// `Setup`
  String get xboardSetup {
    return Intl.message('Setup', name: 'xboardSetup', desc: '', args: []);
  }

  /// `No available plan`
  String get xboardNoAvailablePlan {
    return Intl.message(
      'No available plan',
      name: 'xboardNoAvailablePlan',
      desc: '',
      args: [],
    );
  }

  /// `Subscription has expired`
  String get xboardSubscriptionHasExpired {
    return Intl.message(
      'Subscription has expired',
      name: 'xboardSubscriptionHasExpired',
      desc: '',
      args: [],
    );
  }

  /// `Traffic used up`
  String get xboardTrafficUsedUp {
    return Intl.message(
      'Traffic used up',
      name: 'xboardTrafficUsedUp',
      desc: '',
      args: [],
    );
  }

  /// `Subscription status`
  String get xboardSubscriptionStatus {
    return Intl.message(
      'Subscription status',
      name: 'xboardSubscriptionStatus',
      desc: '',
      args: [],
    );
  }

  /// `Refresh status`
  String get xboardRefreshStatus {
    return Intl.message(
      'Refresh status',
      name: 'xboardRefreshStatus',
      desc: '',
      args: [],
    );
  }

  /// `Purchase plan`
  String get xboardPurchasePlan {
    return Intl.message(
      'Purchase plan',
      name: 'xboardPurchasePlan',
      desc: '',
      args: [],
    );
  }

  /// `Renew plan`
  String get xboardRenewPlan {
    return Intl.message(
      'Renew plan',
      name: 'xboardRenewPlan',
      desc: '',
      args: [],
    );
  }

  /// `Purchase traffic`
  String get xboardPurchaseTraffic {
    return Intl.message(
      'Purchase traffic',
      name: 'xboardPurchaseTraffic',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get xboardConfirmAction {
    return Intl.message(
      'Confirm',
      name: 'xboardConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `After purchasing a plan, you will enjoy:`
  String get xboardAfterPurchasingPlan {
    return Intl.message(
      'After purchasing a plan, you will enjoy:',
      name: 'xboardAfterPurchasingPlan',
      desc: '',
      args: [],
    );
  }

  /// `High-speed network`
  String get xboardHighSpeedNetwork {
    return Intl.message(
      'High-speed network',
      name: 'xboardHighSpeedNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy fast network experience`
  String get xboardEnjoyFastNetworkExperience {
    return Intl.message(
      'Enjoy fast network experience',
      name: 'xboardEnjoyFastNetworkExperience',
      desc: '',
      args: [],
    );
  }

  /// `Secure encryption`
  String get xboardSecureEncryption {
    return Intl.message(
      'Secure encryption',
      name: 'xboardSecureEncryption',
      desc: '',
      args: [],
    );
  }

  /// `Protect your network privacy`
  String get xboardProtectNetworkPrivacy {
    return Intl.message(
      'Protect your network privacy',
      name: 'xboardProtectNetworkPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Global nodes`
  String get xboardGlobalNodes {
    return Intl.message(
      'Global nodes',
      name: 'xboardGlobalNodes',
      desc: '',
      args: [],
    );
  }

  /// `Connect to global quality nodes`
  String get xboardConnectGlobalQualityNodes {
    return Intl.message(
      'Connect to global quality nodes',
      name: 'xboardConnectGlobalQualityNodes',
      desc: '',
      args: [],
    );
  }

  /// `Professional support`
  String get xboardProfessionalSupport {
    return Intl.message(
      'Professional support',
      name: 'xboardProfessionalSupport',
      desc: '',
      args: [],
    );
  }

  /// `24-hour customer service support`
  String get xboard24HourCustomerService {
    return Intl.message(
      '24-hour customer service support',
      name: 'xboard24HourCustomerService',
      desc: '',
      args: [],
    );
  }

  /// `Start Proxy`
  String get xboardStartProxy {
    return Intl.message(
      'Start Proxy',
      name: 'xboardStartProxy',
      desc: '',
      args: [],
    );
  }

  /// `Stop Proxy`
  String get xboardStopProxy {
    return Intl.message(
      'Stop Proxy',
      name: 'xboardStopProxy',
      desc: '',
      args: [],
    );
  }

  /// `Running time: {time}`
  String xboardRunningTime(String time) {
    return Intl.message(
      'Running time: $time',
      name: 'xboardRunningTime',
      desc: '',
      args: [time],
    );
  }

  /// `Not logged in`
  String get subscriptionNotLoggedIn {
    return Intl.message(
      'Not logged in',
      name: 'subscriptionNotLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Please login first`
  String get subscriptionNotLoggedInDetail {
    return Intl.message(
      'Please login first',
      name: 'subscriptionNotLoggedInDetail',
      desc: '',
      args: [],
    );
  }

  /// `No subscription`
  String get subscriptionNoSubscription {
    return Intl.message(
      'No subscription',
      name: 'subscriptionNoSubscription',
      desc: '',
      args: [],
    );
  }

  /// `No available subscription plan found, please purchase a plan to use`
  String get subscriptionNoSubscriptionDetail {
    return Intl.message(
      'No available subscription plan found, please purchase a plan to use',
      name: 'subscriptionNoSubscriptionDetail',
      desc: '',
      args: [],
    );
  }

  /// `Subscription expired`
  String get subscriptionExpired {
    return Intl.message(
      'Subscription expired',
      name: 'subscriptionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Plan expired on {date}, please renew to continue using`
  String subscriptionExpiredDetail(String date) {
    return Intl.message(
      'Plan expired on $date, please renew to continue using',
      name: 'subscriptionExpiredDetail',
      desc: '',
      args: [date],
    );
  }

  /// `Subscription expires today`
  String get subscriptionExpiresToday {
    return Intl.message(
      'Subscription expires today',
      name: 'subscriptionExpiresToday',
      desc: '',
      args: [],
    );
  }

  /// `Plan will expire today, please renew immediately to avoid service interruption`
  String get subscriptionExpiresTodayDetail {
    return Intl.message(
      'Plan will expire today, please renew immediately to avoid service interruption',
      name: 'subscriptionExpiresTodayDetail',
      desc: '',
      args: [],
    );
  }

  /// `Subscription expiring soon`
  String get subscriptionExpiringInDays {
    return Intl.message(
      'Subscription expiring soon',
      name: 'subscriptionExpiringInDays',
      desc: '',
      args: [],
    );
  }

  /// `Plan will expire in {days} days, please renew in time`
  String subscriptionExpiringInDaysDetail(int days) {
    return Intl.message(
      'Plan will expire in $days days, please renew in time',
      name: 'subscriptionExpiringInDaysDetail',
      desc: '',
      args: [days],
    );
  }

  /// `Traffic exhausted`
  String get subscriptionTrafficExhausted {
    return Intl.message(
      'Traffic exhausted',
      name: 'subscriptionTrafficExhausted',
      desc: '',
      args: [],
    );
  }

  /// `Plan traffic has been used up, please purchase more traffic or upgrade plan`
  String get subscriptionTrafficExhaustedDetail {
    return Intl.message(
      'Plan traffic has been used up, please purchase more traffic or upgrade plan',
      name: 'subscriptionTrafficExhaustedDetail',
      desc: '',
      args: [],
    );
  }

  /// `Subscription valid`
  String get subscriptionValid {
    return Intl.message(
      'Subscription valid',
      name: 'subscriptionValid',
      desc: '',
      args: [],
    );
  }

  /// `Subscription will expire in {days} days`
  String subscriptionValidDetail(int days) {
    return Intl.message(
      'Subscription will expire in $days days',
      name: 'subscriptionValidDetail',
      desc: '',
      args: [days],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set New Password`
  String get setNewPassword {
    return Intl.message(
      'Set New Password',
      name: 'setNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address and we will send a verification code to your email`
  String get enterEmailForReset {
    return Intl.message(
      'Please enter your email address and we will send a verification code to your email',
      name: 'enterEmailForReset',
      desc: '',
      args: [],
    );
  }

  /// `Verification code has been sent to your email, please check`
  String get verificationCodeSent {
    return Intl.message(
      'Verification code has been sent to your email, please check',
      name: 'verificationCodeSent',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send verification code`
  String get sendCodeFailed {
    return Intl.message(
      'Failed to send verification code',
      name: 'sendCodeFailed',
      desc: '',
      args: [],
    );
  }

  /// `Verification code has been sent to {email}, please check and enter the verification code and new password`
  String verificationCodeSentTo(String email) {
    return Intl.message(
      'Verification code has been sent to $email, please check and enter the verification code and new password',
      name: 'verificationCodeSentTo',
      desc: '',
      args: [email],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email address`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter email address',
      name: 'pleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification Code`
  String get sendVerificationCode {
    return Intl.message(
      'Send Verification Code',
      name: 'sendVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get verificationCode {
    return Intl.message(
      'Verification Code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email verification code`
  String get pleaseEnterVerificationCode {
    return Intl.message(
      'Please enter email verification code',
      name: 'pleaseEnterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid verification code`
  String get pleaseEnterValidVerificationCode {
    return Intl.message(
      'Please enter a valid verification code',
      name: 'pleaseEnterValidVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get pleaseEnterNewPassword {
    return Intl.message(
      'Please enter new password',
      name: 'pleaseEnterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please re-enter new password`
  String get pleaseConfirmNewPassword {
    return Intl.message(
      'Please re-enter new password',
      name: 'pleaseConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful! Please login with your new password`
  String get passwordResetSuccessful {
    return Intl.message(
      'Password reset successful! Please login with your new password',
      name: 'passwordResetSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Password reset failed`
  String get passwordResetFailed {
    return Intl.message(
      'Password reset failed',
      name: 'passwordResetFailed',
      desc: '',
      args: [],
    );
  }

  /// `Resend Verification Code`
  String get resendVerificationCode {
    return Intl.message(
      'Resend Verification Code',
      name: 'resendVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Remember your password?`
  String get rememberPassword {
    return Intl.message(
      'Remember your password?',
      name: 'rememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful - Saving credentials:`
  String get registerSuccessSaveCredentials {
    return Intl.message(
      'Registration successful - Saving credentials:',
      name: 'registerSuccessSaveCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Credentials saved`
  String get credentialsSaved {
    return Intl.message(
      'Credentials saved',
      name: 'credentialsSaved',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed: {e}`
  String registrationFailed(String e) {
    return Intl.message(
      'Registration failed: $e',
      name: 'registrationFailed',
      desc: '',
      args: [e],
    );
  }

  /// `Please enter email address`
  String get pleaseEnterEmailAddress {
    return Intl.message(
      'Please enter email address',
      name: 'pleaseEnterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get pleaseEnterValidEmailAddress {
    return Intl.message(
      'Please enter a valid email address',
      name: 'pleaseEnterValidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent, please check your email`
  String get verificationCodeSentCheckEmail {
    return Intl.message(
      'Verification code sent, please check your email',
      name: 'verificationCodeSentCheckEmail',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send verification code: {e}`
  String sendVerificationCodeFailed(String e) {
    return Intl.message(
      'Failed to send verification code: $e',
      name: 'sendVerificationCodeFailed',
      desc: '',
      args: [e],
    );
  }

  /// `Invite Code Required`
  String get inviteCodeRequired {
    return Intl.message(
      'Invite Code Required',
      name: 'inviteCodeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Registration requires an invite code. Please contact a registered user to get an invite code before registering.`
  String get inviteCodeRequiredMessage {
    return Intl.message(
      'Registration requires an invite code. Please contact a registered user to get an invite code before registering.',
      name: 'inviteCodeRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `I Understand`
  String get iUnderstand {
    return Intl.message(
      'I Understand',
      name: 'iUnderstand',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the following information to complete registration`
  String get fillInfoToRegister {
    return Intl.message(
      'Please fill in the following information to complete registration',
      name: 'fillInfoToRegister',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address`
  String get pleaseEnterYourEmailAddress {
    return Intl.message(
      'Please enter your email address',
      name: 'pleaseEnterYourEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter at least 8 characters password`
  String get pleaseEnterAtLeast8CharsPassword {
    return Intl.message(
      'Please enter at least 8 characters password',
      name: 'pleaseEnterAtLeast8CharsPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordMin8Chars {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordMin8Chars',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm password`
  String get pleaseConfirmPassword {
    return Intl.message(
      'Please confirm password',
      name: 'pleaseConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please re-enter password`
  String get pleaseReEnterPassword {
    return Intl.message(
      'Please re-enter password',
      name: 'pleaseReEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification Code`
  String get emailVerificationCode {
    return Intl.message(
      'Email Verification Code',
      name: 'emailVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email verification code`
  String get pleaseEnterEmailVerificationCode {
    return Intl.message(
      'Please enter email verification code',
      name: 'pleaseEnterEmailVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification code should be 6 digits`
  String get verificationCode6Digits {
    return Intl.message(
      'Verification code should be 6 digits',
      name: 'verificationCode6Digits',
      desc: '',
      args: [],
    );
  }

  /// `Invite Code`
  String get inviteCode {
    return Intl.message('Invite Code', name: 'inviteCode', desc: '', args: []);
  }

  /// `Please enter invite code`
  String get pleaseEnterInviteCode {
    return Intl.message(
      'Please enter invite code',
      name: 'pleaseEnterInviteCode',
      desc: '',
      args: [],
    );
  }

  /// `Invite Code (optional)`
  String get inviteCodeOptional {
    return Intl.message(
      'Invite Code (optional)',
      name: 'inviteCodeOptional',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Register Account`
  String get registerAccount {
    return Intl.message(
      'Register Account',
      name: 'registerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login Now`
  String get loginNow {
    return Intl.message('Login Now', name: 'loginNow', desc: '', args: []);
  }

  /// `Invite`
  String get invite {
    return Intl.message('Invite', name: 'invite', desc: '', args: []);
  }

  /// `User Center`
  String get userCenter {
    return Intl.message('User Center', name: 'userCenter', desc: '', args: []);
  }

  /// `Invite Rules`
  String get inviteRules {
    return Intl.message(
      'Invite Rules',
      name: 'inviteRules',
      desc: '',
      args: [],
    );
  }

  /// `Invite friends to register and subscribe to earn commission`
  String get inviteRegisterReward {
    return Intl.message(
      'Invite friends to register and subscribe to earn commission',
      name: 'inviteRegisterReward',
      desc: '',
      args: [],
    );
  }

  /// `Earn commission when your invited friends spend`
  String get friendInviteReward {
    return Intl.message(
      'Earn commission when your invited friends spend',
      name: 'friendInviteReward',
      desc: '',
      args: [],
    );
  }

  /// `Current commission rate: {rate}%`
  String currentCommissionRate(String rate) {
    return Intl.message(
      'Current commission rate: $rate%',
      name: 'currentCommissionRate',
      desc: '',
      args: [rate],
    );
  }

  /// `Commission settled after friend subscription`
  String get commissionSettled {
    return Intl.message(
      'Commission settled after friend subscription',
      name: 'commissionSettled',
      desc: '',
      args: [],
    );
  }

  /// `Available commission can be withdrawn`
  String get withdrawalAvailable {
    return Intl.message(
      'Available commission can be withdrawn',
      name: 'withdrawalAvailable',
      desc: '',
      args: [],
    );
  }

  /// `My Invite QR`
  String get myInviteQr {
    return Intl.message('My Invite QR', name: 'myInviteQr', desc: '', args: []);
  }

  /// `Save QR`
  String get saveQr {
    return Intl.message('Save QR', name: 'saveQr', desc: '', args: []);
  }

  /// `Copy Link`
  String get copyInviteLink {
    return Intl.message(
      'Copy Link',
      name: 'copyInviteLink',
      desc: '',
      args: [],
    );
  }

  /// `Generating invite code...`
  String get generatingInviteCode {
    return Intl.message(
      'Generating invite code...',
      name: 'generatingInviteCode',
      desc: '',
      args: [],
    );
  }

  /// `Invite code generation failed`
  String get inviteCodeGenFailed {
    return Intl.message(
      'Invite code generation failed',
      name: 'inviteCodeGenFailed',
      desc: '',
      args: [],
    );
  }

  /// `Please check network and retry`
  String get checkNetwork {
    return Intl.message(
      'Please check network and retry',
      name: 'checkNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Invite Stats`
  String get inviteStats {
    return Intl.message(
      'Invite Stats',
      name: 'inviteStats',
      desc: '',
      args: [],
    );
  }

  /// `Total Invites`
  String get totalInvites {
    return Intl.message(
      'Total Invites',
      name: 'totalInvites',
      desc: '',
      args: [],
    );
  }

  /// `Commission Rate`
  String get commissionRate {
    return Intl.message(
      'Commission Rate',
      name: 'commissionRate',
      desc: '',
      args: [],
    );
  }

  /// `Total Commission`
  String get totalCommission {
    return Intl.message(
      'Total Commission',
      name: 'totalCommission',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Details`
  String get walletDetails {
    return Intl.message(
      'Wallet Details',
      name: 'walletDetails',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message('Transfer', name: 'transfer', desc: '', args: []);
  }

  /// `Available Commission`
  String get availableCommission {
    return Intl.message(
      'Available Commission',
      name: 'availableCommission',
      desc: '',
      args: [],
    );
  }

  /// `Pending Commission`
  String get pendingCommission {
    return Intl.message(
      'Pending Commission',
      name: 'pendingCommission',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Balance`
  String get walletBalance {
    return Intl.message(
      'Wallet Balance',
      name: 'walletBalance',
      desc: '',
      args: [],
    );
  }

  /// `Commission History`
  String get commissionHistory {
    return Intl.message(
      'Commission History',
      name: 'commissionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message('Withdraw', name: 'withdraw', desc: '', args: []);
  }

  /// `No commission records`
  String get noCommissionRecord {
    return Intl.message(
      'No commission records',
      name: 'noCommissionRecord',
      desc: '',
      args: [],
    );
  }

  /// `View History`
  String get viewHistory {
    return Intl.message(
      'View History',
      name: 'viewHistory',
      desc: '',
      args: [],
    );
  }

  /// `Load More`
  String get loadMore {
    return Intl.message('Load More', name: 'loadMore', desc: '', args: []);
  }

  /// `Copied to clipboard`
  String get copiedToClipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Save QR feature coming soon`
  String get saveQrCodeFeature {
    return Intl.message(
      'Save QR feature coming soon',
      name: 'saveQrCodeFeature',
      desc: '',
      args: [],
    );
  }

  /// `Invite link copied, share with friends`
  String get inviteLinkCopied {
    return Intl.message(
      'Invite link copied, share with friends',
      name: 'inviteLinkCopied',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Commission`
  String get withdrawCommission {
    return Intl.message(
      'Withdraw Commission',
      name: 'withdrawCommission',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawable amount: {amount}`
  String withdrawableAmount(String amount) {
    return Intl.message(
      'Withdrawable amount: $amount',
      name: 'withdrawableAmount',
      desc: '',
      args: [amount],
    );
  }

  /// `Please visit web version to withdraw`
  String get visitWebVersion {
    return Intl.message(
      'Please visit web version to withdraw',
      name: 'visitWebVersion',
      desc: '',
      args: [],
    );
  }

  /// `Web version provides complete withdrawal features`
  String get completeWithdrawal {
    return Intl.message(
      'Web version provides complete withdrawal features',
      name: 'completeWithdrawal',
      desc: '',
      args: [],
    );
  }

  /// `Go to Web`
  String get goToWeb {
    return Intl.message('Go to Web', name: 'goToWeb', desc: '', args: []);
  }

  /// `Cannot open browser, please visit web manually`
  String get cannotOpenBrowser {
    return Intl.message(
      'Cannot open browser, please visit web manually',
      name: 'cannotOpenBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open web, please visit manually`
  String get openWebFailed {
    return Intl.message(
      'Failed to open web, please visit manually',
      name: 'openWebFailed',
      desc: '',
      args: [],
    );
  }

  /// `Cannot get web URL, please contact support`
  String get cannotGetWebUrl {
    return Intl.message(
      'Cannot get web URL, please contact support',
      name: 'cannotGetWebUrl',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to Wallet`
  String get transferToWallet {
    return Intl.message(
      'Transfer to Wallet',
      name: 'transferToWallet',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Success!`
  String get transferSuccess {
    return Intl.message(
      'Transfer Success!',
      name: 'transferSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Transferring...`
  String get transferring {
    return Intl.message(
      'Transferring...',
      name: 'transferring',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Amount`
  String get transferAmount {
    return Intl.message(
      'Transfer Amount',
      name: 'transferAmount',
      desc: '',
      args: [],
    );
  }

  /// `Enter transfer amount`
  String get enterTransferAmount {
    return Intl.message(
      'Enter transfer amount',
      name: 'enterTransferAmount',
      desc: '',
      args: [],
    );
  }

  /// `Max transferable: ¥{amount}`
  String maxTransferable(String amount) {
    return Intl.message(
      'Max transferable: ¥$amount',
      name: 'maxTransferable',
      desc: '',
      args: [amount],
    );
  }

  /// `Transferred balance can be used for in-app purchases`
  String get transferNote {
    return Intl.message(
      'Transferred balance can be used for in-app purchases',
      name: 'transferNote',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Transfer`
  String get confirmTransfer {
    return Intl.message(
      'Confirm Transfer',
      name: 'confirmTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Please enter transfer amount`
  String get enterTransferAmountError {
    return Intl.message(
      'Please enter transfer amount',
      name: 'enterTransferAmountError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid transfer amount`
  String get invalidTransferAmount {
    return Intl.message(
      'Please enter valid transfer amount',
      name: 'invalidTransferAmount',
      desc: '',
      args: [],
    );
  }

  /// `Transfer amount cannot exceed ¥{amount}`
  String transferAmountExceeded(String amount) {
    return Intl.message(
      'Transfer amount cannot exceed ¥$amount',
      name: 'transferAmountExceeded',
      desc: '',
      args: [amount],
    );
  }

  /// `Transfer success! Transferred ¥{amount} to wallet`
  String transferSuccessMsg(String amount) {
    return Intl.message(
      'Transfer success! Transferred ¥$amount to wallet',
      name: 'transferSuccessMsg',
      desc: '',
      args: [amount],
    );
  }

  /// `Transfer failed: {error}`
  String transferFailed(String error) {
    return Intl.message(
      'Transfer failed: $error',
      name: 'transferFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Total {count} records`
  String totalRecords(int count) {
    return Intl.message(
      'Total $count records',
      name: 'totalRecords',
      desc: '',
      args: [count],
    );
  }

  /// `Page {page}`
  String pageNumber(int page) {
    return Intl.message(
      'Page $page',
      name: 'pageNumber',
      desc: '',
      args: [page],
    );
  }

  /// `Order: {orderNo}`
  String orderNumber(String orderNo) {
    return Intl.message(
      'Order: $orderNo',
      name: 'orderNumber',
      desc: '',
      args: [orderNo],
    );
  }

  /// `Order amount: {amount}`
  String orderAmount(String amount) {
    return Intl.message(
      'Order amount: $amount',
      name: 'orderAmount',
      desc: '',
      args: [amount],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Switch Theme`
  String get switchTheme {
    return Intl.message(
      'Switch Theme',
      name: 'switchTheme',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Select Theme`
  String get selectTheme {
    return Intl.message(
      'Select Theme',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get confirmLogout {
    return Intl.message(
      'Confirm Logout',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to logout? You need to login again.`
  String get logoutConfirmMsg {
    return Intl.message(
      'Are you sure to logout? You need to login again.',
      name: 'logoutConfirmMsg',
      desc: '',
      args: [],
    );
  }

  /// `Logged out successfully`
  String get loggedOutSuccess {
    return Intl.message(
      'Logged out successfully',
      name: 'loggedOutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Logout failed: {error}`
  String logoutFailed(String error) {
    return Intl.message(
      'Logout failed: $error',
      name: 'logoutFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message('Complete', name: 'complete', desc: '', args: []);
  }

  /// `No invitation data`
  String get noInvitationData {
    return Intl.message(
      'No invitation data',
      name: 'noInvitationData',
      desc: '',
      args: [],
    );
  }

  /// `Force update: {version}`
  String updateCheckForceUpdate(String version) {
    return Intl.message(
      'Force update: $version',
      name: 'updateCheckForceUpdate',
      desc: '',
      args: [version],
    );
  }

  /// `New version found: {version}`
  String updateCheckNewVersionFound(String version) {
    return Intl.message(
      'New version found: $version',
      name: 'updateCheckNewVersionFound',
      desc: '',
      args: [version],
    );
  }

  /// `Current version: {version}`
  String updateCheckCurrentVersion(String version) {
    return Intl.message(
      'Current version: $version',
      name: 'updateCheckCurrentVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Release Notes:`
  String get updateCheckReleaseNotes {
    return Intl.message(
      'Release Notes:',
      name: 'updateCheckReleaseNotes',
      desc: '',
      args: [],
    );
  }

  /// `Update Later`
  String get updateCheckUpdateLater {
    return Intl.message(
      'Update Later',
      name: 'updateCheckUpdateLater',
      desc: '',
      args: [],
    );
  }

  /// `Must Update`
  String get updateCheckMustUpdate {
    return Intl.message(
      'Must Update',
      name: 'updateCheckMustUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get updateCheckUpdateNow {
    return Intl.message(
      'Update Now',
      name: 'updateCheckUpdateNow',
      desc: '',
      args: [],
    );
  }

  /// `Update server URL not configured, please check configuration`
  String get updateCheckServerUrlNotConfigured {
    return Intl.message(
      'Update server URL not configured, please check configuration',
      name: 'updateCheckServerUrlNotConfigured',
      desc: '',
      args: [],
    );
  }

  /// `No update server URLs configured, please check configuration`
  String get updateCheckNoServerUrlsConfigured {
    return Intl.message(
      'No update server URLs configured, please check configuration',
      name: 'updateCheckNoServerUrlsConfigured',
      desc: '',
      args: [],
    );
  }

  /// `All configured update servers are unavailable`
  String get updateCheckAllServersUnavailable {
    return Intl.message(
      'All configured update servers are unavailable',
      name: 'updateCheckAllServersUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Server returned error status code {statusCode}`
  String updateCheckServerError(int statusCode) {
    return Intl.message(
      'Server returned error status code $statusCode',
      name: 'updateCheckServerError',
      desc: '',
      args: [statusCode],
    );
  }

  /// `Server temporarily unavailable, please try again later`
  String get updateCheckServerTemporarilyUnavailable {
    return Intl.message(
      'Server temporarily unavailable, please try again later',
      name: 'updateCheckServerTemporarilyUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Online Support`
  String get onlineSupportTitle {
    return Intl.message(
      'Online Support',
      name: 'onlineSupportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Successfully connected to support system`
  String get onlineSupportConnected {
    return Intl.message(
      'Successfully connected to support system',
      name: 'onlineSupportConnected',
      desc: '',
      args: [],
    );
  }

  /// `Connecting...`
  String get onlineSupportConnecting {
    return Intl.message(
      'Connecting...',
      name: 'onlineSupportConnecting',
      desc: '',
      args: [],
    );
  }

  /// `Disconnected`
  String get onlineSupportDisconnected {
    return Intl.message(
      'Disconnected',
      name: 'onlineSupportDisconnected',
      desc: '',
      args: [],
    );
  }

  /// `Connection error`
  String get onlineSupportConnectionError {
    return Intl.message(
      'Connection error',
      name: 'onlineSupportConnectionError',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet, send a message to start consultation`
  String get onlineSupportNoMessages {
    return Intl.message(
      'No messages yet, send a message to start consultation',
      name: 'onlineSupportNoMessages',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your question...`
  String get onlineSupportInputHint {
    return Intl.message(
      'Please enter your question...',
      name: 'onlineSupportInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Send image`
  String get onlineSupportSendImage {
    return Intl.message(
      'Send image',
      name: 'onlineSupportSendImage',
      desc: '',
      args: [],
    );
  }

  /// `Clear history`
  String get onlineSupportClearHistory {
    return Intl.message(
      'Clear history',
      name: 'onlineSupportClearHistory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear all chat history? This action cannot be undone.`
  String get onlineSupportClearHistoryConfirm {
    return Intl.message(
      'Are you sure you want to clear all chat history? This action cannot be undone.',
      name: 'onlineSupportClearHistoryConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get onlineSupportCancel {
    return Intl.message(
      'Cancel',
      name: 'onlineSupportCancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get onlineSupportConfirm {
    return Intl.message(
      'Confirm',
      name: 'onlineSupportConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Select Images`
  String get onlineSupportSelectImages {
    return Intl.message(
      'Select Images',
      name: 'onlineSupportSelectImages',
      desc: '',
      args: [],
    );
  }

  /// `Click to select images`
  String get onlineSupportClickToSelect {
    return Intl.message(
      'Click to select images',
      name: 'onlineSupportClickToSelect',
      desc: '',
      args: [],
    );
  }

  /// `Supports JPG, PNG, GIF, WebP, BMP\nMax 10MB`
  String get onlineSupportSupportedFormats {
    return Intl.message(
      'Supports JPG, PNG, GIF, WebP, BMP\nMax 10MB',
      name: 'onlineSupportSupportedFormats',
      desc: '',
      args: [],
    );
  }

  /// `Add More`
  String get onlineSupportAddMore {
    return Intl.message(
      'Add More',
      name: 'onlineSupportAddMore',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get onlineSupportSend {
    return Intl.message('Send', name: 'onlineSupportSend', desc: '', args: []);
  }

  /// `Failed to select images: {error}`
  String onlineSupportSelectImagesFailed(String error) {
    return Intl.message(
      'Failed to select images: $error',
      name: 'onlineSupportSelectImagesFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Upload failed: {error}`
  String onlineSupportUploadFailed(String error) {
    return Intl.message(
      'Upload failed: $error',
      name: 'onlineSupportUploadFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Online support API configuration not found, please check configuration`
  String get onlineSupportApiConfigNotFound {
    return Intl.message(
      'Online support API configuration not found, please check configuration',
      name: 'onlineSupportApiConfigNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported HTTP method: {method}`
  String onlineSupportUnsupportedHttpMethod(String method) {
    return Intl.message(
      'Unsupported HTTP method: $method',
      name: 'onlineSupportUnsupportedHttpMethod',
      desc: '',
      args: [method],
    );
  }

  /// `Failed to send message: Unable to get authentication token`
  String get onlineSupportSendMessageFailed {
    return Intl.message(
      'Failed to send message: Unable to get authentication token',
      name: 'onlineSupportSendMessageFailed',
      desc: '',
      args: [],
    );
  }

  /// `Authentication token not found`
  String get onlineSupportTokenNotFound {
    return Intl.message(
      'Authentication token not found',
      name: 'onlineSupportTokenNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get messages: {statusCode}`
  String onlineSupportGetMessagesFailed(int statusCode) {
    return Intl.message(
      'Failed to get messages: $statusCode',
      name: 'onlineSupportGetMessagesFailed',
      desc: '',
      args: [statusCode],
    );
  }

  /// `Support`
  String get contactSupport {
    return Intl.message('Support', name: 'contactSupport', desc: '', args: []);
  }

  /// `Application configuration error, please contact support`
  String get configurationError {
    return Intl.message(
      'Application configuration error, please contact support',
      name: 'configurationError',
      desc: '',
      args: [],
    );
  }

  /// `Online support WebSocket configuration not found, please check configuration`
  String get onlineSupportWebSocketConfigNotFound {
    return Intl.message(
      'Online support WebSocket configuration not found, please check configuration',
      name: 'onlineSupportWebSocketConfigNotFound',
      desc: '',
      args: [],
    );
  }

  /// `New message from support`
  String get newMessageFromSupport {
    return Intl.message(
      'New message from support',
      name: 'newMessageFromSupport',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
