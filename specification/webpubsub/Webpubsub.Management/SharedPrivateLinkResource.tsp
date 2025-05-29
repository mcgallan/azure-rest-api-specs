import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Replica.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * Describes a Shared Private Link Resource
 */
@parentResource(Replica)
model SharedPrivateLinkResource
  is Azure.ResourceManager.ProxyResource<SharedPrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = SharedPrivateLinkResource,
    KeyName = "sharedPrivateLinkResourceName",
    SegmentName = "sharedPrivateLinkResources",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface SharedPrivateLinkResources {
  /**
   * Get the specified shared private link resource
   */
  @operationId("WebPubSubReplicaSharedPrivateLinkResources_Get")
  get is ArmResourceRead<SharedPrivateLinkResource>;

  /**
   * Create or update a shared private link resource
   */
  @operationId("WebPubSubReplicaSharedPrivateLinkResources_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SharedPrivateLinkResource>;

  /**
   * List shared private link resources
   */
  @operationId("WebPubSubReplicaSharedPrivateLinkResources_List")
  list is ArmResourceListByParent<
    SharedPrivateLinkResource,
    Response = ArmResponse<SharedPrivateLinkResourceList>
  >;
}

@@maxLength(SharedPrivateLinkResource.name, 63);
@@minLength(SharedPrivateLinkResource.name, 3);
@@doc(SharedPrivateLinkResource.name,
  "The name of the shared private link resource."
);
@@doc(SharedPrivateLinkResource.properties,
  "Describes the properties of an existing Shared Private Link Resource"
);
@@doc(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "The shared private link resource"
);
