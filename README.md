# psip

[![Build Status](https://dev.azure.com/TechnicallyJoe/psip/_apis/build/status/TechnicallyJoe.psip?branchName=master)](https://dev.azure.com/TechnicallyJoe/psip/_build/latest?definitionId=16&branchName=master)

A mostly for fun project, demonstrating using the [Microsoft Polaris](https://github.com/powershell/polaris) project to create a simple web api.

## Disclaimer
This project is only meant as a proof of concept and should not be used in production without a thorough review. This includes disclaimer includes any disclaimer given in the [Microsoft Polaris](https://github.com/powershell/polaris) project.

## Endpoints
The api exposes a few simple endspoints. See below.
  * `/`

    Will return ip address. No other info.

  * `/api`

    Will return complete $request object.

  * `/api/:name`

    Will return specific object within $request object. Dig deeper by doing /api/myobject/deeperobject.

# Getting Started

# Prerequisites

* [Powershell](https://github.com/powershell/powershell)

## Usage

For usage examples, see docker-compose.yml.

## Development

1. Clone the repository
2. Run `docker-compose up -d --build`
3. The site should now run on http://localhost:5000

## Example

The below assumes you've used the docker-compose file to set it up
```Powershell
$uri = <uri>

# This will return your IP address
Invoke-WebRequest -Uri $uri

# This will return everything in the $Request. For more information, either set it up or see the Polaris documentation.
Invoke-WebRequest -Uri "$uri/api"

# You can also get a specific part of the $Request object.
Invoke-WebRequest -Uri "$uri/api/RawRequest"

# Building on the previous example, to dig deeper into an object, you can do:
Invoke-WebRequest -Uri "$uri/api/RawRequest/RawUrl"
```

# Troubleshooting / Questions

* **GitHub Issues:** Submit a bug / new feature idea / or just a question as a new GitHub issue

# RoadMap

* Create basic pester integrationtests.
* Upload to docker hub
* Add .editorconfig & possible .vscode conventions
* Add CICD pipeline
* Set up in an azure functions app

# License

PSIP is licensed under the MIT License.

# Maintainer(s)

* [Jonathan Østrup](https://github.com/TechnicallyJoe)