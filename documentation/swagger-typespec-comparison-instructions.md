# Swagger 到 TypeSpec 迁移指南 - 验证步骤

遵循以下步骤指导用户在初始转换后比较 Swagger 和 TypeSpec 规范，以验证迁移结果：

## 理解用户输入
当用户请求帮助比较 Swagger 和 TypeSpec 规范时，他们通常会提供 `specification/` 下的服务文件夹名称（例如：`compute`、`network`、`storage`）。如果未提供此信息，请务必询问。

1. 首先，确定生成的 Swagger 文件的绝对路径。检查 TypeSpec 文件夹中的 `tspconfig.yaml` 文件：
   - 查找 `emitter` 配置，特别是 `@azure-tools/typespec-autorest` 发射器
   - 找到 `output-file` 选项，它指定了 Swagger 文件的生成位置
   - `{version}` 的值由 `main.tsp` 文件确定：
     - 在 main.tsp 文件中查找名为 `Versions` 或 `ApiVersions` 的枚举
     - 枚举值表示服务支持的 API 版本
     - 例如：`enum Versions { v2023_01_01 = "2023-01-01" }` 
     - 字符串值（例如："2023-01-01"）是输出路径中 {version} 的替换值
   - `{version-status}` 的值为 stable 或 preview
   - `{service-name}` 的值由 `main.tsp` 文件确定：
     - 主 TypeSpec 文件的命名空间
     - 例如：`namespace Microsoft.Compute;`
     - 在此例中，服务名称为 `Microsoft.Compute`

2. 其次，确定原始 Swagger 文件夹的位置：
   - 原始 Swagger 通常位于 `sparse-spec\specification\{service-folder-name}`
   - 使用最内层文件夹（例如：`sparse-spec\specification\storageactions\resource-manager\Microsoft.StorageActions\stable\2023-01-01`）作为原始 Swagger 文件夹路径
   - 通过运行以下命令检查此文件夹是否存在：
     ```powershell
     Test-Path sparse-spec\specification\{service-folder-name}
     ```
   - 如果文件夹不存在，指导用户运行：
     ```powershell
          {root}\eng\tools\typespec-migration-validation\scripts\download-main.ps1 {absolute/path/to/generated/swagger}
     ```
   - 运行下载脚本后，重新确定原始 Swagger 文件夹的位置，现在应该可以在 `sparse-spec\specification\{service-folder-name}` 的最内层文件夹中找到。

到此为止，您已经收集了以下信息：
- `{TypeSpec-folder}`：包含生成的 Swagger 文件的 TypeSpec 文件夹的绝对路径
- `{original/swagger/folder}`：原始 Swagger 文件夹的绝对路径
- `{generated/swagger/file}`：生成的 Swagger 文件的绝对路径

## 迭代比较和优化过程

遵循以下迭代过程，直到 TypeSpec 生成的 Swagger 与原始文件达到可接受的兼容性：

1. **运行 TypeSpec 迁移验证工具**：
   ```powershell
   npx tsmv {original/swagger/folder} {generated/swagger/file} {outputFolder}
   ```
此命令将在控制台中输出建议的提示，以 `Considering these suggested prompts for the diff:` 开头。

2. **修改 TypeSpec 文件**：
   - 将 `{TypeSpec-folder}` 中的所有 .tsp 文件添加到 GitHub Copilot 的上下文中
   - 使用上一步的建议提示作为 GitHub Copilot 的用户指令
   - 对 TypeSpec 文件应用针对性的更改

3. **重新编译 TypeSpec**：
   ```powershell
   cd {TypeSpec-folder}
   npx tsp compile .
   ```
   - 这将使用您的更改生成更新的 Swagger 文件

4. **重复验证**：
   - 使用相同参数重新运行迁移验证工具
   - 验证您的更改是否解决了目标差异
   - 如果仍存在显著差异，返回步骤 2

继续此循环，直到您解决了最重要的差异或达到满意的兼容性。请记住记录每次迭代中所做的更改，这将有助于跟踪进度并识别未来迁移的模式。

### 推荐的迭代策略

- **迭代 1**：专注于关键路径/路由差异
- **迭代 2**：解决模型/定义命名问题
- **迭代 3**：修复属性类型和必需字段
- **迭代 4**：完善文档和元数据

在每个步骤中，在进入下一类差异之前，运行完整的 验证 → 修改 → 编译 → 重新验证 循环。
