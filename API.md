# API Reference

## About

This API is organized around REST. This API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. JSON(or nothing in case of 204) is returned by all API responses, including errors.

### Errors

API uses HTTP response codes to indicate the success or failure of an API request. In general, codes 200 and 204 indicate success, codes in the 4xx range indicate an error that failed given the information provided, and 500 code indicates an internal error.

### HTTP status code summary

 - 200 - OK. Everything worked as expected and there is some response.
 - 204 - OK. Everything worked as expected and there is an empty response.
 - 401 - Unauthorized. No valid token provided.
 - 403 - Forbidden. User has no permissions to run this action.
 - 404 - Not Found. The requested path or resource doesn't exist.
 - 500 - Server Error. Something went wrong on API's end. (These are rare.)

## User

### Register

Registers new user.

`` POST /api/v1/user/register ``

Parameters:

 - email
 - password (at least 6 characters)

Possible responses:

 - 200
 - 422

Response example:

```
{
  id: 1
}
```

### Login

Checks presented email and password and returns a token if they are right.

`` POST api.thatsaboy.com/v1/user/login ``

Parameters:

 - email
 - password (at least 6 characters)

Possible responses:

 - 200
 - 422

Response example:

```
{
    token: 'abcdef12345'
}
```

## Hotel

### Hotel index

Shows list of hotels

`` GET /api/v1/hotels ``

Possible responses:

 - 200
 
Response example:

```
[{"id":1, "name":"Hilton"}
{"id":2, "name":"25Hours"}
{"id":3, "name":"The Ritz-Carlton"}
{"id":4, "name":"Marriott"}
{"id":5, "name":"MEININGER"}
{"id":6, "name":"Pullman"}
{"id":7, "name":"AZIMUT"}
{"id":8, "name":"Mövenpick"}
{"id":9, "name":"ibis"}
{"id":10, "name":"Regent"}]

```

### Booking index

Shows list of bookings

`` GET /api/v1/hotels ``

Possible responses:

 - 200
 
Response example:

```
[{"id":1, "date":"2016-09-19", "hotel":{"id":1, "name":"Hilton"}, "user":{"id":1, "email":"toby@yahoo.com"}}
 {"id":2, "date":"2016-09-19", "hotel":{"id":1, "name":"Hilton"}, "user":{"id":2, "email":"zechariah@gmail.com"}}
 {"id":3, "date":"2016-09-19", "hotel":{"id":1, "name":"Hilton"}, "user":{"id":3, "email":"magdalena_reynolds@gmail.com"}}]
```

### Bookings by user

Shows list of user bookings 

`` GET /api/v1/hotels/:user_id ``

Parameters:

 - user_id

Possible responses:

 - 200
 - 404
 
Response example:

```
[{"id":1, "date":"2016-09-19", "hotel":{"id":1, "name":"Hilton"}, "user":{"id":1, "email":"toby@yahoo.com"}}]
```

### Bookings by current user

Shows list of user bookings 

`` GET /api/v1/hotels ``

Parameters:

 - token

Possible responses:

 - 200
 - 401
 
Response example:

```
[{"id":1, "date":"2016-09-19", "hotel":{"id":1, "name":"Hilton"}, "user":{"id":1, "email":"toby@yahoo.com"}}]
```

### Create

Creates a new booking.

`` POST /api/v1/bookings ``

Parameters:

 - token
 - date
 - hotel_id

Possible responses:

 - 200
 - 401
 - 422

Response example:

```
{
  "id":4, 
  "date":"2016-09-19", 
  "hotel":
    {
      "id":1,
      "name":"Hilton"
    },
  "user":
    {
      "id":4,
      "email":"darion.mayer@hotmail.com"
    }
}

```

### Destroy

Removes a booking.

`` DELETE /api/v1/booking/:id ``

Parameters:

 - id
 - token

Possible responses:

 - 204
 - 401
 - 403
 - 404