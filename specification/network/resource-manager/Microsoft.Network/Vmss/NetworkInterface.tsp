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
 * A network interface in a resource group.
 */
model NetworkInterface
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NetworkInterfacePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkInterface,
    KeyName = "networkInterfaceName",
    SegmentName = "networkInterfaces",
    NamePattern = ""
  >;

  /**
   * The extended location of the network interface.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface NetworkInterfaces {
  /**
   * Get the specified network interface in a virtual machine scale set.
   */
  getVirtualMachineScaleSetNetworkInterface is ArmResourceRead<
    NetworkInterface,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets information about all network interfaces in a virtual machine in a virtual machine scale set.
   */
  listVirtualMachineScaleSetVMNetworkInterfaces is ArmResourceListByParent<NetworkInterface>;
}

@@doc(NetworkInterface.name, "The name of the network interface.");
@@doc(NetworkInterface.properties, "Properties of the network interface.");
