# DataEyes OpenClaw Installer

DataEyes 的 OpenClaw 一键安装仓库。

适合场景：
- 从 GitHub 分发给测试用户
- 让用户通过终端一条命令完成安装

## 安装特点

- 优先直接执行 `npm install -g openclaw@latest`
- 如果当前环境没有全局安装权限，会自动回退到 `~/.npm-global`
- `curl | bash` 安装优先直接下载 GitHub 压缩包，不强依赖本机预装 `git`
- OpenClaw 模型列表默认只显示 DataEyes 模型，不再混入其他 provider
- 聊天页模型下拉框会限制为 DataEyes 这 3 个模型，不再出现一大串内置 Bedrock 模型
- 自动检测或安装 Node.js 22
- 自动写入 DataEyes 配置
- 自动启动 OpenClaw Gateway
- 安装完成后自动打开本机控制台
- 不修改全局 npm registry
- 不修改 shell 配置文件

## 一键安装

推荐直接在终端执行：

```bash
curl -fsSL https://raw.githubusercontent.com/cyf1124906008-ai/dataeyes-openclaw-installer/main/install.sh | bash
```

这条命令会优先直接下载 GitHub 仓库压缩包；如果压缩包下载失败，才会回退到 `git clone`。

或者先克隆仓库再执行：

```bash
git clone https://github.com/cyf1124906008-ai/dataeyes-openclaw-installer.git
cd dataeyes-openclaw-installer
bash install.sh
```

仓库地址：
- `https://github.com/cyf1124906008-ai/dataeyes-openclaw-installer`

## 安装完成后

默认控制台地址：
- `http://127.0.0.1:18789`

默认配置文件：
- `~/.openclaw/openclaw.json`

默认模型：
- 主模型：`dataeyes/gpt-5.4`
- 自动回退：`dataeyes/claude-opus-4-6`
- 自动回退：`dataeyes/gemini-3.1-pro-preview-customtools`

模型显示策略：
- `GPT-5.4 (Recommended)`：默认主模型，适合大多数场景
- `Claude Opus 4.6 (Quality)`：偏高质量输出
- `Gemini 3.1 Pro (Backup)`：作为备用回退模型

OpenClaw 命令位置说明：
- 如果当前机器允许直接全局安装，`openclaw` 会进入 npm 全局路径
- 如果当前机器没有全局安装权限，会自动回退到 `~/.npm-global/bin/openclaw`

如果安装后当前终端找不到 `openclaw`，先执行：

```bash
export PATH="$HOME/.npm-global/bin:$PATH"
```

## 图文教程

### 方式一：终端一键安装

1. 打开终端。
2. 执行下面这条命令：

```bash
curl -fsSL https://raw.githubusercontent.com/cyf1124906008-ai/dataeyes-openclaw-installer/main/install.sh | bash
```

3. 按提示输入 DataEyes API Key。
4. 等待安装器自动完成 OpenClaw 安装、配置写入和 Gateway 启动。
5. 安装完成后，浏览器会自动打开本地控制台。

## 常见问题

### 1. 为什么没有安装到 `~/.dataeyes-openclaw`

因为现在的安装策略已经改成：
- 优先直接使用 `npm install -g openclaw@latest`
- 没有权限时再回退到 `~/.npm-global`

这样更符合大家对 Node CLI 的常见使用习惯。

### 2. 网络慢的时候会卡多久

如果当前机器没有可用的 Node.js 22，安装器会先下载 Node.js，再安装 OpenClaw。网络较慢时持续几分钟属于正常现象。

## 仓库结构

- `install.sh`
  GitHub 安装入口
- `内部文件/`
  真实安装逻辑
- `图片教程/`
  安装引导图片
