# 迁移指南：将全局抑制转换为内联抑制

## 概述

本指南旨在帮助开发者将 TypeSpec 和 Swagger 规范中的全局抑制（global suppressions）转换为内联抑制（inline suppressions），并为所有抑制添加适当的理由说明。

## 目标

1. **移除全局抑制**：从 `suppressions.yaml` 文件和 `readme.md` 文件的 `directive` 部分中移除全局抑制
2. **添加内联抑制**：在相应的 TypeSpec 文件中直接添加内联抑制
3. **完善理由说明**：为所有抑制添加清晰、具体的理由说明

## 抑制类型和迁移方法

### 1. TypeSpec 内联抑制

#### 语法格式
```typescript
#suppress "rule-name" "理由说明"
#suppress "@azure-tools/typespec-azure-core/rule-name" "理由说明"
```

#### 常见抑制规则和迁移示例

**a) 操作 ID 相关抑制**
```typescript
// 迁移前（全局抑制）
// suppressions.yaml 中的条目

// 迁移后（内联抑制）
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId for backward compatibility"
@operationId("WebPubSubCustomDomains_Get")
get is ArmResourceRead<CustomDomain>;
```

**b) 响应码相关抑制**
```typescript
#suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility with existing API"
delete is ArmResourceDeleteAsync<CustomDomain>;
```

**c) 文档要求相关抑制**
```typescript
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
Secondary: "Secondary",
```

**d) 命名约定相关抑制**
```typescript
#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name for backward compatibility"
@clientName("getPublicIp", "java")
getPublicIP is WorkloadNetworkPublicIps.get;
```

**e) LRO 和最终状态相关抑制**
```typescript
#suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
@Azure.Core.useFinalStateVia("azure-async-operation")
createOrUpdate is ArmResourceCreateOrUpdateAsync<Resource>;
```

### 2. Swagger/OpenAPI 内联抑制

#### 在 readme.md 文件中的 directive 部分
```yaml
directive:
  - suppress: R4009
    from: WebApps.json
    reason: SystemData will implement in next version
    
  - where: $.definitions.FunctionSecrets.properties.trigger_url
    suppress: R3016
    reason: This requires a breaking change in functions runtime API
```

## 迁移步骤

### 步骤 1：识别全局抑制

1. **检查 `suppressions.yaml` 文件**
   - 位置：`specification/suppressions.yaml`
   - 各服务特定的抑制文件：`specification/{service}/suppressions.yaml`

2. **检查 readme.md 文件中的 directive 部分**
   - 查找所有包含 `suppress:` 的配置

### 步骤 2：分析抑制内容

对每个抑制条目，分析：
- **工具类型**：TypeSpecValidation, AutoRest, 等
- **规则名称**：具体的验证规则
- **适用范围**：特定文件、路径或全局
- **现有理由**：是否已有理由说明

### 步骤 3：转换为内联抑制

#### TypeSpec 文件中的转换

1. **定位相关代码**：找到需要抑制的具体代码位置
2. **添加内联抑制**：在相关代码上方添加 `#suppress` 注释
3. **提供理由**：确保每个抑制都有清晰的理由说明

#### 示例转换
```typescript
// 转换前：全局抑制在 suppressions.yaml
- tool: TypeSpecValidation
  rules: [no-openapi]
  paths: ["webpubsub/SignalRService.Management/CustomDomain.tsp"]
  reason: For backward compatibility

// 转换后：内联抑制
#suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility with existing API"
@operationId("WebPubSubCustomDomains_Get")
get is ArmResourceRead<CustomDomain>;
```

### 步骤 4：完善理由说明

#### 好的理由说明示例

✅ **具体且有帮助**
```typescript
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId for backward compatibility"
#suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility with existing API"
```

✅ **包含行动计划**
```typescript
#suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST REMOVE AT NEXT API VERSION UPDATE"
#suppress "deprecated" "Will be removed in next major version"
```

❌ **避免的理由说明**
```typescript
#suppress "rule-name" "TODO: fix this"
#suppress "rule-name" "temporary"
#suppress "rule-name" "ignore"
```

#### 常用理由模板

1. **向后兼容性**
   - `"For backward compatibility with existing API"`
   - `"Can not change existing operationId for backward compatibility"`
   - `"Can not change existing response codes for backward compatibility"`

2. **计划修复**
   - `"MUST CHANGE ON NEXT UPDATE"`
   - `"Will be fixed in next API version"`
   - `"MUST REMOVE AT NEXT API VERSION UPDATE"`

3. **设计决策**
   - `"Existing service design, non-conforming operation"`
   - `"This is an existing service pattern"`
   - `"Required for this specific use case"`

4. **技术限制**
   - `"This requires a breaking change in runtime API"`
   - `"Breaking change required for proper fix"`

### 步骤 5：验证和测试

1. **编译检查**
   ```bash
   tsp compile .
   ```

2. **验证抑制生效**
   - 确认警告/错误被正确抑制
   - 检查生成的 Swagger 文件

3. **清理全局抑制**
   - 从 `suppressions.yaml` 中移除已迁移的条目
   - 从 `readme.md` 的 directive 中移除相应抑制

## 最佳实践

### 1. 抑制粒度
- **优先级**：尽可能使用最小粒度的抑制
- **精确定位**：在具体的代码元素上添加抑制，而不是整个文件

### 2. 理由说明质量
- **明确性**：理由应该清楚说明为什么需要抑制
- **可操作性**：如果可能，包含何时/如何解决的信息
- **一致性**：在同一项目中使用一致的理由格式

### 3. 维护和更新
- **定期审查**：定期检查和更新抑制理由
- **版本规划**：为计划修复的抑制制定明确的时间表
- **文档更新**：在 API 版本更新时及时移除不再需要的抑制

## 工具和自动化

### 1. 查找抑制的脚本示例
```bash
# 查找所有 TypeSpec 文件中的抑制
grep -r "#suppress" --include="*.tsp" specification/

# 查找所有 suppressions.yaml 文件
find specification/ -name "suppressions.yaml"

# 查找 readme.md 中的抑制指令
grep -r "suppress:" --include="readme.md" specification/
```

### 2. 验证脚本示例
```bash
# 编译所有 TypeSpec 项目
find specification/ -name "tspconfig.yaml" -execdir tsp compile . \;
```

## 常见问题和解决方案

### Q: 如何处理多个文件共享的抑制？
A: 如果多个文件需要相同的抑制，应该在每个文件中分别添加内联抑制，而不是保留全局抑制。

### Q: 抑制的理由可以很简短吗？
A: 理由应该提供足够的信息帮助理解为什么需要抑制。简短是可以的，但必须清晰。

### Q: 如何处理临时抑制？
A: 对于临时抑制，应该包含明确的解决时间表，如 "MUST FIX BEFORE v2.0" 或 "TODO: address in next sprint"。

### Q: 可以使用多个抑制在同一行吗？
A: 是的，可以使用多个 `#suppress` 指令：
```typescript
#suppress "rule1" "reason1"
#suppress "rule2" "reason2"
operation is ArmResourceRead<Resource>;
```

## 检查清单

在完成迁移后，请确认：

- [ ] 所有全局抑制已从 `suppressions.yaml` 移除
- [ ] 所有全局抑制已从 `readme.md` 的 directive 部分移除
- [ ] 每个内联抑制都有适当的理由说明
- [ ] 理由说明遵循最佳实践（具体、可操作、一致）
- [ ] TypeSpec 项目可以成功编译
- [ ] 生成的 Swagger 文件符合预期
- [ ] 没有引入新的验证错误或警告

## 相关资源

- [TypeSpec Azure Core 规则文档](https://azure.github.io/typespec-azure/docs/intro/)
- [TypeSpec 抑制文档](https://typespec.io/docs/)
- [Azure REST API 规范指南](../README.md)
- [CI 修复指南](./ci-fix.md)
