import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Rest;

@@clientName(Microsoft.Network,
  "FrontDoorManagementClient",
  "python, javascript"
);
@@clientName(MinimumTLSVersion.`1.0`, "ONE0", "python");
@@clientName(MinimumTLSVersion.`1.2`, "ONE2", "python");
@@clientName(MinimumTLSVersion.`1.0`, "One0", "javascript");
@@clientName(MinimumTLSVersion.`1.2`, "One2", "javascript");

@@clientName(MinimumTLSVersion, "MinimumTlsVersion", "java");
@@clientName(ValidateCustomDomainInput.hostName, "hostname", "java");
@@clientName(FrontendEndpointUpdateParameters.hostName, "hostname", "java");
@@clientName(FrontendEndpointProperties.hostName, "hostname", "java");
@@clientName(LatencyMetric.endDateTimeUTC, "endDateTimeUtc", "java");
@@clientName(LatencyScorecardProperties.startDateTimeUTC,
  "startDateTimeUtc",
  "java"
);
@@clientName(LatencyScorecardProperties.endDateTimeUTC,
  "endDateTimeUtc",
  "java"
);
@@clientName(TimeseriesProperties.startDateTimeUTC, "startDateTimeUtc", "java");
@@clientName(TimeseriesProperties.endDateTimeUTC, "endDateTimeUtc", "java");
@@clientName(TimeseriesDataPoint.dateTimeUTC, "dateTimeUtc", "java");

@@clientName(GetLatencyScorecardsParameters.endDateTimeUTC,
  "endDateTimeUtc",
  "java"
);
@@clientName(GetTimeseriesParameters.startDateTimeUTC,
  "startDateTimeUtc",
  "java"
);
@@clientName(GetTimeseriesParameters.endDateTimeUTC, "endDateTimeUtc", "java");

@@clientName(MinimumTLSVersion.`1.0`, "One0", "go");
@@clientName(MinimumTLSVersion.`1.2`, "One2", "go");

#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op replaceCreateOrUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  profileName: string,
  ...ResourceGroupParameter,
  provider: "Microsoft.Network",
  parameters: ProfileUpdateModel,
  resource: Microsoft.Network.Profile,
): ArmResourceCreateOrReplaceAsync<
  Microsoft.Network.Profile,
  Response = ArmResourceUpdatedResponse<Microsoft.Network.Profile> |
    ArmResourceCreatedResponse<
      Microsoft.Network.Profile,
      ArmLroLocationHeader<FinalResult = Microsoft.Network.Profile> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Microsoft.Network.Profile;
    }),
  Error = Microsoft.Network.ErrorResponse
>;

@@override(Profiles.createOrUpdate, replaceCreateOrUpdate, "go");
