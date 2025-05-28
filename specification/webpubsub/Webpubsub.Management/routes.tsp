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

namespace Microsoft.SignalRService;

interface WebPubSubOperationGroup {
  /**
   * Checks that the resource name is valid and is not already in use.
   */
  @operationId("WebPubSub_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = NameAvailabilityParameters,
    Response = NameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

interface UsagesOperationGroup {
  /**
   * List resource usage quotas by location.
   */
  @operationId("Usages_List")
  @autoRoute
  @get
  @action("usages")
  list is ArmProviderActionSync<
    Response = WebPubSubUsageList,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

interface WebPubSubSharedPrivateLinkResourcesOperationGroup {
  /**
   * List shared private link resources
   */
  @operationId("WebPubSubSharedPrivateLinkResources_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the resource.
     */
    @maxLength(63)
    @minLength(3)
    @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
    @path
    resourceName: string,
  ): ArmResponse<SharedPrivateLinkResourceList> | ErrorResponse;

  /**
   * Get the specified shared private link resource
   */
  @operationId("WebPubSubSharedPrivateLinkResources_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The name of the shared private link resource.
     */
    @maxLength(63)
    @minLength(3)
    @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
    @path
    sharedPrivateLinkResourceName: string,

    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the resource.
     */
    @maxLength(63)
    @minLength(3)
    @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
    @path
    resourceName: string,
  ): ArmResponse<SharedPrivateLinkResource> | ErrorResponse;

  /**
   * Create or update a shared private link resource
   */
  @operationId("WebPubSubSharedPrivateLinkResources_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,

    /**
     * The name of the shared private link resource.
     */
    @maxLength(63)
    @minLength(3)
    @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
    @path
    sharedPrivateLinkResourceName: string,

    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the resource.
     */
    @maxLength(63)
    @minLength(3)
    @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
    @path
    resourceName: string,

    /**
     * The shared private link resource
     */
    @bodyRoot
    parameters: SharedPrivateLinkResource,
  ):
    | ArmResponse<SharedPrivateLinkResource>
    | ArmCreatedResponse<SharedPrivateLinkResource>
    | ArmAcceptedResponse
    | ErrorResponse;

  /**
   * Delete the specified shared private link resource
   */
  @operationId("WebPubSubSharedPrivateLinkResources_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @delete
  delete(
    ...ApiVersionParameter,

    /**
     * The name of the shared private link resource.
     */
    @maxLength(63)
    @minLength(3)
    @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
    @path
    sharedPrivateLinkResourceName: string,

    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the resource.
     */
    @maxLength(63)
    @minLength(3)
    @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
    @path
    resourceName: string,
  ): OkResponse | ArmAcceptedResponse | NoContentResponse | ErrorResponse;
}
