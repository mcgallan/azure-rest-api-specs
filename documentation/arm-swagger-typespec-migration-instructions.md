# ARM Swagger 到 TypeSpec 迁移指南

作为 GitHub Copilot 智能助手，在协助用户迁移 Swagger 规范到 TypeSpec 时，请遵循以下指南。

## 理解用户输入

当用户请求帮助进行 Swagger 到 TypeSpec 迁移时，他们通常会提供 `specification/` 目录下的服务文件夹名称（例如：`compute`、`network`、`storage`）

如果用户没有提供此信息，请务必询问。使用此信息来定制您的指导，特别是在以下情况下：
- 选择适当的转换命令
- 提供与服务类型相关的示例

当用户提供此信息时，请确认并相应地调整您的协助。例如：
- "太好了，我看到您正在处理 `compute` 服务。让我们针对该服务进行迁移步骤的指导。"
- "感谢您分享服务名称。我将指导您将 `storage` 服务迁移到 TypeSpec。"

## 前置条件

在帮助用户将 Swagger 迁移到 TypeSpec 时，首先检查他们是否已经安装了所需的依赖项：

1. 询问用户是否已经在存储库根目录中运行了 `npm install`。
2. 如果他们确认依赖项已安装，您可以继续下一步。
3. 如果他们不确定或尚未安装依赖项，建议在存储库根目录中运行此 PowerShell 命令：

```powershell
npm install
```

经常使用该存储库的用户可能已经安装了依赖项，可以跳过此步骤。

## 步骤 1：使用转换器生成 TypeSpec

根据用户提供的服务信息，指导用户完成以下步骤从他们的 Swagger 规范生成 TypeSpec：

1. 根据用户输入，导航到存储库中的特定服务文件夹：

```powershell
cd specification/{service-folder-name}
```

将 `{service-folder-name}` 替换为用户提供的实际服务名称（例如：`compute`、`storage`、`cognitiveservices`）。

2. 帮助用户为 TypeSpec 文件创建目录。确定 TypeSpec 文件夹名称的方法：

 1. 在 `specification/{service-folder-name}` 目录中查找以"Microsoft."开头的文件夹
 2. TypeSpec 文件夹名称应为 `{ServiceName}.Management`，其中 {ServiceName} 是：
   - 如果存在 Microsoft.* 文件夹：取"Microsoft."后的第二部分（例如："Microsoft.Compute" → "Compute.Management"）
   - 否则：服务文件夹名称的 PascalCase 形式（例如："compute" → "Compute.Management"）

  例如：
  - 如果 `specification/compute` 包含 `Microsoft.Compute` 文件夹，则 TypeSpec 文件夹应为 `Compute.Management`
  - 如果 `specification/cdn` 包含 `Microsoft.Cdn` 文件夹，则 TypeSpec 文件夹应为 `Cdn.Management`

3. 在前一步创建的 {TypeSpec-folder} 文件夹中运行此命令。

   ```powershell
   npx tsp-client convert --swagger-readme {path/to/readme.md} --arm --fully-compatible
   ```

将占位符替换为用户工作区中的实际文件路径。`{path/to/readme.md}` 应指向服务文件夹中的 `readme.md` 文件，通常位于 `specification/{service-folder-name}/resource-manager/readme.md`。

## 步骤 2：审查和调整 TypeSpec

通过以下步骤帮助用户审查和调整他们的 TypeSpec 文件：

1. 编译 TypeSpec 文件以生成 Swagger：

```powershell
cd {TypeSpec-folder}
npx tsp compile .
```

当您需要确定生成的 Swagger 文件的绝对路径时，请检查 TypeSpec 文件夹中的 `tspconfig.yaml` 文件：
   - 查找 `emitter` 配置，特别是 `@azure-tools/typespec-autorest` 发射器
   - 找到 `output-file` 选项，它指定了 Swagger 文件的生成位置
   - {version} 的值从 `main.tsp` 文件中确定：
     - 在 main.tsp 文件中查找名为 `Versions` 或 `ApiVersions` 的枚举
     - 枚举值表示服务支持的 API 版本
     - 例如：`enum Versions { v2023_01_01 = "2023-01-01" }` 
     - 字符串值（例如："2023-01-01"）将在输出路径中替换 {version}
   - {version-status} 的值是 stable 或 preview
   - {service-name} 的值从 `main.tsp` 文件中确定：
     - 主 TypeSpec 文件的命名空间
     - 例如：`namespace Microsoft.Compute;`
     - 在这种情况下，服务名称是 `Microsoft.Compute`

2. 通过运行以下命令下载最新规范作为基线：

```powershell
{root}\eng\tools\typespec-migration-validation\scripts\download-main.ps1 {absolute/path/to/generated/swagger}
```
从其输出中提取下一个命令（它将以"Your next command:"开头），然后运行提取的命令，将 {outputFolder} 替换为输出文件夹参数。

3. 有关比较原始和生成的 Swagger 文件以及修复差异的详细说明，请参考：

<!-- INSTRUCTIONS IMPORT: .github/instructions/comparison.instructions.md -->

此导入提供了以下方面的逐步指导：
- 运行 TypeSpec 迁移验证工具
- 比较原始和生成的 Swagger 文件
- 对您的 TypeSpec 文件进行迭代改进
- 优先处理需要解决的差异
