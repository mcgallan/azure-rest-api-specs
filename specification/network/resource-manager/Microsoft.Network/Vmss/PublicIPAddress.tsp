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

@armResourceOperations
interface PublicIPAddresses {
  /**
   * Get the specified public IP address in a virtual machine scale set.
   */
  getVirtualMachineScaleSetPublicIPAddress is ArmResourceRead<
    PublicIPAddress,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets information about all public IP addresses in a virtual machine IP configuration in a virtual machine scale set.
   */
  listVirtualMachineScaleSetVMPublicIPAddresses is ArmResourceListByParent<PublicIPAddress>;
}

@@doc(PublicIPAddress.name, "The name of the public IP Address.");
@@doc(PublicIPAddress.properties, "Public IP address properties.");
