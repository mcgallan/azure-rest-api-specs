import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkInterface.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace microsoft.Compute;
/**
 * IPConfiguration in a network interface.
 */
@parentResource(NetworkInterface)
model NetworkInterfaceIPConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkInterfaceIPConfigurationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkInterfaceIPConfiguration,
    KeyName = "ipConfigurationName",
    SegmentName = "ipConfigurations",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface NetworkInterfaceIPConfigurations {
  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkInterfaces_GetVirtualMachineScaleSetIpConfiguration")
  getVirtualMachineScaleSetIpConfiguration is ArmResourceRead<
    NetworkInterfaceIPConfiguration,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkInterfaces_ListVirtualMachineScaleSetIpConfigurations")
  listVirtualMachineScaleSetIpConfigurations is ArmResourceListByParent<
    NetworkInterfaceIPConfiguration,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@doc(NetworkInterfaceIPConfiguration.name,
  "The name of the ip configuration."
);
@@doc(NetworkInterfaceIPConfiguration.properties,
  "Network interface IP configuration properties."
);
