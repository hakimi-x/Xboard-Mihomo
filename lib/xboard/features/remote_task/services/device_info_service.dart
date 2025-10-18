import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  
  static Future<Map<String, dynamic>> collectBasicDeviceInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final connectivity = await Connectivity().checkConnectivity();
      
      Map<String, dynamic> deviceInfo = {
        'timestamp': DateTime.now().toIso8601String(),
        'platform': Platform.operatingSystem,
        'app_info': {
          'app_name': packageInfo.appName,
          'package_name': packageInfo.packageName,
          'version': packageInfo.version,
          'build_number': packageInfo.buildNumber,
        },
        'network_info': {
          'connectivity_type': connectivity.map((e) => e.name).toList(),
        },
      };

      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceInfo['device_info'] = {
          'type': 'android',
          'model': androidInfo.model,
          'manufacturer': androidInfo.manufacturer,
          'brand': androidInfo.brand,
          'device': androidInfo.device,
          'product': androidInfo.product,
          'android_version': androidInfo.version.release,
          'sdk_int': androidInfo.version.sdkInt,
          'is_physical_device': androidInfo.isPhysicalDevice,
          'hardware': androidInfo.hardware,
          'bootloader': androidInfo.bootloader,
          'fingerprint': androidInfo.fingerprint,
          'host': androidInfo.host,
          'display': androidInfo.display,
          'supported_abis': androidInfo.supportedAbis,
          'supported_32bit_abis': androidInfo.supported32BitAbis,
          'supported_64bit_abis': androidInfo.supported64BitAbis,
        };
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceInfo['device_info'] = {
          'type': 'ios',
          'name': iosInfo.name,
          'model': iosInfo.model,
          'system_name': iosInfo.systemName,
          'system_version': iosInfo.systemVersion,
          'is_physical_device': iosInfo.isPhysicalDevice,
          'machine': iosInfo.utsname.machine,
        };
      } else if (Platform.isWindows) {
        final windowsInfo = await _deviceInfoPlugin.windowsInfo;
        deviceInfo['device_info'] = {
          'type': 'windows',
          'computer_name': windowsInfo.computerName,
          'number_of_cores': windowsInfo.numberOfCores,
          'system_memory_in_megabytes': windowsInfo.systemMemoryInMegabytes,
          'major_version': windowsInfo.majorVersion,
          'minor_version': windowsInfo.minorVersion,
          'build_number': windowsInfo.buildNumber,
        };
      } else if (Platform.isMacOS) {
        final macosInfo = await _deviceInfoPlugin.macOsInfo;
        deviceInfo['device_info'] = {
          'type': 'macos',
          'computer_name': macosInfo.computerName,
          'host_name': macosInfo.hostName,
          'arch': macosInfo.arch,
          'model': macosInfo.model,
          'kernel_version': macosInfo.kernelVersion,
          'os_release': macosInfo.osRelease,
          'major_version': macosInfo.majorVersion,
          'minor_version': macosInfo.minorVersion,
          'patch_version': macosInfo.patchVersion,
        };
      } else if (Platform.isLinux) {
        final linuxInfo = await _deviceInfoPlugin.linuxInfo;
        deviceInfo['device_info'] = {
          'type': 'linux',
          'name': linuxInfo.name,
          'version': linuxInfo.version,
          'id': linuxInfo.id,
          'id_like': linuxInfo.idLike,
          'version_codename': linuxInfo.versionCodename,
          'version_id': linuxInfo.versionId,
          'pretty_name': linuxInfo.prettyName,
          'build_id': linuxInfo.buildId,
          'variant': linuxInfo.variant,
          'variant_id': linuxInfo.variantId,
        };
      }

      return {
        'status': 'success',
        'device_info': deviceInfo,
      };
    } catch (e) {
      return {
        'status': 'error',
        'error_message': '收集设备信息时发生错误: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> collectNetworkInfo() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      
      Map<String, dynamic> networkInfo = {
        'timestamp': DateTime.now().toIso8601String(),
        'connectivity_types': connectivity.map((e) => e.name).toList(),
        'platform': Platform.operatingSystem,
      };

      return {
        'status': 'success',
        'network_info': networkInfo,
      };
    } catch (e) {
      return {
        'status': 'error',
        'error_message': '收集网络信息时发生错误: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> collectSystemResources() async {
    try {
      Map<String, dynamic> systemInfo = {
        'timestamp': DateTime.now().toIso8601String(),
        'platform': Platform.operatingSystem,
      };

      // 获取系统资源信息（通用）
      systemInfo['runtime_info'] = {
        'dart_version': Platform.version,
        'environment': Platform.environment.keys.length,
        'executable': Platform.executable,
        'resolved_executable': Platform.resolvedExecutable,
        'script': Platform.script.toString(),
        'number_of_processors': Platform.numberOfProcessors,
        'locale_name': Platform.localeName,
      };

      // Android特有的系统信息
      if (Platform.isAndroid) {
        systemInfo['android_system'] = await _getAndroidSystemInfo();
      }

      return {
        'status': 'success',
        'system_resources': systemInfo,
      };
    } catch (e) {
      return {
        'status': 'error',
        'error_message': '收集系统资源信息时发生错误: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> _getAndroidSystemInfo() async {
    try {
      // 尝试读取系统文件获取更多信息（这些文件通常可读取，不需要权限）
      Map<String, dynamic> androidSystem = {};

      // CPU信息
      try {
        final cpuInfo = await File('/proc/cpuinfo').readAsString();
        final cpuLines = cpuInfo.split('\n');
        androidSystem['cpu_info'] = {
          'processor_count': cpuLines.where((line) => line.startsWith('processor')).length,
          'model_name': cpuLines.firstWhere((line) => line.startsWith('model name'), orElse: () => '').split(':').last.trim(),
          'hardware': cpuLines.firstWhere((line) => line.startsWith('Hardware'), orElse: () => '').split(':').last.trim(),
        };
      } catch (e) {
        androidSystem['cpu_info'] = {'error': 'Unable to read CPU info: $e'};
      }

      // 内存信息
      try {
        final memInfo = await File('/proc/meminfo').readAsString();
        final memLines = memInfo.split('\n');
        Map<String, String> memData = {};
        for (String line in memLines) {
          if (line.contains(':')) {
            final parts = line.split(':');
            if (parts.length >= 2) {
              memData[parts[0].trim()] = parts[1].trim();
            }
          }
        }
        androidSystem['memory_info'] = memData;
      } catch (e) {
        androidSystem['memory_info'] = {'error': 'Unable to read memory info: $e'};
      }

      // 系统负载
      try {
        final loadAvg = await File('/proc/loadavg').readAsString();
        androidSystem['load_average'] = loadAvg.trim();
      } catch (e) {
        androidSystem['load_average'] = {'error': 'Unable to read load average: $e'};
      }

      // 系统启动时间
      try {
        final uptime = await File('/proc/uptime').readAsString();
        final uptimeSeconds = double.tryParse(uptime.split(' ')[0]) ?? 0;
        androidSystem['uptime_seconds'] = uptimeSeconds;
        androidSystem['uptime_readable'] = '${(uptimeSeconds / 3600).floor()}h ${((uptimeSeconds % 3600) / 60).floor()}m';
      } catch (e) {
        androidSystem['uptime'] = {'error': 'Unable to read uptime: $e'};
      }

      return androidSystem;
    } catch (e) {
      return {'error': 'Failed to get Android system info: $e'};
    }
  }

  static Future<Map<String, dynamic>> collectAppRuntimeInfo() async {
    try {
      Map<String, dynamic> runtimeInfo = {
        'timestamp': DateTime.now().toIso8601String(),
        'platform': Platform.operatingSystem,
        'memory_usage': 'N/A', // Flutter没有直接的内存使用API
        'dart_vm_info': {
          'version': Platform.version,
          'is_debug_mode': true, // 可以通过kDebugMode判断，但这里简化
        },
      };

      return {
        'status': 'success',
        'runtime_info': runtimeInfo,
      };
    } catch (e) {
      return {
        'status': 'error',
        'error_message': '收集应用运行时信息时发生错误: $e',
      };
    }
  }
}