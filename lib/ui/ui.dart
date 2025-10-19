/// UI 抽象层导出文件
/// 
/// 这个文件导出所有 UI 抽象层的公共 API
library;

// 核心类
export 'registry/ui_registry.dart';
export 'theme_package_base.dart';
export 'contracts/contract_base.dart';

// 契约（按需导出，具体的契约在各自的文件中）
export 'contracts/pages/pages_contracts.dart';
export 'contracts/components/components_contracts.dart';

