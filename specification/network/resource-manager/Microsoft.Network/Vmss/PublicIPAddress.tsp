import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace microsoft.Compute;
/**
 * Public IP address resource.
 */
model PublicIPAddress
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<PublicIPAddressPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = PublicIPAddress,
    KeyName = "publicIpAddressName",
    SegmentName = "publicipaddresses",
    NamePattern = ""
  >;

  /**
   * The extended location of the public ip address.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  /**
   * The public IP address SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: PublicIPAddressSku;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

alias PublicIPAddressOps = Azure.ResourceManager.Legacy.RoutedOperations<
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
interface PublicIPAddresses {
  /**
   * Get the specified public IP address in a virtual machine scale set.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}")
  getVirtualMachineScaleSetPublicIPAddress is PublicIPAddressOps.ActionSync<
    PublicIPAddress,
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

      @path
      @key
      publicIpAddressName: string;

      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<PublicIPAddress>
  >;

  /**
   * Gets information about all public IP addresses in a virtual machine IP configuration in a virtual machine scale set.
   */
  listVirtualMachineScaleSetVMPublicIPAddresses is ArmResourceListByParent<
    PublicIPAddress,
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

      @path
      @segment("ipconfigurations")
      @key
      ipConfigurationName: string;
    }
  >;
}

@@doc(PublicIPAddress.name, "The name of the public IP Address.");
@@doc(PublicIPAddress.properties, "Public IP address properties.");
