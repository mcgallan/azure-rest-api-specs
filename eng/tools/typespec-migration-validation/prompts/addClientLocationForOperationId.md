# Add @@clientLocation for operations with @operationId

As a GitHub Copilot assistant, follow this guide to add `@@clientLocation` decorators for all operations
that use `@operationId` in TypeSpec specifications.

## Understanding User Input

When users request help with adding `@@clientLocation` decorators for operations that have `@operationId`
decorators, they typically provide a {TypeSpec-folder} in the format `{ServiceName}.Management` (where
ServiceName examples include: `Compute`, `Network`, `Storage`, `Dashboard`) or a specific TypeSpec project path.

When the user provides a service folder name, look for the TypeSpec files under that folder and locate the
`back-compatible.tsp` file where client customizations should be added.

If the user does not provide this information, be sure to ask. Use this information to customize your
guidance, especially in the following cases:

- Locating the correct back-compatible.tsp file
- Identifying the correct operation interfaces and namespaces

## Migration Steps

## Step 1: Locate TypeSpec files and identify operations with @operationId

1. **Find the TypeSpec project structure**
   - Location: `{ServiceName}.Management/` folder
   - Key files to examine: `*.tsp` files (especially operation definition files)
   - Target file for modifications: `back-compatible.tsp`

2. **Search for operations with @operationId decorators**
   - Use grep or similar tools to find all `@operationId` usages:

   ```bash
   grep -r "@operationId" *.tsp
   ```

   - Example findings:

   ```typespec
   @operationId("Dashboards_Get")
   get is ArmResourceRead<ManagedDashboard>;
   
   @operationId("Grafanas_Create")
   create is ArmResourceCreateOrReplaceAsync<ManagedGrafana>;
   ```

## Step 2: Extract operation information

For each operation with `@operationId`, identify:

1. **Operation ID pattern**: Extract the prefix from the operationId
   - Example: `"Dashboards_Get"` → prefix is `"Dashboards"`
   - Example: `"Grafanas_Create"` → prefix is `"Grafanas"`

2. **Operation location**: Identify the interface and operation name
   - Example: `ManagedDashboards.get` for a get operation in ManagedDashboards interface
   - Example: `ManagedGrafanas.create` for a create operation in ManagedGrafanas interface

3. **Operation mapping pattern**:

   ```text
   @operationId("Dashboards_Get") → @@clientLocation(ManagedDashboards.get, "Dashboards")
   @operationId("Grafanas_Create") → @@clientLocation(ManagedGrafanas.create, "Grafanas")
   ```

## Step 3: Add @@clientLocation decorators in back-compatible.tsp

1. **Open the back-compatible.tsp file**
   - Location: `{ServiceName}.Management/back-compatible.tsp`
   - Ensure it imports the client generator core:

   ```typespec
   import "@azure-tools/typespec-client-generator-core";
   using Azure.ClientGenerator.Core;
   ```

2. **Add @@clientLocation decorators**
   - Add them in a logical grouping, typically after existing `@@clientName` decorators
   - Follow the pattern: `@@clientLocation(Interface.operation, "Prefix")`
   - Example additions:

   ```typespec
   // Client location customizations for operations with @operationId
   @@clientLocation(ManagedDashboards.get, "Dashboards");
   @@clientLocation(ManagedGrafanas.create, "Grafanas");
   @@clientLocation(ManagedGrafanas.update, "Grafanas");
   @@clientLocation(PrivateEndpointConnections.list, "PrivateEndpointConnections");
   ```

3. **Organize the additions**
   - Group by interface or logical operation categories
   - Add comments to explain the purpose:

   ```typespec
   // @@clientLocation decorators for operations with custom @operationId
   // These ensure consistent operationId generation in the output
   @@clientLocation(ManagedDashboards.get, "Dashboards");
   @@clientLocation(ManagedDashboards.create, "Dashboards");
   @@clientLocation(ManagedDashboards.update, "Dashboards");
   @@clientLocation(ManagedDashboards.delete, "Dashboards");
   
   @@clientLocation(ManagedGrafanas.get, "Grafanas");
   @@clientLocation(ManagedGrafanas.create, "Grafanas");
   @@clientLocation(ManagedGrafanas.update, "Grafanas");
   @@clientLocation(ManagedGrafanas.delete, "Grafanas");
   ```

## Step 4: Validation and Testing

1. **Validate the additions**:
   - Ensure all operations with `@operationId` have corresponding `@@clientLocation` entries
   - Check that the interface.operation references are correct
   - Verify that the prefix strings match the operationId patterns

2. **Compile and test**:

   ```bash
   cd {TypeSpec-folder}
   npx tsp compile .
   ```

3. **Verify the output**:
   - Check that the generated Swagger/OpenAPI files have the expected operationId values
   - Ensure no compilation errors were introduced
   - Verify that client SDK generation works correctly with the new decorators

## Common Patterns and Examples

### Pattern Recognition

- `@operationId("Dashboards_Get")` → `@@clientLocation(ManagedDashboards.get, "Dashboards")`
- `@operationId("Grafanas_Create")` → `@@clientLocation(ManagedGrafanas.create, "Grafanas")`
- `@operationId("PrivateEndpoints_List")` → `@@clientLocation(PrivateEndpointConnections.list, "PrivateEndpoints")`

### Interface Mapping

Identify the correct interface names:

- Dashboard operations → `ManagedDashboards`
- Grafana operations → `ManagedGrafanas`  
- Private endpoint operations → `PrivateEndpointConnections`
- Integration fabric operations → `IntegrationFabrics`

### Operation Name Mapping

Map HTTP operations to TypeSpec operation names:

- GET → `get`
- POST/PUT (create) → `create`
- PATCH → `update`
- DELETE → `delete`
- LIST → `list` or `listBy...`

## Troubleshooting

1. **Interface not found**: Verify the correct interface name in the TypeSpec files
2. **Operation not found**: Check the exact operation name (get, create, update, delete, etc.)
3. **Compilation errors**: Ensure proper import statements and syntax
4. **Incorrect operationId output**: Verify the prefix string matches the expected pattern

This process ensures that all operations with custom `@operationId` decorators have corresponding
`@@clientLocation` decorators for consistent client SDK generation.
