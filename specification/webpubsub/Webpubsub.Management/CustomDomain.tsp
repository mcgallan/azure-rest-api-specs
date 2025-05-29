import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebPubSubResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * A custom domain
 */
@parentResource(WebPubSubResource)
model CustomDomain
  is Azure.ResourceManager.ProxyResource<CustomDomainProperties, false> {
  ...ResourceNameParameter<
    Resource = CustomDomain,
    KeyName = "name",
    SegmentName = "customDomains"
  >;
}

@armResourceOperations
interface CustomDomains {
  /**
   * Get a custom domain.
   */
  @operationId("WebPubSubCustomDomains_Get")
  get is ArmResourceRead<CustomDomain>;

  /**
   * Create or update a custom domain.
   */
  @operationId("WebPubSubCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomDomain,
    Response = ArmResourceCreatedResponse<
      CustomDomain,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = CustomDomain>
    >
  >;

  /**
   * Delete a custom domain.
   */
  @operationId("WebPubSubCustomDomains_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomDomain,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all custom domains.
   */
  @operationId("WebPubSubCustomDomains_List")
  list is ArmResourceListByParent<
    CustomDomain,
    Response = ArmResponse<CustomDomainList>
  >;
}

@@doc(CustomDomain.name, "Custom domain name.");
@@doc(CustomDomain.properties, "Properties of a custom domain.");
@@doc(CustomDomains.createOrUpdate::parameters.resource, "");
