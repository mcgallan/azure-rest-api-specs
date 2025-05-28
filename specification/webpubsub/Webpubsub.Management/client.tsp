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

// 为生成合适的客户端代码，需要平铺这些资源的属性
@@flattenProperty(Microsoft.SignalRService.CustomCertificate.properties);
@@flattenProperty(Microsoft.SignalRService.CustomDomain.properties);
@@flattenProperty(Microsoft.SignalRService.PrivateEndpointConnection.properties
);
@@flattenProperty(Microsoft.SignalRService.PrivateLinkResource.properties);
@@flattenProperty(Microsoft.SignalRService.Replica.properties);
@@flattenProperty(Microsoft.SignalRService.SharedPrivateLinkResource.properties
);
@@flattenProperty(Microsoft.SignalRService.WebPubSubResource.properties);

// 添加 @minValue 和 @secret 装饰器
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
