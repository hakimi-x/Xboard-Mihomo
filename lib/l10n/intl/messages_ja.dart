// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m1(label) => "選択された${label}を削除してもよろしいですか？";

  static String m2(label) => "現在の${label}を削除してもよろしいですか？";

  static String m3(label) => "${label}は空欄にできません";

  static String m4(label) => "現在の${label}は既に存在しています";

  static String m7(label) => "現在${label}はありません";

  static String m8(label) => "${label}は数字でなければなりません";

  static String m9(statusCode) => "メッセージの取得に失敗しました: ${statusCode}";

  static String m10(error) => "画像の選択に失敗しました: ${error}";

  static String m11(method) => "サポートされていないHTTPメソッド: ${method}";

  static String m12(error) => "アップロードに失敗しました: ${error}";

  static String m16(label) => "${label} は 1024 から 49151 の間でなければなりません";

  static String m18(count) => "${count} 項目が選択されています";

  static String m20(date) => "プランは${date}に期限切れになりました。継続利用には更新してください";

  static String m21(days) => "プランは${days}日後に期限切れになります。タイムリーに更新してください";

  static String m22(days) => "サブスクリプションは${days}日後に期限切れになります";

  static String m27(version) => "現在のバージョン: ${version}";

  static String m28(version) => "強制アップデート: ${version}";

  static String m29(version) => "新しいバージョンが見つかりました: ${version}";

  static String m30(statusCode) => "サーバーがエラーステータスコード ${statusCode} を返しました";

  static String m31(label) => "${label}はURLである必要があります";

  static String m34(time) => "実行時間: ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("約"),
    "accessControl": MessageLookupByLibrary.simpleMessage("アクセス制御"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリのみVPNを許可",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "アプリケーションのプロキシアクセスを設定",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリをVPNから除外",
    ),
    "account": MessageLookupByLibrary.simpleMessage("アカウント"),
    "action": MessageLookupByLibrary.simpleMessage("アクション"),
    "action_mode": MessageLookupByLibrary.simpleMessage("モード切替"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "action_start": MessageLookupByLibrary.simpleMessage("開始/停止"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("表示/非表示"),
    "add": MessageLookupByLibrary.simpleMessage("追加"),
    "addRule": MessageLookupByLibrary.simpleMessage("ルールを追加"),
    "addedOriginRules": MessageLookupByLibrary.simpleMessage("元のルールに追加"),
    "address": MessageLookupByLibrary.simpleMessage("アドレス"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("WebDAVサーバーアドレス"),
    "addressTip": MessageLookupByLibrary.simpleMessage("有効なWebDAVアドレスを入力"),
    "adminAutoLaunch": MessageLookupByLibrary.simpleMessage("管理者自動起動"),
    "adminAutoLaunchDesc": MessageLookupByLibrary.simpleMessage("管理者モードで起動"),
    "ago": MessageLookupByLibrary.simpleMessage("前"),
    "agree": MessageLookupByLibrary.simpleMessage("同意"),
    "allApps": MessageLookupByLibrary.simpleMessage("全アプリ"),
    "allowBypass": MessageLookupByLibrary.simpleMessage("アプリがVPNをバイパスすることを許可"),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "有効化すると一部アプリがVPNをバイパス",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("LANを許可"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage("LAN経由でのプロキシアクセスを許可"),
    "app": MessageLookupByLibrary.simpleMessage("アプリ"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage("アプリアクセス制御"),
    "appDesc": MessageLookupByLibrary.simpleMessage("アプリ関連設定の処理"),
    "application": MessageLookupByLibrary.simpleMessage("アプリケーション"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage("アプリ関連設定を変更"),
    "auto": MessageLookupByLibrary.simpleMessage("自動"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage("自動更新チェック"),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "起動時に更新を自動チェック",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage("接続を自動閉じる"),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "ノード変更後に接続を自動閉じる",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("自動起動"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage("システムの自動起動に従う"),
    "autoRun": MessageLookupByLibrary.simpleMessage("自動実行"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage("アプリ起動時に自動実行"),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage("オートセットシステムDNS"),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("自動更新"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage("自動更新間隔（分）"),
    "backup": MessageLookupByLibrary.simpleMessage("バックアップ"),
    "backupAndRecovery": MessageLookupByLibrary.simpleMessage("バックアップと復元"),
    "backupAndRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVまたはファイルでデータを同期",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("バックアップ成功"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("基本設定"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage("基本設定をグローバルに変更"),
    "bind": MessageLookupByLibrary.simpleMessage("バインド"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("ブラックリストモード"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("バイパスドメイン"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage("システムプロキシ有効時のみ適用"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "キャッシュが破損しています。クリアしますか？",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "cancelFilterSystemApp": MessageLookupByLibrary.simpleMessage(
      "システムアプリの除外を解除",
    ),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("全選択解除"),
    "checkError": MessageLookupByLibrary.simpleMessage("確認エラー"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("更新を確認"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage("アプリは最新版です"),
    "checking": MessageLookupByLibrary.simpleMessage("確認中..."),
    "clearData": MessageLookupByLibrary.simpleMessage("データを消去"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("クリップボードにエクスポート"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("クリップボードからインポート"),
    "color": MessageLookupByLibrary.simpleMessage("カラー"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("カラースキーム"),
    "columns": MessageLookupByLibrary.simpleMessage("列"),
    "compatible": MessageLookupByLibrary.simpleMessage("互換モード"),
    "compatibleDesc": MessageLookupByLibrary.simpleMessage(
      "有効化すると一部機能を失いますが、Clashの完全サポートを獲得",
    ),
    "configurationError": MessageLookupByLibrary.simpleMessage(
      "アプリケーション設定エラー、サポートにお問い合わせください",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("確認"),
    "connections": MessageLookupByLibrary.simpleMessage("接続"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage("現在の接続データを表示"),
    "connectivity": MessageLookupByLibrary.simpleMessage("接続性："),
    "contactMe": MessageLookupByLibrary.simpleMessage("連絡する"),
    "contactSupport": MessageLookupByLibrary.simpleMessage("サポートに連絡"),
    "content": MessageLookupByLibrary.simpleMessage("内容"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("コンテンツテーマ"),
    "copy": MessageLookupByLibrary.simpleMessage("コピー"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage("環境変数をコピー"),
    "copyLink": MessageLookupByLibrary.simpleMessage("リンクをコピー"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("コピー成功"),
    "core": MessageLookupByLibrary.simpleMessage("コア"),
    "coreInfo": MessageLookupByLibrary.simpleMessage("コア情報"),
    "country": MessageLookupByLibrary.simpleMessage("国"),
    "crashTest": MessageLookupByLibrary.simpleMessage("クラッシュテスト"),
    "create": MessageLookupByLibrary.simpleMessage("作成"),
    "cut": MessageLookupByLibrary.simpleMessage("切り取り"),
    "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
    "dashboard": MessageLookupByLibrary.simpleMessage("ダッシュボード"),
    "days": MessageLookupByLibrary.simpleMessage("日"),
    "defaultNameserver": MessageLookupByLibrary.simpleMessage("デフォルトネームサーバー"),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "DNSサーバーの解決用",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage("デフォルト順"),
    "defaultText": MessageLookupByLibrary.simpleMessage("デフォルト"),
    "delay": MessageLookupByLibrary.simpleMessage("遅延"),
    "delaySort": MessageLookupByLibrary.simpleMessage("遅延順"),
    "delete": MessageLookupByLibrary.simpleMessage("削除"),
    "deleteMultipTip": m1,
    "deleteTip": m2,
    "desc": MessageLookupByLibrary.simpleMessage(
      "ClashMetaベースのマルチプラットフォームプロキシクライアント。シンプルで使いやすく、オープンソースで広告なし。",
    ),
    "detectionTip": MessageLookupByLibrary.simpleMessage("サードパーティAPIに依存（参考値）"),
    "developerMode": MessageLookupByLibrary.simpleMessage("デベロッパーモード"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "デベロッパーモードが有効になりました。",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("ダイレクト"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("重要なお知らせ"),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "このソフトウェアは現在公開ベータ段階です。更新の通知を受け取った場合は、速やかに更新してください。古いバージョンではサービスが不安定になったり、使用できなくなる場合があります。",
    ),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage("新バージョンを発見"),
    "discovery": MessageLookupByLibrary.simpleMessage("新しいバージョンを発見"),
    "dnsDesc": MessageLookupByLibrary.simpleMessage("DNS関連設定の更新"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNSモード"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage("通過させますか？"),
    "domain": MessageLookupByLibrary.simpleMessage("ドメイン"),
    "domainStatusAvailable": MessageLookupByLibrary.simpleMessage("サービス利用可能"),
    "domainStatusChecking": MessageLookupByLibrary.simpleMessage("確認中..."),
    "domainStatusUnavailable": MessageLookupByLibrary.simpleMessage("サービス利用不可"),
    "download": MessageLookupByLibrary.simpleMessage("ダウンロード"),
    "edit": MessageLookupByLibrary.simpleMessage("編集"),
    "emptyTip": m3,
    "en": MessageLookupByLibrary.simpleMessage("英語"),
    "enableOverride": MessageLookupByLibrary.simpleMessage("上書きを有効化"),
    "entries": MessageLookupByLibrary.simpleMessage(" エントリ"),
    "exclude": MessageLookupByLibrary.simpleMessage("最近のタスクから非表示"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "アプリがバックグラウンド時に最近のタスクから非表示",
    ),
    "existsTip": m4,
    "exit": MessageLookupByLibrary.simpleMessage("終了"),
    "expand": MessageLookupByLibrary.simpleMessage("標準"),
    "expirationTime": MessageLookupByLibrary.simpleMessage("有効期限"),
    "exportFile": MessageLookupByLibrary.simpleMessage("ファイルをエクスポート"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("ログをエクスポート"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("エクスポート成功"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("エクスプレッシブ"),
    "externalController": MessageLookupByLibrary.simpleMessage("外部コントローラー"),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとClashコアをポート9090で制御可能",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("外部リンク"),
    "externalResources": MessageLookupByLibrary.simpleMessage("外部リソース"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeipフィルター"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip範囲"),
    "fallback": MessageLookupByLibrary.simpleMessage("フォールバック"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage("通常はオフショアDNSを使用"),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("フォールバックフィルター"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("ハイファイデリティー"),
    "file": MessageLookupByLibrary.simpleMessage("ファイル"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("プロファイルを直接アップロード"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "ファイルが変更されました。保存しますか？",
    ),
    "filterSystemApp": MessageLookupByLibrary.simpleMessage("システムアプリを除外"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("プロセス検出"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとパフォーマンスが若干低下します",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("フォントファミリー"),
    "fourColumns": MessageLookupByLibrary.simpleMessage("4列"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("フルーツサラダ"),
    "general": MessageLookupByLibrary.simpleMessage("一般"),
    "generalDesc": MessageLookupByLibrary.simpleMessage("一般設定を変更"),
    "geoData": MessageLookupByLibrary.simpleMessage("地域データ"),
    "geodataLoader": MessageLookupByLibrary.simpleMessage("Geo低メモリモード"),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとGeo低メモリローダーを使用",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("GeoIPコード"),
    "getOriginRules": MessageLookupByLibrary.simpleMessage("元のルールを取得"),
    "global": MessageLookupByLibrary.simpleMessage("グローバル"),
    "go": MessageLookupByLibrary.simpleMessage("移動"),
    "goDownload": MessageLookupByLibrary.simpleMessage("ダウンロードへ"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage("変更をキャッシュしますか？"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("ホストを追加"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("ホットキー競合"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("ホットキー管理"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "キーボードでアプリを制御",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("時間"),
    "icon": MessageLookupByLibrary.simpleMessage("アイコン"),
    "iconConfiguration": MessageLookupByLibrary.simpleMessage("アイコン設定"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("アイコンスタイル"),
    "import": MessageLookupByLibrary.simpleMessage("インポート"),
    "importFile": MessageLookupByLibrary.simpleMessage("ファイルからインポート"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "importUrl": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("長期有効"),
    "init": MessageLookupByLibrary.simpleMessage("初期化"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage("正しいホットキーを入力"),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage("インテリジェント選択"),
    "internet": MessageLookupByLibrary.simpleMessage("インターネット"),
    "interval": MessageLookupByLibrary.simpleMessage("インターバル"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("イントラネットIP"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage("有効化するとIPv6トラフィックを受信可能"),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage("IPv6インバウンドを許可"),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "just": MessageLookupByLibrary.simpleMessage("たった今"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "TCPキープアライブ間隔",
    ),
    "key": MessageLookupByLibrary.simpleMessage("キー"),
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "layout": MessageLookupByLibrary.simpleMessage("レイアウト"),
    "light": MessageLookupByLibrary.simpleMessage("ライト"),
    "list": MessageLookupByLibrary.simpleMessage("リスト"),
    "listen": MessageLookupByLibrary.simpleMessage("リスン"),
    "local": MessageLookupByLibrary.simpleMessage("ローカル"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage("ローカルにデータをバックアップ"),
    "localRecoveryDesc": MessageLookupByLibrary.simpleMessage("ファイルからデータを復元"),
    "logLevel": MessageLookupByLibrary.simpleMessage("ログレベル"),
    "logcat": MessageLookupByLibrary.simpleMessage("ログキャット"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage("無効化するとログエントリを非表示"),
    "logs": MessageLookupByLibrary.simpleMessage("ログ"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("ログキャプチャ記録"),
    "logsTest": MessageLookupByLibrary.simpleMessage("ログテスト"),
    "loopback": MessageLookupByLibrary.simpleMessage("ループバック解除ツール"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage("UWPループバック解除用"),
    "loose": MessageLookupByLibrary.simpleMessage("疎"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("メモリ情報"),
    "messageTest": MessageLookupByLibrary.simpleMessage("メッセージテスト"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("これはメッセージです。"),
    "min": MessageLookupByLibrary.simpleMessage("最小化"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("終了時に最小化"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "システムの終了イベントを変更",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("分"),
    "mixedPort": MessageLookupByLibrary.simpleMessage("混合ポート"),
    "mode": MessageLookupByLibrary.simpleMessage("モード"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("モノクローム"),
    "months": MessageLookupByLibrary.simpleMessage("月"),
    "more": MessageLookupByLibrary.simpleMessage("詳細"),
    "name": MessageLookupByLibrary.simpleMessage("名前"),
    "nameSort": MessageLookupByLibrary.simpleMessage("名前順"),
    "nameserver": MessageLookupByLibrary.simpleMessage("ネームサーバー"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage("ドメイン解決用"),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage("ネームサーバーポリシー"),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "対応するネームサーバーポリシーを指定",
    ),
    "network": MessageLookupByLibrary.simpleMessage("ネットワーク"),
    "networkDesc": MessageLookupByLibrary.simpleMessage("ネットワーク関連設定の変更"),
    "networkDetection": MessageLookupByLibrary.simpleMessage("ネットワーク検出"),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("ネットワーク速度"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("ニュートラル"),
    "noData": MessageLookupByLibrary.simpleMessage("データなし"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("ホットキーなし"),
    "noIcon": MessageLookupByLibrary.simpleMessage("なし"),
    "noInfo": MessageLookupByLibrary.simpleMessage("情報なし"),
    "noMoreInfoDesc": MessageLookupByLibrary.simpleMessage("追加情報なし"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("ネットワークなし"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("ネットワークなしアプリ"),
    "noProxy": MessageLookupByLibrary.simpleMessage("プロキシなし"),
    "noProxyDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルを作成するか、有効なプロファイルを追加してください",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("IPを解決しない"),
    "none": MessageLookupByLibrary.simpleMessage("なし"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "現在のプロキシグループは選択できません",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルがありません。追加してください",
    ),
    "nullTip": m7,
    "numberTip": m8,
    "oneColumn": MessageLookupByLibrary.simpleMessage("1列"),
    "onlineSupport": MessageLookupByLibrary.simpleMessage("オンラインサポート"),
    "onlineSupportAddMore": MessageLookupByLibrary.simpleMessage("さらに追加"),
    "onlineSupportApiConfigNotFound": MessageLookupByLibrary.simpleMessage(
      "オンラインサポートAPI設定が見つかりません。設定を確認してください",
    ),
    "onlineSupportCancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "onlineSupportClearHistory": MessageLookupByLibrary.simpleMessage("履歴をクリア"),
    "onlineSupportClearHistoryConfirm": MessageLookupByLibrary.simpleMessage(
      "すべてのチャット履歴をクリアしてもよろしいですか？この操作は元に戻せません。",
    ),
    "onlineSupportClickToSelect": MessageLookupByLibrary.simpleMessage(
      "クリックして画像を選択",
    ),
    "onlineSupportConfirm": MessageLookupByLibrary.simpleMessage("確認"),
    "onlineSupportConnected": MessageLookupByLibrary.simpleMessage(
      "サポートシステムに正常に接続しました",
    ),
    "onlineSupportConnecting": MessageLookupByLibrary.simpleMessage("接続中..."),
    "onlineSupportConnectionError": MessageLookupByLibrary.simpleMessage(
      "接続エラー",
    ),
    "onlineSupportDisconnected": MessageLookupByLibrary.simpleMessage(
      "切断されました",
    ),
    "onlineSupportGetMessagesFailed": m9,
    "onlineSupportInputHint": MessageLookupByLibrary.simpleMessage(
      "ご質問を入力してください...",
    ),
    "onlineSupportNoMessages": MessageLookupByLibrary.simpleMessage(
      "メッセージがありません。メッセージを送信して相談を開始してください",
    ),
    "onlineSupportSelectImages": MessageLookupByLibrary.simpleMessage("画像を選択"),
    "onlineSupportSelectImagesFailed": m10,
    "onlineSupportSend": MessageLookupByLibrary.simpleMessage("送信"),
    "onlineSupportSendImage": MessageLookupByLibrary.simpleMessage("画像を送信"),
    "onlineSupportSendMessageFailed": MessageLookupByLibrary.simpleMessage(
      "メッセージの送信に失敗しました: 認証トークンを取得できません",
    ),
    "onlineSupportSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "JPG、PNG、GIF、WebP、BMP対応\n最大10MB",
    ),
    "onlineSupportTitle": MessageLookupByLibrary.simpleMessage("オンラインサポート"),
    "onlineSupportTokenNotFound": MessageLookupByLibrary.simpleMessage(
      "認証トークンが見つかりません",
    ),
    "onlineSupportUnsupportedHttpMethod": m11,
    "onlineSupportUploadFailed": m12,
    "onlineSupportWebSocketConfigNotFound":
        MessageLookupByLibrary.simpleMessage(
          "オンラインサポートWebSocket設定が見つかりません。設定を確認してください",
        ),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("アイコンのみ"),
    "onlyOtherApps": MessageLookupByLibrary.simpleMessage("サードパーティアプリのみ"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage("プロキシのみ統計"),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロキシトラフィックのみ統計",
    ),
    "options": MessageLookupByLibrary.simpleMessage("オプション"),
    "other": MessageLookupByLibrary.simpleMessage("その他"),
    "otherContributors": MessageLookupByLibrary.simpleMessage("その他の貢献者"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("アウトバウンドモード"),
    "override": MessageLookupByLibrary.simpleMessage("上書き"),
    "overrideDesc": MessageLookupByLibrary.simpleMessage("プロキシ関連設定を上書き"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("DNS上書き"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロファイルのDNS設定を上書き",
    ),
    "overrideInvalidTip": MessageLookupByLibrary.simpleMessage(
      "スクリプトモードでは有効になりません",
    ),
    "overrideOriginRules": MessageLookupByLibrary.simpleMessage("元のルールを上書き"),
    "palette": MessageLookupByLibrary.simpleMessage("パレット"),
    "password": MessageLookupByLibrary.simpleMessage("パスワード"),
    "paste": MessageLookupByLibrary.simpleMessage("貼り付け"),
    "plans": MessageLookupByLibrary.simpleMessage("プラン"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "WebDAVをバインドしてください",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "スクリプト名を入力してください",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "管理者パスワードを入力",
    ),
    "pleaseUploadFile": MessageLookupByLibrary.simpleMessage(
      "ファイルをアップロードしてください",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "有効なQRコードをアップロードしてください",
    ),
    "port": MessageLookupByLibrary.simpleMessage("ポート"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage("別のポートを入力してください"),
    "portTip": m16,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage("DOHのHTTP/3を優先使用"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("キーボードを押してください"),
    "preview": MessageLookupByLibrary.simpleMessage("プレビュー"),
    "profile": MessageLookupByLibrary.simpleMessage("プロファイル"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("有効な間隔形式を入力してください"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("自動更新間隔を入力してください"),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "プロファイルが変更されました。自動更新を無効化しますか？",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイル名を入力してください",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイル解析エラー",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "有効なプロファイルURLを入力してください",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルURLを入力してください",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("プロファイル一覧"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("プロファイルの並び替え"),
    "project": MessageLookupByLibrary.simpleMessage("プロジェクト"),
    "providers": MessageLookupByLibrary.simpleMessage("プロバイダー"),
    "proxies": MessageLookupByLibrary.simpleMessage("プロキシ"),
    "proxiesSetting": MessageLookupByLibrary.simpleMessage("プロキシ設定"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループ"),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("プロキシネームサーバー"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "プロキシノード解決用ドメイン",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("プロキシポート"),
    "proxyPortDesc": MessageLookupByLibrary.simpleMessage("Clashのリスニングポートを設定"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("プロキシプロバイダー"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("純黒モード"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QRコード"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage("QRコードをスキャンしてプロファイルを取得"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("レインボー"),
    "recovery": MessageLookupByLibrary.simpleMessage("復元"),
    "recoveryAll": MessageLookupByLibrary.simpleMessage("全データ復元"),
    "recoveryProfiles": MessageLookupByLibrary.simpleMessage("プロファイルのみ復元"),
    "recoveryStrategy": MessageLookupByLibrary.simpleMessage("リカバリー戦略"),
    "recoveryStrategy_compatible": MessageLookupByLibrary.simpleMessage("互換性"),
    "recoveryStrategy_override": MessageLookupByLibrary.simpleMessage(
      "オーバーライド",
    ),
    "recoverySuccess": MessageLookupByLibrary.simpleMessage("復元成功"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redirポート"),
    "redo": MessageLookupByLibrary.simpleMessage("やり直す"),
    "regExp": MessageLookupByLibrary.simpleMessage("正規表現"),
    "remote": MessageLookupByLibrary.simpleMessage("リモート"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVにデータをバックアップ",
    ),
    "remoteRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVからデータを復元",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("削除"),
    "rename": MessageLookupByLibrary.simpleMessage("リネーム"),
    "requests": MessageLookupByLibrary.simpleMessage("リクエスト"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage("最近のリクエスト記録を表示"),
    "reset": MessageLookupByLibrary.simpleMessage("リセット"),
    "resetTip": MessageLookupByLibrary.simpleMessage("リセットを確定"),
    "resources": MessageLookupByLibrary.simpleMessage("リソース"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage("外部リソース関連情報"),
    "respectRules": MessageLookupByLibrary.simpleMessage("ルール尊重"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS接続がルールに従う（proxy-server-nameserverの設定が必要）",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("ルートアドレス"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage("ルートアドレスを設定"),
    "routeMode": MessageLookupByLibrary.simpleMessage("ルートモード"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "プライベートルートをバイパス",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("設定を使用"),
    "ru": MessageLookupByLibrary.simpleMessage("ロシア語"),
    "rule": MessageLookupByLibrary.simpleMessage("ルール"),
    "ruleName": MessageLookupByLibrary.simpleMessage("ルール名"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("ルールプロバイダー"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("ルール対象"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("変更を保存しますか？"),
    "saveTip": MessageLookupByLibrary.simpleMessage("保存してもよろしいですか？"),
    "script": MessageLookupByLibrary.simpleMessage("スクリプト"),
    "search": MessageLookupByLibrary.simpleMessage("検索"),
    "seconds": MessageLookupByLibrary.simpleMessage("秒"),
    "selectAll": MessageLookupByLibrary.simpleMessage("すべて選択"),
    "selected": MessageLookupByLibrary.simpleMessage("選択済み"),
    "selectedCountTitle": m18,
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "show": MessageLookupByLibrary.simpleMessage("表示"),
    "shrink": MessageLookupByLibrary.simpleMessage("縮小"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("バックグラウンド起動"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage("バックグラウンドで起動"),
    "size": MessageLookupByLibrary.simpleMessage("サイズ"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socksポート"),
    "sort": MessageLookupByLibrary.simpleMessage("並び替え"),
    "source": MessageLookupByLibrary.simpleMessage("ソース"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("送信元IP"),
    "stackMode": MessageLookupByLibrary.simpleMessage("スタックモード"),
    "standard": MessageLookupByLibrary.simpleMessage("標準"),
    "start": MessageLookupByLibrary.simpleMessage("開始"),
    "startVpn": MessageLookupByLibrary.simpleMessage("VPNを開始中..."),
    "status": MessageLookupByLibrary.simpleMessage("ステータス"),
    "statusDesc": MessageLookupByLibrary.simpleMessage("無効時はシステムDNSを使用"),
    "stop": MessageLookupByLibrary.simpleMessage("停止"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("VPNを停止中..."),
    "style": MessageLookupByLibrary.simpleMessage("スタイル"),
    "subRule": MessageLookupByLibrary.simpleMessage("サブルール"),
    "submit": MessageLookupByLibrary.simpleMessage("送信"),
    "subscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションが期限切れです",
    ),
    "subscriptionExpiredDetail": m20,
    "subscriptionExpiresToday": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションが本日期限切れ",
    ),
    "subscriptionExpiresTodayDetail": MessageLookupByLibrary.simpleMessage(
      "プランが本日期限切れになります。サービス中断を避けるため即座に更新してください",
    ),
    "subscriptionExpiringInDays": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションがまもなく期限切れ",
    ),
    "subscriptionExpiringInDaysDetail": m21,
    "subscriptionNoSubscription": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションがありません",
    ),
    "subscriptionNoSubscriptionDetail": MessageLookupByLibrary.simpleMessage(
      "利用可能なサブスクリプションプランが見つかりません。ご利用にはプランをご購入ください",
    ),
    "subscriptionNotLoggedIn": MessageLookupByLibrary.simpleMessage("未ログイン"),
    "subscriptionNotLoggedInDetail": MessageLookupByLibrary.simpleMessage(
      "まずログインしてください",
    ),
    "subscriptionTrafficExhausted": MessageLookupByLibrary.simpleMessage(
      "トラフィックを使い切りました",
    ),
    "subscriptionTrafficExhaustedDetail": MessageLookupByLibrary.simpleMessage(
      "プランのトラフィックを使い切りました。より多くのトラフィックを購入するかプランをアップグレードしてください",
    ),
    "subscriptionValid": MessageLookupByLibrary.simpleMessage("サブスクリプション有効"),
    "subscriptionValidDetail": m22,
    "sync": MessageLookupByLibrary.simpleMessage("同期"),
    "system": MessageLookupByLibrary.simpleMessage("システム"),
    "systemApp": MessageLookupByLibrary.simpleMessage("システムアプリ"),
    "systemFont": MessageLookupByLibrary.simpleMessage("システムフォント"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "HTTPプロキシをVpnServiceに接続",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("タブ"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("タブアニメーション"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage("モバイル表示でのみ有効"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP並列処理"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage("TCP並列処理を許可"),
    "testUrl": MessageLookupByLibrary.simpleMessage("URLテスト"),
    "textScale": MessageLookupByLibrary.simpleMessage("テキストスケーリング"),
    "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
    "themeColor": MessageLookupByLibrary.simpleMessage("テーマカラー"),
    "themeDesc": MessageLookupByLibrary.simpleMessage("ダークモードの設定、色の調整"),
    "themeMode": MessageLookupByLibrary.simpleMessage("テーマモード"),
    "threeColumns": MessageLookupByLibrary.simpleMessage("3列"),
    "tight": MessageLookupByLibrary.simpleMessage("密"),
    "time": MessageLookupByLibrary.simpleMessage("時間"),
    "tip": MessageLookupByLibrary.simpleMessage("ヒント"),
    "toggle": MessageLookupByLibrary.simpleMessage("トグル"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("トーンスポット"),
    "tools": MessageLookupByLibrary.simpleMessage("ツール"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxyポート"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("トラフィック使用量"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage("管理者モードでのみ有効"),
    "twoColumns": MessageLookupByLibrary.simpleMessage("2列"),
    "unableToUpdateCurrentProfileDesc": MessageLookupByLibrary.simpleMessage(
      "現在のプロファイルを更新できません",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("元に戻す"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("統一遅延"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "ハンドシェイクなどの余分な遅延を削除",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("不明"),
    "unnamed": MessageLookupByLibrary.simpleMessage("無題"),
    "update": MessageLookupByLibrary.simpleMessage("更新"),
    "updateCheckAllServersUnavailable": MessageLookupByLibrary.simpleMessage(
      "設定されたすべてのアップデートサーバーが利用できません",
    ),
    "updateCheckCurrentVersion": m27,
    "updateCheckForceUpdate": m28,
    "updateCheckMustUpdate": MessageLookupByLibrary.simpleMessage("アップデート必須"),
    "updateCheckNewVersionFound": m29,
    "updateCheckNoServerUrlsConfigured": MessageLookupByLibrary.simpleMessage(
      "アップデートサーバーURLが設定されていません。設定を確認してください",
    ),
    "updateCheckReleaseNotes": MessageLookupByLibrary.simpleMessage("リリースノート："),
    "updateCheckServerError": m30,
    "updateCheckServerTemporarilyUnavailable":
        MessageLookupByLibrary.simpleMessage(
          "サーバーが一時的に利用できません。しばらくしてから再試行してください",
        ),
    "updateCheckServerUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "アップデートサーバーURLが設定されていません。設定を確認してください",
    ),
    "updateCheckUpdateLater": MessageLookupByLibrary.simpleMessage("後でアップデート"),
    "updateCheckUpdateNow": MessageLookupByLibrary.simpleMessage("今すぐアップデート"),
    "upload": MessageLookupByLibrary.simpleMessage("アップロード"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("URL経由でプロファイルを取得"),
    "urlTip": m31,
    "useHosts": MessageLookupByLibrary.simpleMessage("ホストを使用"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("システムホストを使用"),
    "value": MessageLookupByLibrary.simpleMessage("値"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("ビブラント"),
    "view": MessageLookupByLibrary.simpleMessage("表示"),
    "vpnDesc": MessageLookupByLibrary.simpleMessage("VPN関連設定の変更"),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "VpnService経由で全システムトラフィックをルーティング",
    ),
    "vpnSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "HTTPプロキシをVpnServiceに接続",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage("変更はVPN再起動後に有効"),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage("WebDAV設定"),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("ホワイトリストモード"),
    "xboard24HourCustomerService": MessageLookupByLibrary.simpleMessage(
      "24時間カスタマーサービスサポート",
    ),
    "xboardAccountBalance": MessageLookupByLibrary.simpleMessage("アカウント残高"),
    "xboardAddLinkToConfig": MessageLookupByLibrary.simpleMessage(
      "設定にこのサブスクリプションリンクを追加",
    ),
    "xboardAddingToConfigList": MessageLookupByLibrary.simpleMessage(
      "設定リストに追加中",
    ),
    "xboardAfterPurchasingPlan": MessageLookupByLibrary.simpleMessage(
      "プラン購入後、あなたは以下を享受できます：",
    ),
    "xboardApiUrlNotConfigured": MessageLookupByLibrary.simpleMessage(
      "API URLが設定されていません",
    ),
    "xboardAutoCheckEvery5Seconds": MessageLookupByLibrary.simpleMessage(
      "システムが5秒ごとに自動チェックし、支払い完了後に自動リダイレクトします",
    ),
    "xboardAutoDetectPaymentStatus": MessageLookupByLibrary.simpleMessage(
      "支払い状況を自動検出",
    ),
    "xboardAutoOpeningPaymentPage": MessageLookupByLibrary.simpleMessage(
      "支払いページを自動的に開いています。支払い完了後はアプリに戻ってください",
    ),
    "xboardAutoTesting": MessageLookupByLibrary.simpleMessage("自動テスト中"),
    "xboardBack": MessageLookupByLibrary.simpleMessage("戻る"),
    "xboardBrowserNotOpenedTip": MessageLookupByLibrary.simpleMessage(
      "ブラウザが自動的に開かない場合は、\\\"再開\\\"をクリックするかリンクを手動でコピーしてください",
    ),
    "xboardBuyMoreTrafficOrUpgrade": MessageLookupByLibrary.simpleMessage(
      "より多くのトラフィックを購入するかプランをアップグレードしてください",
    ),
    "xboardBuyNow": MessageLookupByLibrary.simpleMessage("今すぐ購入"),
    "xboardBuyoutPlan": MessageLookupByLibrary.simpleMessage("買い切りプラン"),
    "xboardCancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "xboardCancelPayment": MessageLookupByLibrary.simpleMessage("支払いキャンセル"),
    "xboardCheckPaymentFailed": MessageLookupByLibrary.simpleMessage(
      "支払い状況の確認に失敗しました",
    ),
    "xboardCheckStatus": MessageLookupByLibrary.simpleMessage("ステータス確認"),
    "xboardChecking": MessageLookupByLibrary.simpleMessage("確認中"),
    "xboardCleaningOldConfig": MessageLookupByLibrary.simpleMessage(
      "古い設定をクリーン中",
    ),
    "xboardClearError": MessageLookupByLibrary.simpleMessage("エラーをクリア"),
    "xboardClickToCopy": MessageLookupByLibrary.simpleMessage("クリックしてコピー"),
    "xboardClickToSetupNodes": MessageLookupByLibrary.simpleMessage(
      "クリックしてノードを設定",
    ),
    "xboardCompletePaymentInBrowser": MessageLookupByLibrary.simpleMessage(
      "2. ブラウザで支払いを完了してください",
    ),
    "xboardConfigDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "設定のダウンロードに失敗しました、サブスクリプションリンクを確認してください",
    ),
    "xboardConfigFormatError": MessageLookupByLibrary.simpleMessage(
      "設定形式エラー、サービスプロバイダーにお問い合わせください",
    ),
    "xboardConfigSaveFailed": MessageLookupByLibrary.simpleMessage(
      "設定の保存に失敗しました、ストレージ容量を確認してください",
    ),
    "xboardConfigurationError": MessageLookupByLibrary.simpleMessage("設定エラー"),
    "xboardConfirm": MessageLookupByLibrary.simpleMessage("確認"),
    "xboardConfirmAction": MessageLookupByLibrary.simpleMessage("確認"),
    "xboardConfirmPassword": MessageLookupByLibrary.simpleMessage("パスワード確認"),
    "xboardConfirmPurchase": MessageLookupByLibrary.simpleMessage("購入を確認"),
    "xboardCongratulationsSubscriptionActivated":
        MessageLookupByLibrary.simpleMessage(
          "おめでとうございます！サブスクリプションが正常に購入され、有効化されました",
        ),
    "xboardConnectGlobalQualityNodes": MessageLookupByLibrary.simpleMessage(
      "グローバル品質ノードに接続",
    ),
    "xboardConnectionTimeout": MessageLookupByLibrary.simpleMessage(
      "接続タイムアウト、ネットワーク接続を確認してください",
    ),
    "xboardCopyFailed": MessageLookupByLibrary.simpleMessage("コピーに失敗しました"),
    "xboardCopyLink": MessageLookupByLibrary.simpleMessage("リンクをコピー"),
    "xboardCopyPaymentLink": MessageLookupByLibrary.simpleMessage("リンクをコピー"),
    "xboardCopySubscriptionLinkAbove": MessageLookupByLibrary.simpleMessage(
      "上記のサブスクリプションリンクをコピー",
    ),
    "xboardCouponExpired": MessageLookupByLibrary.simpleMessage("クーポンが期限切れです"),
    "xboardCouponNotYetActive": MessageLookupByLibrary.simpleMessage(
      "クーポンはまだ有効ではありません",
    ),
    "xboardCouponOptional": MessageLookupByLibrary.simpleMessage("クーポン（オプション）"),
    "xboardCreatingOrder": MessageLookupByLibrary.simpleMessage("注文を作成中"),
    "xboardCreatingOrderPleaseWait": MessageLookupByLibrary.simpleMessage(
      "新しい注文を作成しています。お待ちください",
    ),
    "xboardCurrentNode": MessageLookupByLibrary.simpleMessage("現在のノード"),
    "xboardCurrentVersion": MessageLookupByLibrary.simpleMessage("現在のバージョン"),
    "xboardDays": MessageLookupByLibrary.simpleMessage("日"),
    "xboardDeductibleDuringPayment": MessageLookupByLibrary.simpleMessage(
      "支払い時に控除可能",
    ),
    "xboardDiscounted": MessageLookupByLibrary.simpleMessage("割引済み"),
    "xboardDownloadingConfig": MessageLookupByLibrary.simpleMessage(
      "設定ファイルをダウンロード中",
    ),
    "xboardEmail": MessageLookupByLibrary.simpleMessage("メール"),
    "xboardEnableTun": MessageLookupByLibrary.simpleMessage("TUNを有効化"),
    "xboardEnjoyFastNetworkExperience": MessageLookupByLibrary.simpleMessage(
      "高速ネットワーク体験をお楽しみください",
    ),
    "xboardEnterCouponCode": MessageLookupByLibrary.simpleMessage("クーポンコードを入力"),
    "xboardExcellent": MessageLookupByLibrary.simpleMessage("優秀"),
    "xboardExpiryTime": MessageLookupByLibrary.simpleMessage("有効期限"),
    "xboardFailedToCheckPaymentStatus": MessageLookupByLibrary.simpleMessage(
      "支払い状況の確認に失敗しました",
    ),
    "xboardFailedToGetSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "サブスクリプション情報の取得に失敗しました",
    ),
    "xboardFailedToOpenPaymentLink": MessageLookupByLibrary.simpleMessage(
      "支払いリンクを開けませんでした",
    ),
    "xboardFailedToOpenPaymentPage": MessageLookupByLibrary.simpleMessage(
      "支払いページを開けませんでした",
    ),
    "xboardFair": MessageLookupByLibrary.simpleMessage("普通"),
    "xboardForceUpdate": MessageLookupByLibrary.simpleMessage("強制更新"),
    "xboardForgotPassword": MessageLookupByLibrary.simpleMessage("パスワードを忘れた"),
    "xboardGettingIP": MessageLookupByLibrary.simpleMessage("取得中..."),
    "xboardGlobalNodes": MessageLookupByLibrary.simpleMessage("グローバルノード"),
    "xboardGood": MessageLookupByLibrary.simpleMessage("良好"),
    "xboardGroup": MessageLookupByLibrary.simpleMessage("グループ"),
    "xboardHalfYearlyPayment": MessageLookupByLibrary.simpleMessage("半年払い"),
    "xboardHandleLater": MessageLookupByLibrary.simpleMessage("後で処理"),
    "xboardHighSpeedNetwork": MessageLookupByLibrary.simpleMessage("高速ネットワーク"),
    "xboardImportFailed": MessageLookupByLibrary.simpleMessage("インポート失敗"),
    "xboardImportSuccess": MessageLookupByLibrary.simpleMessage("インポート成功"),
    "xboardInsufficientBalance": MessageLookupByLibrary.simpleMessage("残高不足"),
    "xboardInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "無効なユーザー名またはパスワード",
    ),
    "xboardInvalidOrExpiredCoupon": MessageLookupByLibrary.simpleMessage(
      "無効または期限切れのクーポンコード",
    ),
    "xboardInvalidResponseFormat": MessageLookupByLibrary.simpleMessage(
      "サーバーからの無効なレスポンス形式",
    ),
    "xboardInviteCode": MessageLookupByLibrary.simpleMessage("招待コード"),
    "xboardKeepSubscriptionLinkSafe": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションリンクを安全に保管し、他人と共有しないでください",
    ),
    "xboardLater": MessageLookupByLibrary.simpleMessage("後で"),
    "xboardLoadingFailed": MessageLookupByLibrary.simpleMessage("読み込みに失敗しました"),
    "xboardLoadingPaymentPage": MessageLookupByLibrary.simpleMessage(
      "支払いページを読み込み中",
    ),
    "xboardLocalIP": MessageLookupByLibrary.simpleMessage("ローカルIP"),
    "xboardLoggedIn": MessageLookupByLibrary.simpleMessage("ログイン済み"),
    "xboardLogin": MessageLookupByLibrary.simpleMessage("ログイン"),
    "xboardLoginExpired": MessageLookupByLibrary.simpleMessage(
      "ログインが期限切れです、再度ログインしてください",
    ),
    "xboardLoginFailed": MessageLookupByLibrary.simpleMessage("ログイン失敗"),
    "xboardLoginSuccess": MessageLookupByLibrary.simpleMessage("ログイン成功"),
    "xboardLoginToViewSubscription": MessageLookupByLibrary.simpleMessage(
      "サブスクリプション使用状況を確認するにはログインしてください",
    ),
    "xboardLogout": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "xboardLogoutConfirmContent": MessageLookupByLibrary.simpleMessage(
      "ログアウトしますか？再度認証情報を入力する必要があります。",
    ),
    "xboardLogoutConfirmTitle": MessageLookupByLibrary.simpleMessage("ログアウト確認"),
    "xboardLogoutFailed": MessageLookupByLibrary.simpleMessage("ログアウト失敗"),
    "xboardLogoutSuccess": MessageLookupByLibrary.simpleMessage("ログアウト成功"),
    "xboardMissingRequiredField": MessageLookupByLibrary.simpleMessage(
      "必須フィールドが不足しています",
    ),
    "xboardMonthlyPayment": MessageLookupByLibrary.simpleMessage("月払い"),
    "xboardMonthlyRenewal": MessageLookupByLibrary.simpleMessage("毎月更新"),
    "xboardMustUpdate": MessageLookupByLibrary.simpleMessage("更新必須"),
    "xboardNetworkConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "ネットワーク接続に失敗しました、ネットワーク設定を確認してください",
    ),
    "xboardNewVersionFound": MessageLookupByLibrary.simpleMessage(
      "新しいバージョンが見つかりました",
    ),
    "xboardNext": MessageLookupByLibrary.simpleMessage("次へ"),
    "xboardNoAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "利用可能なノードがありません",
    ),
    "xboardNoAvailablePlan": MessageLookupByLibrary.simpleMessage(
      "利用可能なプランがありません",
    ),
    "xboardNoAvailableSubscription": MessageLookupByLibrary.simpleMessage(
      "利用可能なサブスクリプションがありません",
    ),
    "xboardNoInternetConnection": MessageLookupByLibrary.simpleMessage(
      "インターネット接続がありません、ネットワーク設定を確認してください",
    ),
    "xboardNoSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "サブスクリプション情報がありません",
    ),
    "xboardNoSubscriptionPlans": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションプランがありません",
    ),
    "xboardNodeName": MessageLookupByLibrary.simpleMessage("ノード名"),
    "xboardNone": MessageLookupByLibrary.simpleMessage("なし"),
    "xboardNotLoggedIn": MessageLookupByLibrary.simpleMessage("未ログイン"),
    "xboardOneTimePayment": MessageLookupByLibrary.simpleMessage("一回払い"),
    "xboardOpenPaymentFailed": MessageLookupByLibrary.simpleMessage(
      "支払いページを開けませんでした",
    ),
    "xboardOpenPaymentLinkFailed": MessageLookupByLibrary.simpleMessage(
      "支払いリンクを開けませんでした",
    ),
    "xboardOperationFailed": MessageLookupByLibrary.simpleMessage("操作に失敗しました"),
    "xboardOperationTips": MessageLookupByLibrary.simpleMessage("操作のヒント"),
    "xboardOrderCreationFailed": MessageLookupByLibrary.simpleMessage(
      "注文作成に失敗しました",
    ),
    "xboardOrderNotFound": MessageLookupByLibrary.simpleMessage("注文が見つかりません"),
    "xboardOrderNumber": MessageLookupByLibrary.simpleMessage("注文番号"),
    "xboardOrderStatusPending": MessageLookupByLibrary.simpleMessage(
      "注文状況：支払い待ち",
    ),
    "xboardPassword": MessageLookupByLibrary.simpleMessage("パスワード"),
    "xboardPaymentCancelled": MessageLookupByLibrary.simpleMessage(
      "支払いがキャンセルされました",
    ),
    "xboardPaymentComplete": MessageLookupByLibrary.simpleMessage("支払い完了"),
    "xboardPaymentCompleted": MessageLookupByLibrary.simpleMessage("支払い完了！"),
    "xboardPaymentFailed": MessageLookupByLibrary.simpleMessage("支払いに失敗しました"),
    "xboardPaymentGateway": MessageLookupByLibrary.simpleMessage("支払いゲートウェイ"),
    "xboardPaymentInfo": MessageLookupByLibrary.simpleMessage("支払い情報"),
    "xboardPaymentInstructions1": MessageLookupByLibrary.simpleMessage(
      "1. 支払いページが自動的に開かれました",
    ),
    "xboardPaymentInstructions2": MessageLookupByLibrary.simpleMessage(
      "2. ブラウザで支払いを完了してください",
    ),
    "xboardPaymentInstructions3": MessageLookupByLibrary.simpleMessage(
      "3. 支払い後にアプリに戻ると、システムが自動検出します",
    ),
    "xboardPaymentLink": MessageLookupByLibrary.simpleMessage("支払いリンク"),
    "xboardPaymentLinkCopied": MessageLookupByLibrary.simpleMessage(
      "支払いリンクをクリップボードにコピーしました",
    ),
    "xboardPaymentMethodVerified": MessageLookupByLibrary.simpleMessage(
      "支払い方法が確認されました",
    ),
    "xboardPaymentMethodVerifiedPreparing":
        MessageLookupByLibrary.simpleMessage(
          "支払い方法が確認されました。支払いページにリダイレクトする準備中です",
        ),
    "xboardPaymentPageAutoOpened": MessageLookupByLibrary.simpleMessage(
      "1. 支払いページが自動的に開かれました",
    ),
    "xboardPaymentPageOpenedCompleteAndReturn":
        MessageLookupByLibrary.simpleMessage(
          "支払いページが開かれました。支払いを完了してアプリに戻ってください",
        ),
    "xboardPaymentPageOpenedInBrowser": MessageLookupByLibrary.simpleMessage(
      "ブラウザで支払いページが開かれました。支払い完了後はアプリに戻ってください",
    ),
    "xboardPaymentSuccess": MessageLookupByLibrary.simpleMessage("支払い成功"),
    "xboardPaymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "🎉 支払い成功！",
    ),
    "xboardPlanInfo": MessageLookupByLibrary.simpleMessage("プラン情報"),
    "xboardPlanNotFound": MessageLookupByLibrary.simpleMessage("プランが見つかりません"),
    "xboardPlans": MessageLookupByLibrary.simpleMessage("プラン"),
    "xboardPleaseSelectPaymentPeriod": MessageLookupByLibrary.simpleMessage(
      "支払い期間を選択してください",
    ),
    "xboardPoor": MessageLookupByLibrary.simpleMessage("悪い"),
    "xboardPreparingImport": MessageLookupByLibrary.simpleMessage("インポートを準備中"),
    "xboardPreparingPaymentPage": MessageLookupByLibrary.simpleMessage(
      "支払いページを準備中、まもなくリダイレクトします",
    ),
    "xboardPrevious": MessageLookupByLibrary.simpleMessage("前へ"),
    "xboardProcessing": MessageLookupByLibrary.simpleMessage("処理中..."),
    "xboardProfessionalSupport": MessageLookupByLibrary.simpleMessage(
      "プロフェッショナルサポート",
    ),
    "xboardProfile": MessageLookupByLibrary.simpleMessage("プロファイル"),
    "xboardProtectNetworkPrivacy": MessageLookupByLibrary.simpleMessage(
      "ネットワークプライバシーを保護",
    ),
    "xboardProxy": MessageLookupByLibrary.simpleMessage("プロキシ"),
    "xboardProxyMode": MessageLookupByLibrary.simpleMessage("プロキシモード"),
    "xboardProxyModeDirectDescription": MessageLookupByLibrary.simpleMessage(
      "すべてのトラフィックがプロキシなしで直接接続",
    ),
    "xboardProxyModeGlobalDescription": MessageLookupByLibrary.simpleMessage(
      "すべてのトラフィックがプロキシサーバーを通過",
    ),
    "xboardProxyModeRuleDescription": MessageLookupByLibrary.simpleMessage(
      "ルールに基づいて直接またはプロキシを自動選択",
    ),
    "xboardPurchasePlan": MessageLookupByLibrary.simpleMessage("プランを購入"),
    "xboardPurchaseSubscription": MessageLookupByLibrary.simpleMessage(
      "サブスクリプション購入",
    ),
    "xboardPurchaseSubscriptionToUse": MessageLookupByLibrary.simpleMessage(
      "使用するにはサブスクリプションを購入してください",
    ),
    "xboardPurchaseTraffic": MessageLookupByLibrary.simpleMessage("トラフィックを購入"),
    "xboardQuarterlyPayment": MessageLookupByLibrary.simpleMessage("四半期払い"),
    "xboardRefresh": MessageLookupByLibrary.simpleMessage("更新"),
    "xboardRefreshStatus": MessageLookupByLibrary.simpleMessage("ステータスを更新"),
    "xboardRegister": MessageLookupByLibrary.simpleMessage("登録"),
    "xboardRegisterFailed": MessageLookupByLibrary.simpleMessage("登録失敗"),
    "xboardRegisterSuccess": MessageLookupByLibrary.simpleMessage(
      "登録成功！ログインページにリダイレクトしています...",
    ),
    "xboardReload": MessageLookupByLibrary.simpleMessage("再読み込み"),
    "xboardRelogin": MessageLookupByLibrary.simpleMessage("再ログイン"),
    "xboardRememberPassword": MessageLookupByLibrary.simpleMessage("パスワードを記憶"),
    "xboardRenewPlan": MessageLookupByLibrary.simpleMessage("プランを更新"),
    "xboardRenewToContinue": MessageLookupByLibrary.simpleMessage(
      "引き続き使用するには更新してください",
    ),
    "xboardReopen": MessageLookupByLibrary.simpleMessage("再開"),
    "xboardReopenPayment": MessageLookupByLibrary.simpleMessage("支払いを再開"),
    "xboardReopenPaymentPageTip": MessageLookupByLibrary.simpleMessage(
      "再度開くには、下の\\\"再開\\\"ボタンをクリックしてください",
    ),
    "xboardRetry": MessageLookupByLibrary.simpleMessage("再試行"),
    "xboardRetryGet": MessageLookupByLibrary.simpleMessage("再試行"),
    "xboardReturn": MessageLookupByLibrary.simpleMessage("戻る"),
    "xboardReturnAfterPaymentAutoDetect": MessageLookupByLibrary.simpleMessage(
      "3. 支払い後にアプリに戻ると、システムが自動検出します",
    ),
    "xboardRunningTime": m34,
    "xboardSecureEncryption": MessageLookupByLibrary.simpleMessage("セキュア暗号化"),
    "xboardSelectPaymentPeriod": MessageLookupByLibrary.simpleMessage(
      "支払い期間を選択",
    ),
    "xboardSelectPeriod": MessageLookupByLibrary.simpleMessage("購入期間を選択してください"),
    "xboardSendVerificationCode": MessageLookupByLibrary.simpleMessage(
      "認証コードを送信",
    ),
    "xboardServerError": MessageLookupByLibrary.simpleMessage("サーバーエラー"),
    "xboardSetup": MessageLookupByLibrary.simpleMessage("設定"),
    "xboardSixMonthCycle": MessageLookupByLibrary.simpleMessage("6ヶ月サイクル"),
    "xboardSpeedLimit": MessageLookupByLibrary.simpleMessage("速度制限"),
    "xboardStartProxy": MessageLookupByLibrary.simpleMessage("プロキシ開始"),
    "xboardStop": MessageLookupByLibrary.simpleMessage("停止"),
    "xboardStopProxy": MessageLookupByLibrary.simpleMessage("プロキシ停止"),
    "xboardSubscription": MessageLookupByLibrary.simpleMessage("サブスクリプション"),
    "xboardSubscriptionCopied": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションリンクをクリップボードにコピーしました",
    ),
    "xboardSubscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションが期限切れです",
    ),
    "xboardSubscriptionHasExpired": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションが期限切れです",
    ),
    "xboardSubscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "サブスクリプション情報",
    ),
    "xboardSubscriptionLink": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションリンク",
    ),
    "xboardSubscriptionLinkCopied": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションリンクをクリップボードにコピーしました",
    ),
    "xboardSubscriptionPurchase": MessageLookupByLibrary.simpleMessage(
      "サブスクリプション購入",
    ),
    "xboardSubscriptionStatus": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションステータス",
    ),
    "xboardSwitch": MessageLookupByLibrary.simpleMessage("切り替え"),
    "xboardTesting": MessageLookupByLibrary.simpleMessage("テスト中"),
    "xboardThirtySixMonthCycle": MessageLookupByLibrary.simpleMessage(
      "36ヶ月サイクル",
    ),
    "xboardThreeMonthCycle": MessageLookupByLibrary.simpleMessage("3ヶ月サイクル"),
    "xboardThreeYearPayment": MessageLookupByLibrary.simpleMessage("3年払い"),
    "xboardTimeout": MessageLookupByLibrary.simpleMessage("タイムアウト"),
    "xboardTokenExpiredContent": MessageLookupByLibrary.simpleMessage(
      "ログインセッションが期限切れです。続行するには再度ログインしてください。",
    ),
    "xboardTokenExpiredTitle": MessageLookupByLibrary.simpleMessage("ログイン期限切れ"),
    "xboardTraffic": MessageLookupByLibrary.simpleMessage("トラフィック"),
    "xboardTrafficExhausted": MessageLookupByLibrary.simpleMessage(
      "トラフィックを使い切りました",
    ),
    "xboardTrafficUsedUp": MessageLookupByLibrary.simpleMessage(
      "トラフィックを使い切りました",
    ),
    "xboardTunEnabled": MessageLookupByLibrary.simpleMessage("TUNが有効"),
    "xboardTwelveMonthCycle": MessageLookupByLibrary.simpleMessage("12ヶ月サイクル"),
    "xboardTwentyFourMonthCycle": MessageLookupByLibrary.simpleMessage(
      "24ヶ月サイクル",
    ),
    "xboardTwoYearPayment": MessageLookupByLibrary.simpleMessage("2年払い"),
    "xboardUnauthorizedAccess": MessageLookupByLibrary.simpleMessage(
      "認証されていないアクセス、まずログインしてください",
    ),
    "xboardUnknownErrorRetry": MessageLookupByLibrary.simpleMessage(
      "不明なエラー、再試行してください",
    ),
    "xboardUnknownUser": MessageLookupByLibrary.simpleMessage("不明なユーザー"),
    "xboardUnselected": MessageLookupByLibrary.simpleMessage("未選択"),
    "xboardUnsupportedCouponType": MessageLookupByLibrary.simpleMessage(
      "サポートされていないクーポンタイプ",
    ),
    "xboardUpdateContent": MessageLookupByLibrary.simpleMessage("更新内容："),
    "xboardUpdateLater": MessageLookupByLibrary.simpleMessage("後で更新"),
    "xboardUpdateNow": MessageLookupByLibrary.simpleMessage("今すぐ更新"),
    "xboardUpdateSubscriptionRegularly": MessageLookupByLibrary.simpleMessage(
      "定期的にサブスクリプションを更新して最新のノードを取得",
    ),
    "xboardUsageInstructions": MessageLookupByLibrary.simpleMessage("使用方法"),
    "xboardUsed": MessageLookupByLibrary.simpleMessage("使用済み"),
    "xboardUsedTraffic": MessageLookupByLibrary.simpleMessage("使用済み"),
    "xboardValidatingConfigFormat": MessageLookupByLibrary.simpleMessage(
      "設定形式を検証中",
    ),
    "xboardValidationFailed": MessageLookupByLibrary.simpleMessage("検証に失敗しました"),
    "xboardValidityPeriod": MessageLookupByLibrary.simpleMessage("有効期間"),
    "xboardVerify": MessageLookupByLibrary.simpleMessage("検証"),
    "xboardVeryPoor": MessageLookupByLibrary.simpleMessage("非常に悪い"),
    "xboardWaitingForPayment": MessageLookupByLibrary.simpleMessage(
      "支払いを待っています",
    ),
    "xboardWaitingPaymentCompletion": MessageLookupByLibrary.simpleMessage(
      "支払い完了を待機中",
    ),
    "xboardYearlyPayment": MessageLookupByLibrary.simpleMessage("年払い"),
    "years": MessageLookupByLibrary.simpleMessage("年"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("簡体字中国語"),
  };
}
