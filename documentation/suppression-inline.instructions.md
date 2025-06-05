# ARM Swagger 到 TypeSpec 迁移指南

作为 GitHub Copilot 智能助手，在协助用户迁移 Swagger 规范到 TypeSpec 时，请遵循以下指南。

## 理解用户输入

当用户请求帮助处理将 TypeSpec 和 Swagger 规范中的全局抑制（global suppressions）转换为内联抑制（inline suppressions），并为所有抑制添加适当的理由说明时，他们通常会提供形式为`{ServiceName}.Management`的{TypeSpec-folder}文件夹（ServiceName例如：`Compute`、`NNetwork`、`SStorage`）或者是一个名为 `tspconfig.yaml` 的文件。

当用户提供的时服务文件夹的名称时，请寻找该文件夹下的 `tspconfig.yaml`，并基于该文件中的内容来开展后续工作

如果用户提供的时 `tspconfig.yaml` 文件，请直接使用该文件中的信息来指导迁移，此时{TypeSpec-folder}是该文件所在的文件夹。

如果用户没有提供此信息，请务必询问。使用此信息来定制您的指导，特别是在以下情况下：
- 选择适当的转换命令
- 提供与服务类型相关的示例

## 迁移步骤

## 步骤 1：定位到tspconfig.yaml文件

1. 1. **检查 `tspconfig.yaml` 文件**
   - 位置：`{ServiceName}.Management/tspconfig.yaml`或者用户直接提供的 `tspconfig.yaml` 文件

2. **检查 tspconfig.yaml 文件中的 disable 部分**
   - 查找所有位于 `disable:` 的配置，格式例如：
    ```yaml
    disable:
    "@azure-tools/typespec-azure-core/no-nullable": "backward-compatibility"
    ```
   - 这些配置表示全局抑制，您需要将其转换为内联抑制。

## 步骤 2：迁移全局抑制到内联抑制

1.移除掉 `tspconfig.yaml` 文件中的 `disable:` 部分。

2.重新对tsp文件进行编译，生成新的 Swagger 文件，同时复现之前被全局抑制的warning。

```powershell
cd {TypeSpec-folder}
npx tsp compile .
```
3.对于在编译过程中出现的全部警告，您需要在相应的 TypeSpec 文件中添加内联抑制。内联抑制的格式如下：

```typespec
#suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility with existing API"
@operationId("WebPubSubCustomDomains_Get")
get is ArmResourceRead<CustomDomain>;
```
需要注意的是，内联抑制需要放在相关代码的上方，并且需要提供清晰的理由说明，示例中的理由说明为 "For backward compatibility with existing API"就是一个很好的理由说明。

## 步骤 3：验证和测试
1. **验证内联抑制**：
   - 确保所有内联抑制都已正确添加，并且理由说明清晰明了。
   - 重新编译 TypeSpec 文件，确保没有新的警告或错误。