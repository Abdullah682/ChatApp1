# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY chatting/*.csproj ./  # 👈 Ye change kara hai
RUN dotnet restore

COPY chatting/. ./         # 👈 Saari chatting folder ki files copy karo
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "ChatClone.dll"]
