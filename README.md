# psip

## Endpoints

  * /
    Will return ip address. No other info.

  * /api
    Will return complete $request object.

  * /api/xx
    Will return specific object within $request object. Dig deeper by doing /api/myobject/deeperobject.


## Building

docker build -t **TAG:VERSION** .