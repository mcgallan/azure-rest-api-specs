## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Network/operations'].get.tags__added` | added | `["Operations"]` |
| `tags__added` | added | `[{"name":"Operations"}]` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__added` | added | `{"type":"object","properties":{"provider":{"type":"string"},"resource":{"type":"string"},"operation"...` |

### Changes for `OperationPropertiesFormatServiceSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationPropertiesFormatServiceSpecification__added` | added | `{"type":"object","properties":{"metricSpecifications":{"type":"array","items":{"$ref":"#/definitions...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.type__deleted` | deleted | `object` |
| `definitions.OperationPropertiesFormat.properties.serviceSpecification.type__deleted` | deleted | `object` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.properties__deleted` | deleted | `{"provider":{"type":"string","description":"Service provider: Microsoft Network."},"resource":{"type...` |
| `definitions.OperationPropertiesFormat.properties.serviceSpecification.properties__deleted` | deleted | `{"metricSpecifications":{"type":"array","description":"Operation service specification.","items":{"$...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.$ref__added` | added | `#/definitions/OperationDisplay` |
| `definitions.OperationPropertiesFormat.properties.serviceSpecification.$ref__added` | added | `#/definitions/OperationPropertiesFormatServiceSpecification` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/providers/microsoft.Network/operations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |

