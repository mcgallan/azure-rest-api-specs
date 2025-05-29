import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;

namespace Microsoft.SignalRService;

/**
 * Optional tier of this particular SKU. 'Standard' or 'Free'.
 *
 * `Basic` is deprecated, use `Standard` instead.
 */
union WebPubSubSkuTier {
  string,

  /** Free tier with limited capabilities and scale */
  Free: "Free",

  /** Basic tier (Deprecated: use Standard instead) */
  Basic: "Basic",

  /** Standard tier with full set of features */
  Standard: "Standard",

  /** Premium tier with enhanced performance and scale */
  Premium: "Premium",
}

/**
 * Provisioning state of the resource.
 */
union ProvisioningState {
  string,

  /** State could not be determined */
  Unknown: "Unknown",

  /** Resource provisioning has succeeded */
  Succeeded: "Succeeded",

  /** Resource provisioning has failed */
  Failed: "Failed",

  /** Resource provisioning was canceled */
  Canceled: "Canceled",

  /** Resource is currently running */
  Running: "Running",

  /** Resource is in the process of being created */
  Creating: "Creating",

  /** Resource is in the process of being updated */
  Updating: "Updating",

  /** Resource is in the process of being deleted */
  Deleting: "Deleting",

  /** Resource is in the process of being moved */
  Moving: "Moving",
}

/**
 * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
 */
union PrivateLinkServiceConnectionStatus {
  string,

  /** Connection is pending approval from the owner */
  Pending: "Pending",

  /** Connection has been approved by the owner */
  Approved: "Approved",

  /** Connection has been rejected by the owner */
  Rejected: "Rejected",

  /** Connection has been removed by the owner */
  Disconnected: "Disconnected",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /** Resource was created by a user */
  User: "User",

  /** Resource was created by an application */
  Application: "Application",

  /** Resource was created by a managed identity */
  ManagedIdentity: "ManagedIdentity",

  /** Resource was created using an access key */
  Key: "Key",
}

/**
 * Status of the shared private link resource
 */
union SharedPrivateLinkResourceStatus {
  string,

  /** The shared private link resource request is pending approval */
  Pending: "Pending",

  /** The shared private link resource has been approved */
  Approved: "Approved",

  /** The shared private link resource has been rejected */
  Rejected: "Rejected",

  /** The shared private link resource has been disconnected */
  Disconnected: "Disconnected",

  /** The shared private link resource request has timed out */
  Timeout: "Timeout",
}

/**
 * Azure Networking ACL Action.
 */
union ACLAction {
  string,

  /** Allow the network request */
  Allow: "Allow",

  /** Deny the network request */
  Deny: "Deny",
}

/**
 * The incoming request type to the service
 */
union WebPubSubRequestType {
  string,

  /** Connection from a client */
  ClientConnection: "ClientConnection",

  /** Connection from a server */
  ServerConnection: "ServerConnection",

  /** Request through REST API */
  RESTAPI: "RESTAPI",

  /** Trace or diagnostic request */
  Trace: "Trace",
}

/**
 * Discriminator for client connection count throttling rules
 */
union ClientConnectionCountRuleDiscriminator {
  string,

  /** Throttle by JWT signature */
  ThrottleByJwtSignatureRule: "ThrottleByJwtSignatureRule",

  /** Throttle by user ID */
  ThrottleByUserIdRule: "ThrottleByUserIdRule",

  /** Throttle by JWT custom claim */
  ThrottleByJwtCustomClaimRule: "ThrottleByJwtCustomClaimRule",
}

/**
 * Discriminator for client traffic control throttling rules
 */
union ClientTrafficControlRuleDiscriminator {
  string,

  /** Traffic throttle by JWT signature */
  TrafficThrottleByJwtSignatureRule: "TrafficThrottleByJwtSignatureRule",

  /** Traffic throttle by user ID */
  TrafficThrottleByUserIdRule: "TrafficThrottleByUserIdRule",

  /** Traffic throttle by JWT custom claim */
  TrafficThrottleByJwtCustomClaimRule: "TrafficThrottleByJwtCustomClaimRule",
}

/**
 * The kind of the service
 */
union ServiceKind {
  string,

  /** WebPubSub service using Azure WebPubSub protocol */
  WebPubSub: "WebPubSub",

  /** WebPubSub service using Socket.IO protocol */
  SocketIO: "SocketIO",
}

/**
 * Represents the identity type: systemAssigned, userAssigned, None
 */
union ManagedIdentityType {
  string,

  /** No managed identity is assigned */
  None: "None",

  /** System assigned managed identity is enabled */
  SystemAssigned: "SystemAssigned",

  /** User assigned managed identity is enabled */
  UserAssigned: "UserAssigned",
}

/**
 * Upstream auth type enum.
 */
union UpstreamAuthType {
  string,

  /** No authentication is used */
  None: "None",

  /** Managed identity is used for authentication */
  ManagedIdentity: "ManagedIdentity",
}

/**
 * Discriminator for event listener filters
 */
union EventListenerFilterDiscriminator {
  string,

  /** Filter by event name */
  EventName: "EventName",
}

/**
 * Discriminator for event listener endpoints
 */
union EventListenerEndpointDiscriminator {
  string,

  /** Event Hub endpoint */
  EventHub: "EventHub",
}

/**
 * The type of access key.
 */
union KeyType {
  string,

  /** Primary access key */
  Primary: "Primary",

  /** Secondary access key */
  Secondary: "Secondary",

  /** Salt key for authentication */
  Salt: "Salt",
}

/**
 * The scale type applicable to the sku.
 */
union ScaleType {
  string,

  /** No scaling */
  None: "None",

  /** Manual scaling controlled by user */
  Manual: "Manual",

  /** Automatic scaling based on load */
  Automatic: "Automatic",
}

/**
 * REST API operation
 */
@discriminator("name")
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name: string;

  /**
   * The display object.
   */
  display?: OperationDisplay;

  /**
   * Properties of the operation
   */
  properties?: OperationProperties;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Is the operation asynchronous
   */
  isDataAction?: boolean;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft.SignalRService
   */
  provider?: string;

  /**
   * Resource on which the operation is performed: SignalR, etc.
   */
  resource?: string;

  /**
   * Operation type: read, write, delete, etc.
   */
  operation?: string;

  /**
   * Description of the operation.
   */
  description?: string;
}

/**
 * Properties of the operation
 */
model OperationProperties {
  /**
   * Service specification of the operation
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * A list of REST API operations supported by an Azure Resource Provider. It contains an URL link to get the next set of results.
 */
model OperationList {
  /**
   * List of operations supported by the resource provider
   */
  value: Operation[];

  /**
   * URL to get the next set of operation list results (if there are any).
   */
  @nextLink
  nextLink?: string;
}

/**
 * Dimension of a metric
 */
model Dimension {
  /**
   * Name of the dimension
   */
  name?: string;

  /**
   * Display name of the dimension
   */
  displayName?: string;

  /**
   * Description of the dimension
   */
  internal?: boolean;
}

/**
 * Log specification of operation
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Display name of the log
   */
  displayName?: string;

  /**
   * Blob duration of the log
   */
  blobDuration?: string;
}

/**
 * Specifications of the Metrics for Azure Monitoring
 */
model MetricSpecification {
  /**
   * Name of the metric
   */
  name?: string;

  /**
   * Display name of the metric
   */
  displayName?: string;

  /**
   * Display description of the metric
   */
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric
   */
  unit?: string;

  /**
   * Name of the aggregation type. The names of the metrics themselves still need to be passed to the API.
   */
  aggregationType?: string;

  /**
   * List of dimensions of the metrics
   */
  dimensions?: Dimension[];

  /**
   * List of time grain types supported for the metric
   */
  supportedTimeGrainTypes?: string[];

  /**
   * List of time grain names supported for the metric
   */
  supportedAggregationTypes?: string[];

  /**
   * The connection string for metrics of a specific resource
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * The connection string for metrics of a specific resource
   */
  sourceMdmAccount?: string;

  /**
   * The connection string for metrics of a specific resource
   */
  sourceMdmNamespace?: string;

  /**
   * The resource IDs with which the current resource shares the metrics
   */
  metricFilterPattern?: string;

  /**
   * Indicates whether or not the metric supports the feature to filter by resource.
   */
  fillGapWithZero?: boolean;

  /**
   * Indicates whether or not the resource supports alerting.
   */
  internalMetricName?: string;
}

/**
 * Service specification of operation
 */
model ServiceSpecification {
  /**
   * Log specifications of operation
   */
  logSpecifications?: LogSpecification[];

  /**
   * Metric specifications of operation
   */
  metricSpecifications?: MetricSpecification[];
}

/**
 * Data POST-ed to the nameAvailability action
 */
model NameAvailabilityParameters {
  /**
   * The resource type. Can be "Microsoft.SignalRService/SignalR", "Microsoft.SignalRService/WebPubSub", "Microsoft.SignalRService/SignalR/replicas" or "Microsoft.SignalRService/WebPubSub/replicas"
   */
  type: string;

  /**
   * The resource name to validate. e.g."my-resource-name"
   */
  name: string;
}

/**
 * Result of the request to check name availability. It contains a flag and possible reason of failure.
 */
model NameAvailability {
  /**
   * Indicates whether the name is available or not.
   */
  nameAvailable?: boolean;

  /**
   * The reason of the availability. Required if name is not available.
   */
  reason?: string;

  /**
   * The message of the operation.
   */
  message?: string;
}

/**
 * Object that includes an array of the resource usages and a possible link for next set.
 */
model SignalRServiceUsageList is Azure.Core.Page<SignalRServiceUsage>;

/**
 * Object that describes a specific usage of the resources.
 */
model SignalRServiceUsage {
  /**
   * Fully qualified ARM resource id
   */
  id?: string;

  /**
   * Current value for the usage quota.
   */
  currentValue?: int64;

  /**
   * The maximum permitted value for the usage quota. If there is no limit, this value will be -1.
   */
  limit?: int64;

  /**
   * Localizable String object containing the name and a localized value.
   */
  name?: SignalRServiceUsageName;

  /**
   * Representing the units of the usage quota. Possible values are: Count, Bytes, Seconds, Percent, CountPerSecond, BytesPerSecond.
   */
  unit?: string;
}

/**
 * Localizable String object containing the name and a localized value.
 */
model SignalRServiceUsageName {
  /**
   * The identifier of the usage.
   */
  value?: string;

  /**
   * Localized name of the usage.
   */
  localizedValue?: string;
}

/**
 * Object that includes an array of resources and a possible link for next set.
 */
model WebPubSubResourceList is Azure.Core.Page<WebPubSubResource>;

/**
 * The billing information of the resource.
 */
model ResourceSku {
  /**
   * The name of the SKU. Required.
   *
   * Allowed values: Standard_S1, Free_F1, Premium_P1, Premium_P2
   */
  name: string;

  /**
   * Optional tier of this particular SKU. 'Standard' or 'Free'.
   *
   * `Basic` is deprecated, use `Standard` instead.
   */
  tier?: WebPubSubSkuTier;

  /**
   * Not used. Retained for future use.
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * Not used. Retained for future use.
   */
  @visibility(Lifecycle.Read)
  family?: string;

  /**
   * Optional, integer. The unit count of the resource.
   * 1 for Free_F1/Standard_S1/Premium_P1, 100 for Premium_P2 by default.
   *
   * If present, following values are allowed:
   *     Free_F1: 1;
   *     Standard_S1: 1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100;
   *     Premium_P1:  1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100;
   *     Premium_P2:  100,200,300,400,500,600,700,800,900,1000;
   */
  capacity?: int32;
}

/**
 * A class that describes the properties of the resource
 */
model WebPubSubProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The publicly accessible IP of the resource.
   */
  @visibility(Lifecycle.Read)
  @clientName("externalIP", "csharp")
  externalIp?: string;

  /**
   * FQDN of the service instance.
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * The publicly accessible port of the resource which is designed for browser/client side usage.
   */
  @visibility(Lifecycle.Read)
  publicPort?: int32;

  /**
   * The publicly accessible port of the resource which is designed for customer server side usage.
   */
  @visibility(Lifecycle.Read)
  serverPort?: int32;

  /**
   * Version of the resource. Probably you need the same or higher version of client SDKs.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Private endpoint connections to the resource.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The list of shared private link resources.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];

  /**
   * TLS settings for the resource
   */
  tls?: WebPubSubTlsSettings;

  /**
   * Deprecated.
   */
  @visibility(Lifecycle.Read)
  hostNamePrefix?: string;

  /**
   * Live trace configuration of a Microsoft.SignalRService resource.
   */
  liveTraceConfiguration?: LiveTraceConfiguration;

  /**
   * Resource log configuration of a Microsoft.SignalRService resource.
   */
  resourceLogConfiguration?: ResourceLogConfiguration;

  /**
   * Network ACLs for the resource
   */
  @clientName("networkACLs", "csharp")
  networkAcls?: WebPubSubNetworkAcls;

  /**
   * Application firewall settings for the resource
   */
  applicationFirewall?: ApplicationFirewallSettings;

  /**
   * Enable or disable public network access. Default to "Enabled".
   * When it's Enabled, network ACLs still apply.
   * When it's Disabled, public network access is always disabled no matter what you set in network ACLs.
   */
  publicNetworkAccess?: string = "Enabled";

  /**
   * DisableLocalAuth
   * Enable or disable local auth with AccessKey
   * When set as true, connection with AccessKey=xxx won't work.
   */
  disableLocalAuth?: boolean = false;

  /**
   * DisableLocalAuth
   * Enable or disable aad auth
   * When set as true, connection with AuthType=aad won't work.
   */
  disableAadAuth?: boolean = false;

  /**
   * Enable or disable the regional endpoint. Default to "Enabled".
   * When it's Disabled, new connections will not be routed to this endpoint, however existing connections will not be affected.
   * This property is replica specific. Disable the regional endpoint without replica is not allowed.
   */
  regionEndpointEnabled?: string = "Enabled";

  /**
   * Stop or start the resource.  Default to "False".
   * When it's true, the data plane of the resource is shutdown.
   * When it's false, the data plane of the resource is started.
   */
  resourceStopped?: string = "false";

  /**
   * SocketIO settings for the resource
   */
  @clientName("socketIO", "csharp")
  socketIo?: WebPubSubSocketIoSettings;
}

/**
 * Private endpoint connection properties
 */
model PrivateEndpointConnectionProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Private endpoint
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Group IDs
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  groupIds?: string[];

  /**
   * Connection state of the private endpoint connection
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/**
 * Private endpoint
 */
model PrivateEndpoint {
  /**
   * Full qualified Id of the private endpoint
   */
  id?: string;
}

/**
 * Connection state of the private endpoint connection
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateLinkServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Describes the properties of an existing Shared Private Link Resource
 */
model SharedPrivateLinkResourceProperties {
  /**
   * The group id from the provider of resource the shared private link resource is for
   */
  groupId: string;

  /**
   * The resource id of the resource the shared private link resource is for
   */
  privateLinkResourceId: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The request message for requesting approval of the shared private link resource
   */
  requestMessage?: string;

  /**
   * A list of FQDNs for third party private link service
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  fqdns?: string[];

  /**
   * Status of the shared private link resource
   */
  @visibility(Lifecycle.Read)
  status?: SharedPrivateLinkResourceStatus;
}

/**
 * TLS settings for the resource
 */
model WebPubSubTlsSettings {
  /**
   * Request client certificate during TLS handshake if enabled. Not supported for free tier. Any input will be ignored for free tier.
   */
  clientCertEnabled?: boolean = false;
}

/**
 * Live trace configuration of a Microsoft.SignalRService resource.
 */
model LiveTraceConfiguration {
  /**
   * Indicates whether or not enable live trace.
   * When it's set to true, live trace client can connect to the service.
   * Otherwise, live trace client can't connect to the service, so that you are unable to receive any log, no matter what you configure in "categories".
   * Available values: true, false.
   * Case insensitive.
   */
  enabled?: string = "false";

  /**
   * Gets or sets the list of category configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  categories?: LiveTraceCategory[];
}

/**
 * Live trace category configuration of a Microsoft.SignalRService resource.
 */
model LiveTraceCategory {
  /**
   * Gets or sets the live trace category's name.
   * Available values: ConnectivityLogs, MessagingLogs.
   * Case insensitive.
   */
  name?: string;

  /**
   * Indicates whether or the live trace category is enabled.
   * Available values: true, false.
   * Case insensitive.
   */
  enabled?: string;
}

/**
 * Resource log configuration of a Microsoft.SignalRService resource.
 */
model ResourceLogConfiguration {
  /**
   * Gets or sets the list of category configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  categories?: ResourceLogCategory[];
}

/**
 * Resource log category configuration of a Microsoft.SignalRService resource.
 */
model ResourceLogCategory {
  /**
   * Gets or sets the resource log category's name.
   * Available values: ConnectivityLogs, MessagingLogs.
   * Case insensitive.
   */
  name?: string;

  /**
   * Indicates whether or the resource log category is enabled.
   * Available values: true, false.
   * Case insensitive.
   */
  enabled?: string;
}

/**
 * Network ACLs for the resource
 */
/**
 * Network access control settings for Azure Web PubSub
 */
@clientName("WebPubSubNetworkACLs", "csharp")
model WebPubSubNetworkAcls {
  /**
   * Azure Networking ACL Action.
   */
  defaultAction?: ACLAction;

  /**
   * Network ACL
   */
  publicNetwork?: NetworkAcl;

  /**
   * ACLs for requests from private endpoints
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  privateEndpoints?: PrivateEndpointAcl[];

  /**
   * IP rules for filtering public traffic
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipRules?: IPRule[];
}

/**
 * Network ACL
 */
/**
 * Network access control list for request types
 */
@clientName("NetworkACL", "csharp")
model NetworkAcl {
  /**
   * Allowed request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  allow?: WebPubSubRequestType[];

  /**
   * Denied request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  deny?: WebPubSubRequestType[];
}

/**
 * ACL for a private endpoint
 */
/**
 * Network access control list for a private endpoint
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@clientName("PrivateEndpointACL", "csharp")
model PrivateEndpointAcl extends NetworkAcl {
  /**
   * Name of the private endpoint connection
   */
  name: string;
}

/**
 * An IP rule
 */
model IPRule {
  /**
   * An IP or CIDR or ServiceTag
   */
  value?: string;

  /**
   * Azure Networking ACL Action.
   */
  action?: ACLAction;
}

/**
 * Application firewall settings for the resource
 */
model ApplicationFirewallSettings {
  /**
   * Rules to control the client connection count
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  clientConnectionCountRules?: ClientConnectionCountRule[];

  /**
   * Rules to control the client traffic
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  clientTrafficControlRules?: ClientTrafficControlRule[];
}

/**
 * A base class for client connection count rules
 */
@discriminator("type")
model ClientConnectionCountRule {
  type: ClientConnectionCountRuleDiscriminator;
}

/**
 * A base class for client traffic control rules
 */
@discriminator("type")
model ClientTrafficControlRule {
  type: ClientTrafficControlRuleDiscriminator;
}

/**
 * SocketIO settings for the resource
 */
/**
 * Settings for Socket.IO protocol support
 */
@clientName("WebPubSubSocketIOSettings", "csharp")
model WebPubSubSocketIoSettings {
  /**
   * The service mode of Web PubSub for Socket.IO. Values allowed:
   * "Default": have your own backend Socket.IO server
   * "Serverless": your application doesn't have a backend server
   */
  serviceMode?: string;
}

/**
 * A class represent managed identities used for request and response
 */
model ManagedIdentity {
  /**
   * Represents the identity type: systemAssigned, userAssigned, None
   */
  type?: ManagedIdentityType;

  /**
   * Get or set the user assigned identities. This should be a dictionary mapping
   * ARM resource IDs to user assigned identity properties.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  userAssignedIdentities?: Record<UserAssignedIdentityProperty>;

  /**
   * Get the principal id for the system assigned identity.
   * Only be used in response.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Get the tenant id for the system assigned identity.
   * Only be used in response
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * Properties of user assigned identity.
 */
model UserAssignedIdentityProperty {
  /**
   * Get the principal id for the user assigned identity
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Get the client id for the user assigned identity
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * A dictionary of user assigned identities
 */
@doc("A dictionary of user assigned managed identities")
model UserAssignedIdentityMap {
  /**
   * The dictionary keys are ARM resource IDs in the form:
   * /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}
   */
  properties?: Record<UserAssignedIdentityProperty>;
}

/**
 * Custom certificates list.
 */
model CustomCertificateList is Azure.Core.Page<CustomCertificate>;

/**
 * Custom certificate properties.
 */
model CustomCertificateProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Base uri of the KeyVault that stores certificate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyVaultBaseUri: string;

  /**
   * Certificate secret name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyVaultSecretName: string;

  /**
   * Certificate secret version.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyVaultSecretVersion?: string;
}

/**
 * Custom domains list
 */
model CustomDomainList is Azure.Core.Page<CustomDomain>;

/**
 * Properties of a custom domain.
 */
model CustomDomainProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The custom domain name.
   */
  domainName: string;

  /**
   * Reference to a resource.
   */
  customCertificate: ResourceReference;
}

/**
 * Reference to a resource.
 */
model ResourceReference {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Hub setting list
 */
model WebPubSubHubList is Azure.Core.Page<WebPubSubHub>;

/**
 * Properties of a hub.
 */
model WebPubSubHubProperties {
  /**
   * Provisioning state of the hub.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Event handler of a hub.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  eventHandlers?: EventHandler[];

  /**
   * Event listener settings for forwarding your client events to listeners.
   * Event listener is transparent to Web PubSub clients, and it doesn't return any result to clients nor interrupt the lifetime of clients.
   * One event can be sent to multiple listeners, as long as it matches the filters in those listeners. The order of the array elements doesn't matter.
   * Maximum count of event listeners among all hubs is 10.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  eventListeners?: EventListener[];

  /**
   * The settings for configuring if anonymous connections are allowed for this hub: "allow" or "deny". Default to "deny".
   */
  anonymousConnectPolicy?: string = "deny";

  /**
   * The settings for configuring the WebSocket ping-pong interval in seconds for all clients in the hub. Valid range: 1 to 120. Default to 20 seconds.
   */
  @maxValue(120)
  @minValue(1)
  webSocketKeepAliveIntervalInSeconds?: int32 = 20;
}

/**
 * Properties of event handler.
 */
model EventHandler {
  @doc("""
    Gets or sets the URL template for the event handler. The actual URL is calculated when the corresponding event is triggered. 
    The template supports predefined parameters syntax: `{event}`, `{hub}`, and KeyVault reference syntax `{@Microsoft.KeyVault(SecretUri=_your_secret_identifier_)}` 
    For example, if the template is `http://example.com/api/{event}`, when `connect` event is triggered, a POST request will be sent to the URL `http://example.com/chat/api/connect`.
    Note: Parameters are not allowed in the hostname of the URL, and curly brackets `{}` are reserved for parameter syntax only. If your URL path contains literal curly brackets, please URL-encode them to ensure proper handling.
    """)
  urlTemplate: string;

  /**
   * Gets or sets the matching pattern for event names.
   * There are 3 kinds of patterns supported:
   *     1. "*", it matches any event name
   *     2. Combine multiple events with ",", for example "event1,event2", it matches event "event1" and "event2"
   *     3. A single event name, for example, "event1", it matches "event1"
   */
  userEventPattern?: string;

  /**
   * Gets or sets the list of system events.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  systemEvents?: string[];

  /**
   * Upstream auth settings. If not set, no auth is used for upstream messages.
   */
  auth?: UpstreamAuthSettings;
}

/**
 * Upstream auth settings. If not set, no auth is used for upstream messages.
 */
model UpstreamAuthSettings {
  /**
   * Upstream auth type enum.
   */
  type?: UpstreamAuthType;

  /**
   * Managed identity settings for upstream.
   */
  managedIdentity?: ManagedIdentitySettings;
}

/**
 * Managed identity settings for upstream.
 */
model ManagedIdentitySettings {
  /**
   * The Resource indicating the App ID URI of the target resource.
   * It also appears in the aud (audience) claim of the issued token.
   */
  resource?: string;
}

/**
 * A setting defines which kinds of events should be sent to which endpoint.
 */
model EventListener {
  /**
   * A base class for event filter which determines whether an event should be sent to an event listener.
   */
  filter: EventListenerFilter;

  /**
   * An endpoint specifying where Web PubSub should send events to.
   */
  endpoint: EventListenerEndpoint;
}

/**
 * A base class for event filter which determines whether an event should be sent to an event listener.
 */
@discriminator("type")
model EventListenerFilter {
  type: EventListenerFilterDiscriminator;
}

/**
 * An endpoint specifying where Web PubSub should send events to.
 */
@discriminator("type")
model EventListenerEndpoint {
  type: EventListenerEndpointDiscriminator;
}

/**
 * A class represents the access keys of the resource.
 */
model WebPubSubKeys {
  /**
   * The primary access key.
   */
  @secret
  primaryKey?: string;

  /**
   * The secondary access key.
   */
  @secret
  secondaryKey?: string;

  /**
   * Connection string constructed via the primaryKey
   */
  @secret
  primaryConnectionString?: string;

  /**
   * Connection string constructed via the secondaryKey
   */
  @secret
  secondaryConnectionString?: string;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionList
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * Contains a list of PrivateLinkResource and a possible link to query more results
 */
model PrivateLinkResourceList is Azure.Core.Page<PrivateLinkResource>;

/**
 * Private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Private link resource properties
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Private link resource properties
 */
model PrivateLinkResourceProperties {
  /**
   * Group Id of the private link resource
   */
  groupId?: string;

  /**
   * Required members of the private link resource
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  requiredMembers?: string[];

  /**
   * Required private DNS zone names
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  requiredZoneNames?: string[];

  /**
   * The list of resources that are onboarded to private link service
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  shareablePrivateLinkResourceTypes?: ShareablePrivateLinkResourceType[];
}

/**
 * Describes a  resource type that has been onboarded to private link service
 */
model ShareablePrivateLinkResourceType {
  /**
   * The name of the resource type that has been onboarded to private link service
   */
  name?: string;

  /**
   * Describes the properties of a resource type that has been onboarded to private link service
   */
  properties?: ShareablePrivateLinkResourceProperties;
}

/**
 * Describes the properties of a resource type that has been onboarded to private link service
 */
model ShareablePrivateLinkResourceProperties {
  /**
   * The description of the resource type that has been onboarded to private link service
   */
  description?: string;

  /**
   * The resource provider group id for the resource that has been onboarded to private link service
   */
  groupId?: string;

  /**
   * The resource provider type for the resource that has been onboarded to private link service
   */
  type?: string;
}

/**
 * Parameters describes the request to regenerate access keys
 */
model RegenerateKeyParameters {
  /**
   * The type of access key.
   */
  keyType?: KeyType;
}

model ReplicaList is Azure.Core.Page<Replica>;

/**
 * Properties of a WebPubSub replica resource.
 */
model ReplicaProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Enable or disable the regional endpoint. Default to "Enabled".
   * When it's Disabled, new connections will not be routed to this endpoint, however existing connections will not be affected.
   */
  regionEndpointEnabled?: string = "Enabled";

  /**
   * Stop or start the resource.  Default to "false".
   * When it's true, the data plane of the resource is shutdown.
   * When it's false, the data plane of the resource is started.
   */
  resourceStopped?: string = "false";
}

/**
 * A list of shared private link resources
 */
model SharedPrivateLinkResourceList
  is Azure.Core.Page<SharedPrivateLinkResource>;

/**
 * The list skus operation response
 */
model SkuList {
  /**
   * The list of skus available for the resource.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["resourceType", "/sku/name", "/sku/tier"]
  )
  value?: Sku[];

  /**
   * The URL the client should use to fetch the next page (per server side paging).
   * It's null for now, added for future use.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Describes an available sku."
 */
model Sku {
  /**
   * The resource type that this object applies to
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The billing information of the resource.
   */
  @visibility(Lifecycle.Read)
  sku?: ResourceSku;

  /**
   * Describes scaling information of a sku.
   */
  @visibility(Lifecycle.Read)
  capacity?: SkuCapacity;
}

/**
 * Describes scaling information of a sku.
 */
model SkuCapacity {
  /**
   * The lowest permitted capacity for this resource
   */
  @visibility(Lifecycle.Read)
  minimum?: int32;

  /**
   * The highest permitted capacity for this resource
   */
  @visibility(Lifecycle.Read)
  maximum?: int32;

  /**
   * The default capacity.
   */
  @visibility(Lifecycle.Read)
  default?: int32;

  /**
   * Allows capacity value list.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  allowedValues?: int32[];

  /**
   * The scale type applicable to the sku.
   */
  @visibility(Lifecycle.Read)
  scaleType?: ScaleType;
}

/**
 * An Event Hub endpoint.
 * The managed identity of Web PubSub service must be enabled, and the identity should have the "Azure Event Hubs Data sender" role to access Event Hub.
 */
model EventHubEndpoint extends EventListenerEndpoint {
  /**
   * The fully qualified namespace name of the Event Hub resource.
   */
  fullyQualifiedNamespace: string;

  /**
   * The name of the Event Hub.
   */
  eventHubName: string;

  type: "EventHub";
}

/**
 * Filter events by their name.
 */
model EventNameFilter extends EventListenerFilter {
  /**
   * Gets or sets a list of system events. Supported events: "connected" and "disconnected". Blocking event "connect" is not supported because it requires a response.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  systemEvents?: string[];

  /**
   * Gets or sets a matching pattern for event names.
   * There are 3 kinds of patterns supported:
   *     1. "*", it matches any event name
   *     2. Combine multiple events with ",", for example "event1,event2", it matches events "event1" and "event2"
   *     3. A single event name, for example, "event1", it matches "event1"
   */
  userEventPattern?: string;

  type: "EventName";
}

/**
 * Throttle the client connection by a custom JWT claim
 */
model ThrottleByJwtCustomClaimRule extends ClientConnectionCountRule {
  /**
   * The name of the claim in the JWT token. The client connection with the same claim value will be aggregated. If the claim is not found in the token, the connection will be allowed.
   */
  claimName: string;

  /**
   * Maximum connection count allowed for the same Jwt claim value. Clients with the same Jwt claim will get rejected if the connection count exceeds this value. Default value is 20.
   */
  @maxValue(2147483647)
  @minValue(0)
  maxCount?: int32 = 20;

  type: "ThrottleByJwtCustomClaimRule";
}

/**
 * Throttle the client connection by the JWT signature
 */
model ThrottleByJwtSignatureRule extends ClientConnectionCountRule {
  /**
   * Maximum connection count allowed for the same JWT signature. Clients with the same JWT signature will get rejected if the connection count exceeds this value. Default value is 20.
   */
  @maxValue(2147483647)
  @minValue(0)
  maxCount?: int32 = 20;

  type: "ThrottleByJwtSignatureRule";
}

/**
 * Throttle the client connection by the user ID
 */
model ThrottleByUserIdRule extends ClientConnectionCountRule {
  /**
   * Maximum connection count allowed for the same user ID. Clients with the same user ID will get rejected if the connection count exceeds this value. Default value is 20.
   */
  @maxValue(2147483647)
  @minValue(0)
  maxCount?: int32 = 20;

  type: "ThrottleByUserIdRule";
}

/**
 * Throttle the client traffic by a custom JWT claim
 */
model TrafficThrottleByJwtCustomClaimRule extends ClientTrafficControlRule {
  /**
   * The name of the claim in the JWT token. The message bytes with the same claim value will be aggregated. If the claim is not found in the token, the rule will be skipped.
   */
  claimName: string;

  /**
   * Maximum accumulated inbound message bytes allowed for the same JWT signature within a time window. Clients with the same JWT claim will get disconnected if the message bytes exceeds this value. Default value is 1GB.
   */
  @minValue(0)
  maxInboundMessageBytes?: int64;

  /**
   * The aggregation window for the message bytes. The message bytes will be aggregated in this window and be reset after the window. Default value is 60 seconds.
   */
  @maxValue(3600)
  @minValue(10)
  aggregationWindowInSeconds?: int32 = 60;

  type: "TrafficThrottleByJwtCustomClaimRule";
}

/**
 * Throttle the client traffic by the JWT signature
 */
model TrafficThrottleByJwtSignatureRule extends ClientTrafficControlRule {
  /**
   * Maximum accumulated inbound message bytes allowed for the same JWT signature within a time window. Clients with the same JWT signature will get disconnected if the message bytes exceeds this value. Default value is 1GB.
   */
  @minValue(0)
  maxInboundMessageBytes?: int64;

  /**
   * The aggregation window for the message bytes. The message bytes will be aggregated in this window and be reset after the window. Default value is 60 seconds.
   */
  @maxValue(3600)
  @minValue(10)
  aggregationWindowInSeconds?: int32 = 60;

  type: "TrafficThrottleByJwtSignatureRule";
}

/**
 * Throttle the client traffic by the user ID
 */
model TrafficThrottleByUserIdRule extends ClientTrafficControlRule {
  /**
   * Maximum accumulated inbound message bytes allowed for the same user ID within a time window. Clients with the same user ID will get disconnected if the message bytes exceeds this value. Default value is 1GB.
   */
  @minValue(0)
  maxInboundMessageBytes?: int64;

  /**
   * The aggregation window for the message bytes. The message bytes will be aggregated in this window and be reset after the window. Default value is 60 seconds.
   */
  @maxValue(3600)
  @minValue(10)
  aggregationWindowInSeconds?: int32 = 60;

  type: "TrafficThrottleByUserIdRule";
}
