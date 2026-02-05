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

alias NetworkInterfaceIPConfigurationOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {},
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface NetworkInterfaceIPConfigurations {
  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations/{ipConfigurationName}")
  @operationId("NetworkInterfaces_GetVirtualMachineScaleSetIpConfiguration")
  getVirtualMachineScaleSetIpConfiguration is NetworkInterfaceIPConfigurationOps.ActionSync<
    NetworkInterfaceIPConfiguration,
    Request = void,
    Parameters = {
      @path
      @key
      virtualMachineScaleSetName: string;

      @path
      @key
      virtualmachineIndex: string;

      @path
      @key
      networkInterfaceName: string;

      @path
      @key
      ipConfigurationName: string;

      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<NetworkInterfaceIPConfiguration>
  >;

  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("NetworkInterfaces_ListVirtualMachineScaleSetIpConfigurations")
  listVirtualMachineScaleSetIpConfigurations is ArmResourceListByParent<
    NetworkInterfaceIPConfiguration,
    Parameters = {
      @path
      @segment("virtualMachineScaleSets")
      @key
      virtualMachineScaleSetName: string;

      @path
      @segment("virtualMachines")
      @key
      virtualmachineIndex: string;

      @path
      @segment("networkInterfaces")
      @key
      networkInterfaceName: string;

      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<ResourceListResult<NetworkInterfaceIPConfiguration>>
  >;
}

@@doc(NetworkInterfaceIPConfiguration.name,
  "The name of the ip configuration."
);
@@doc(NetworkInterfaceIPConfiguration.properties,
  "Network interface IP configuration properties."
);
