// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface NetworkInterfacesOperationGroup {
  /**
   * Gets all network interfaces in a virtual machine scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkInterfaces_ListVirtualMachineScaleSetNetworkInterfaces")
  @autoRoute
  @get
  @list
  @action("networkInterfaces")
  listVirtualMachineScaleSetNetworkInterfaces is ArmProviderActionSync<
    Response = ResourceListResult<NetworkInterface>,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the virtual machine scale set.
       */
      @path
      @segment("virtualMachineScaleSets")
      virtualMachineScaleSetName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PublicIPAddressesOperationGroup {
  /**
   * Gets information about all public IP addresses on a virtual machine scale set level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PublicIPAddresses_ListVirtualMachineScaleSetPublicIPAddresses")
  @autoRoute
  @get
  @list
  @action("publicipaddresses")
  listVirtualMachineScaleSetPublicIPAddresses is ArmProviderActionSync<
    Response = ResourceListResult<PublicIPAddress>,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the virtual machine scale set.
       */
      @path
      @segment("virtualMachineScaleSets")
      virtualMachineScaleSetName: string;
    }
  >;
}
