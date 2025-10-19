/// 页面契约导出文件
/// 
/// 所有页面契约都在这里导出
library;

// FlClash 核心页面契约
export 'home_page_contract.dart';
export 'profiles_page_contract.dart';
export 'proxies_page_contract.dart';
export 'settings_page_contract.dart';

// XBoard 页面契约
// Auth 模块
export 'xboard/auth/login_page_contract.dart';
export 'xboard/auth/register_page_contract.dart';
export 'xboard/auth/forgot_password_page_contract.dart';

// Subscription 模块
export 'xboard/subscription/xboard_home_page_contract.dart';
export 'xboard/subscription/subscription_page_contract.dart';

// Payment 模块
export 'xboard/payment/plan_purchase_page_contract.dart';
export 'xboard/payment/payment_gateway_page_contract.dart';

// Invite 模块
export 'xboard/invite/invite_page_contract.dart';

// OnlineSupport 模块
export 'xboard/online_support/online_support_page_contract.dart';

// 其他页面契约会陆续添加
// export 'connection_page_contract.dart';
// export 'dashboard_page_contract.dart';
// export 'logs_page_contract.dart';

