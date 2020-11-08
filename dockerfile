FROM mcr.microsoft.com/powershell:7.0.3-alpine-3.10-20201027

ENV PORT 8080

SHELL ["pwsh", "-Command"]

RUN Install-Module -Name Polaris -Force

COPY src src

CMD ["sh", "-c", "pwsh -File src/entrypoint.ps1 -Port ${PORT}"]