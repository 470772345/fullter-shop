# 📺 Flutter Stream

[![Flutter Version](https://img.shields.io/badge/flutter-3.19+-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![CI Status](https://github.com/yourname/flutter-stream/actions/workflows/ci.yml/badge.svg)](https://github.com/yourname/flutter-stream/actions)

高性能 Flutter 直播应用解决方案，支持低延迟推流/拉流、实时互动与跨平台部署。

👉 [Demo 体验](https://your-demo-link.com) | 📚 [开发文档](https://your-docs-link.com)

---

## ✨ 核心功能
- **超低延迟直播**：基于 WebRTC + RTMP 双协议引擎 (<500ms 延迟)
- **动态弹幕系统**：支持表情弹幕、礼物特效、实时消息同步
- **多分辨率切换**：自适应 360P/720P/1080P 码率调节
- **跨平台支持**：iOS / Android / Web 全平台适配
- **主播控制台**：美颜滤镜、屏幕共享、连麦 PK 功能

---

## 🚀 技术栈
| 模块               | 技术方案                     | 说明                          |
|--------------------|-----------------------------|-----------------------------|
| **播放器内核**     | `libVLC` + FFmpeg           | 支持 HLS/DASH 硬解          |  
| **推流 SDK**       | `media_kit` + 自研编码层     | 自适应码率控制               |
| **实时通信**       | Agora SDK / Socket.io       | 信令控制+弹幕同步            |
| **状态管理**       | Riverpod 2.0               | 响应式业务逻辑分离           |
| **动态渲染**       | Rive / Lottie              | 礼物特效与动画交互           |
| **后端对接**       | GraphQL + Protobuf         | 高并发数据流优化             |

---

## 🛠️ 快速开始

### 环境准备
```bash
flutter version 3.19.0+  # 必需
ffmpeg_kit_flutter: ^5.1.0  # 核心依赖
