# 🤖 每日AI头条

全网聚合每日AI资讯，自动从 HackerNews、DEV.to、ArXiv 抓取最新AI头条。

## 使用方法

### 方式一：本地打开（最简单）
直接双击 `index.html` 即可在浏览器中打开。

### 方式二：启动本地服务
双击 `start.bat`，然后在浏览器访问 http://localhost:8080

### 方式三：部署到 GitHub Pages（推荐）
1. 去 https://github.com/settings/tokens 创建一个 Personal Access Token（勾选 repo）
2. 右键 `deploy-github.ps1` → 使用 PowerShell 运行
3. 输入 token，等待部署完成
4. 获得一个 https://你的用户名.github.io/ai-daily/ 的公开链接

## 数据源
- HackerNews Algolia API（免费，无需Key）
- DEV.to API（免费，无需Key）
- ArXiv API（免费，无需Key）

## 功能
- 自动聚合全网AI头条，按热度排序
- 4个分类：今日头条 · 智能体应用 · 工作流开发 · AI前沿
- 每30分钟自动刷新
- 支持本地AI模型做每日摘要（Ollama/OpenAI兼容）
