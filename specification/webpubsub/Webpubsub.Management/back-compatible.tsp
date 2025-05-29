// 用于存放客户端特定配置的文件
import "@azure-tools/typespec-client-generator-core";
import "./WebPubSubResource.tsp";
import "./CustomCertificate.tsp";
import "./CustomDomain.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Replica.tsp";
import "./SharedPrivateLinkResource.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.SignalRService;

@@flattenProperty(Microsoft.SignalRService.CustomCertificate.properties);
@@flattenProperty(Microsoft.SignalRService.CustomDomain.properties);
@@flattenProperty(Microsoft.SignalRService.PrivateEndpointConnection.properties
);
@@flattenProperty(Microsoft.SignalRService.PrivateLinkResource.properties);
@@flattenProperty(Microsoft.SignalRService.Replica.properties);
@@flattenProperty(Microsoft.SignalRService.SharedPrivateLinkResource.properties
);
@@flattenProperty(Microsoft.SignalRService.WebPubSubResource.properties);

@@minValue(Microsoft.SignalRService.ThrottleByJwtCustomClaimRule.maxCount, 0);
@@minValue(Microsoft.SignalRService.ThrottleByJwtSignatureRule.maxCount, 0);
@@minValue(Microsoft.SignalRService.ThrottleByUserIdRule.maxCount, 0);
@@minValue(Microsoft.SignalRService.TrafficThrottleByJwtCustomClaimRule.maxInboundMessageBytes,
  0
);
@@minValue(Microsoft.SignalRService.TrafficThrottleByJwtSignatureRule.maxInboundMessageBytes,
  0
);
@@minValue(Microsoft.SignalRService.TrafficThrottleByUserIdRule.maxInboundMessageBytes,
  0
);
@@secret(Microsoft.SignalRService.WebPubSubKeys.primaryKey);
@@secret(Microsoft.SignalRService.WebPubSubKeys.secondaryKey);
@@secret(Microsoft.SignalRService.WebPubSubKeys.primaryConnectionString);
@@secret(Microsoft.SignalRService.WebPubSubKeys.secondaryConnectionString);
@@clientName(WebPubSubOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
@@clientName(WebPubSubResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WebPubSubResources.update::parameters.properties, "parameters");
@@clientName(CustomCertificates.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(CustomDomains.createOrUpdate::parameters.resource, "parameters");
@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "parameters"
);
@@clientName(WebPubSubResources.regenerateKey::parameters.body, "parameters");
@@clientName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "parameters"
);
