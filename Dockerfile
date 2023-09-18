ARG DOTNET_VERSION=6.0

FROM mcr.microsoft.com/dotnet/sdk:${DOTNET_VERSION} as builder

WORKDIR /build
RUN mkdir -p /build/dist

COPY . . 

RUN dotnet restore
RUN dotnet publish -c Release -o ./dist

FROM mcr.microsoft.com/dotnet/aspnet:${DOTNET_VERSION} as runtime

WORKDIR /srv/sampleapi

COPY --from=builder /build/dist .

ENTRYPOINT ["dotnet", "sampleapi.dll"]