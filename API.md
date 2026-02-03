# bsecure API Documentation

Complete API reference for the bsecure HTTP client library.

## Table of Contents

- [Module Functions](#module-functions)
  - [HTTP Methods](#http-methods)
  - [JSON Functions](#json-functions)
- [Classes](#classes)
  - [Session](#session)
  - [Response](#response)
- [Exceptions](#exceptions)
- [Constants](#constants)

---

## Module Functions

### HTTP Methods

#### `bsecure.get(url, **kwargs)`

Send a GET request.

**Parameters:**
- `url` (str): URL for the request
- `**kwargs`: Optional arguments (see [Request Parameters](#request-parameters))

**Returns:** `Response` object

**Example:**
```python
response = bsecure.get('https://api.example.com/users')
response = bsecure.get('https://api.example.com/users', params={'page': 1})
```

---

#### `bsecure.post(url, **kwargs)`

Send a POST request.

**Parameters:**
- `url` (str): URL for the request
- `**kwargs`: Optional arguments (see [Request Parameters](#request-parameters))

**Returns:** `Response` object

**Example:**
```python
# JSON body
response = bsecure.post('https://api.example.com/users', json={'name': 'John'})

# Form data
response = bsecure.post('https://api.example.com/login', data={'user': 'john', 'pass': 'secret'})
```

---

#### `bsecure.put(url, **kwargs)`

Send a PUT request.

**Parameters:**
- `url` (str): URL for the request
- `**kwargs`: Optional arguments (see [Request Parameters](#request-parameters))

**Returns:** `Response` object

**Example:**
```python
response = bsecure.put('https://api.example.com/users/1', json={'name': 'Jane'})
```

---

#### `bsecure.delete(url, **kwargs)`

Send a DELETE request.

**Parameters:**
- `url` (str): URL for the request
- `**kwargs`: Optional arguments (see [Request Parameters](#request-parameters))

**Returns:** `Response` object

**Example:**
```python
response = bsecure.delete('https://api.example.com/users/1')
```

---

#### `bsecure.patch(url, **kwargs)`

Send a PATCH request.

**Parameters:**
- `url` (str): URL for the request
- `**kwargs`: Optional arguments (see [Request Parameters](#request-parameters))

**Returns:** `Response` object

**Example:**
```python
response = bsecure.patch('https://api.example.com/users/1', json={'email': 'new@example.com'})
```

---

#### `bsecure.head(url, **kwargs)`

Send a HEAD request.

**Note:** `allow_redirects` defaults to `False` for HEAD requests.

**Parameters:**
- `url` (str): URL for the request
- `**kwargs`: Optional arguments (see [Request Parameters](#request-parameters))

**Returns:** `Response` object (with empty `content`)

**Example:**
```python
response = bsecure.head('https://example.com/large-file.zip')
print(response.headers.get('Content-Length'))
```

---

#### `bsecure.options(url, **kwargs)`

Send an OPTIONS request.

**Parameters:**
- `url` (str): URL for the request
- `**kwargs`: Optional arguments (see [Request Parameters](#request-parameters))

**Returns:** `Response` object

**Example:**
```python
response = bsecure.options('https://api.example.com/')
print(response.headers.get('Allow'))  # GET, POST, PUT, DELETE
```

---

#### `bsecure.request(method, url, **kwargs)`

Send a request with an explicit method.

**Parameters:**
- `method` (str): HTTP method (GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS)
- `url` (str): URL for the request
- `**kwargs`: Optional arguments (see [Request Parameters](#request-parameters))

**Returns:** `Response` object

**Example:**
```python
response = bsecure.request('GET', 'https://api.example.com/users')
response = bsecure.request('POST', 'https://api.example.com/users', json={'name': 'John'})
```

---

### Request Parameters

All HTTP methods accept these optional keyword arguments:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `params` | dict, list[tuple] | `None` | URL query string parameters |
| `data` | dict, str, bytes | `None` | Request body. Dict is form-encoded |
| `json` | any | `None` | JSON body (sets Content-Type header) |
| `files` | dict | `None` | Files for multipart upload (see [File Uploads](#file-uploads)) |
| `headers` | dict | `None` | HTTP headers to send |
| `cookies` | dict | `None` | Cookies to send with request |
| `auth` | tuple(str, str) | `None` | Basic auth as (username, password) |
| `timeout` | float, tuple | `None` | Timeout in seconds, or (connect, read) |
| `allow_redirects` | bool | `True` | Follow HTTP redirects |
| `proxies` | dict | `None` | Proxy URLs: {'http': '...', 'https': '...'} |
| `verify` | bool, str | `True` | SSL verification. False disables, str is CA path |
| `cert` | str, tuple | `None` | Client cert path, or (cert, key) paths |

---

### File Uploads

The `files` parameter accepts a dict for multipart/form-data uploads:

```python
# Simple file upload (filename, data)
files = {'file': ('report.txt', b'File content here')}

# With content type (filename, data, content_type)
files = {'file': ('data.json', b'{"key": "value"}', 'application/json')}

# Upload from file path
files = {'file': '/path/to/file.pdf'}

# Upload from file object
with open('document.pdf', 'rb') as f:
    files = {'document': f}
    response = bsecure.post(url, files=files)

# Multiple files
files = {
    'file1': ('a.txt', b'content1'),
    'file2': ('b.txt', b'content2')
}

# Files with additional form data
response = bsecure.post(url, 
    data={'name': 'John'},
    files={'avatar': ('photo.jpg', image_data, 'image/jpeg')}
)

---

### JSON Functions

#### `bsecure.loads(s, **kwargs)`

Parse a JSON string into a Python object.

**Parameters:**
- `s` (str, bytes, bytearray): JSON string to parse
- `**kwargs`: Compatibility kwargs (ignored)

**Returns:** Python object (dict, list, str, int, float, bool, or None)

**Raises:** `JSONDecodeError` if the string is not valid JSON

**Example:**
```python
data = bsecure.loads('{"name": "John", "age": 30}')
# {'name': 'John', 'age': 30}

data = bsecure.loads('[1, 2, 3]')
# [1, 2, 3]
```

---

#### `bsecure.dumps(obj, **kwargs)`

Serialize a Python object to a JSON string.

**Parameters:**
- `obj`: Python object to serialize
- `indent` (int, optional): Indentation level for pretty printing
- `**kwargs`: Compatibility kwargs (ignored)

**Returns:** JSON string

**Raises:** `TypeError` if the object is not JSON serializable

**Example:**
```python
json_str = bsecure.dumps({'name': 'John', 'age': 30})
# '{"name":"John","age":30}'

json_str = bsecure.dumps({'name': 'John'}, indent=2)
# '{\n  "name": "John"\n}'
```

---

#### `bsecure.load(fp, **kwargs)`

Parse JSON from a file object.

**Parameters:**
- `fp`: File-like object with a `read()` method
- `**kwargs`: Compatibility kwargs (ignored)

**Returns:** Python object

**Raises:** `JSONDecodeError` if the content is not valid JSON

**Example:**
```python
with open('data.json', 'r') as f:
    data = bsecure.load(f)
```

---

#### `bsecure.dump(obj, fp, **kwargs)`

Serialize a Python object to a JSON file.

**Parameters:**
- `obj`: Python object to serialize
- `fp`: File-like object with a `write()` method
- `indent` (int, optional): Indentation level for pretty printing
- `**kwargs`: Compatibility kwargs (ignored)

**Returns:** None

**Example:**
```python
with open('output.json', 'w') as f:
    bsecure.dump({'name': 'John'}, f, indent=2)
```

---

## Classes

### Session

```python
class bsecure.Session
```

A Session object for making requests with persistent settings and cookies.

#### Constructor

```python
session = bsecure.Session()
```

Creates a new session with default settings.

#### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `headers` | dict | `{}` | Default headers sent with every request |
| `cookies` | dict | `{}` | Cookie jar (automatically updated from responses) |
| `auth` | tuple | `None` | Default basic auth credentials |
| `proxies` | dict | `{}` | Default proxy configuration |
| `verify` | bool | `True` | Default SSL verification setting |
| `cert` | str/tuple | `None` | Default client certificate |
| `max_redirects` | int | `30` | Maximum number of redirects to follow |
| `trust_env` | bool | `True` | Trust environment variables for proxy settings |

#### Methods

##### `session.request(method, url, **kwargs)`

Send a request using the session.

**Parameters:**
- `method` (str): HTTP method
- `url` (str): URL for the request
- `**kwargs`: Request parameters (merged with session defaults)

**Returns:** `Response` object

##### `session.get(url, **kwargs)`

Send a GET request using the session.

##### `session.post(url, **kwargs)`

Send a POST request using the session.

##### `session.put(url, **kwargs)`

Send a PUT request using the session.

##### `session.delete(url, **kwargs)`

Send a DELETE request using the session.

##### `session.patch(url, **kwargs)`

Send a PATCH request using the session.

##### `session.head(url, **kwargs)`

Send a HEAD request using the session.

##### `session.options(url, **kwargs)`

Send an OPTIONS request using the session.

##### `session.close()`

Close the session. Currently a no-op but provided for API compatibility.

#### Context Manager

Session supports the context manager protocol:

```python
with bsecure.Session() as session:
    session.get('https://example.com')
# session.close() is called automatically
```

#### Example

```python
session = bsecure.Session()

# Set default headers
session.headers['User-Agent'] = 'MyApp/1.0'
session.headers['Accept'] = 'application/json'

# Set authentication
session.auth = ('username', 'password')

# Make requests (headers and auth applied automatically)
response = session.get('https://api.example.com/data')

# Cookies persist across requests
session.post('https://example.com/login', data={'user': 'john'})
session.get('https://example.com/dashboard')  # Cookies sent automatically

# Check stored cookies
print(session.cookies)
```

---

### Response

```python
class bsecure.Response
```

The Response object containing the server's response to an HTTP request.

#### Attributes

| Attribute | Type | Description |
|-----------|------|-------------|
| `status_code` | int | HTTP status code (e.g., 200, 404, 500) |
| `text` | str | Response body decoded as string |
| `content` | bytes | Response body as raw bytes |
| `headers` | dict | Response headers |
| `cookies` | dict | Cookies set by the response |
| `url` | str | Final URL (after any redirects) |
| `encoding` | str/None | Encoding from Content-Type header |
| `reason` | str | HTTP reason phrase (e.g., "OK", "Not Found") |
| `ok` | bool | True if status_code < 400 |
| `elapsed` | float | Time elapsed for the request in seconds |
| `history` | list | List of Response objects from redirects |
| `request` | PreparedRequest | Original request that created this response |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `is_redirect` | bool | True if response is a redirect (301, 302, 303, 307, 308 with Location header) |
| `is_permanent_redirect` | bool | True if response is a permanent redirect (301, 308) |
| `apparent_encoding` | str | Best-guess encoding (returns encoding if set, else 'utf-8') |
| `links` | dict | Parsed Link headers as dict keyed by rel value |

#### Methods

##### `response.json()`

Parse the response body as JSON.

**Returns:** Python object

**Raises:** `JSONDecodeError` if the body is not valid JSON

**Example:**
```python
response = bsecure.get('https://api.example.com/users')
users = response.json()
```

##### `response.raise_for_status()`

Raise an `HTTPError` if the response status code indicates an error.

**Raises:** `HTTPError` for 4xx and 5xx status codes

**Example:**
```python
response = bsecure.get('https://api.example.com/users')
response.raise_for_status()  # Raises if status >= 400
```

##### `response.iter_content(chunk_size=1, decode_unicode=False)`

Iterate over response content in chunks.

**Parameters:**
- `chunk_size` (int): Size of each chunk in bytes (default: 1)
- `decode_unicode` (bool): Decode bytes to str (default: False)

**Returns:** Iterator of bytes or str chunks

**Example:**
```python
response = bsecure.get('https://example.com/large-file')
for chunk in response.iter_content(chunk_size=8192):
    process(chunk)
```

##### `response.iter_lines(chunk_size=512, decode_unicode=None, delimiter=None)`

Iterate over response text line by line.

**Parameters:**
- `chunk_size` (int): Internal buffer size (default: 512)
- `decode_unicode`: Unused, for compatibility
- `delimiter` (str): Line delimiter (default: newline)

**Returns:** Iterator of str lines

**Example:**
```python
response = bsecure.get('https://example.com/log')
for line in response.iter_lines():
    print(line)
```

#### Boolean Evaluation

Response objects are truthy if the request was successful (status_code < 400):

```python
response = bsecure.get('https://example.com')
if response:
    print("Request successful")
else:
    print("Request failed")
```

#### String Representation

```python
response = bsecure.get('https://example.com')
print(response)  # <Response [200]>
```

---

## Exceptions

### Exception Hierarchy

```
Exception
└── bsecure.RequestException
    ├── bsecure.HTTPError
    ├── bsecure.ConnectionError
    ├── bsecure.Timeout
    ├── bsecure.TooManyRedirects
    └── bsecure.URLRequired

ValueError
└── bsecure.JSONDecodeError
```

### `bsecure.RequestException`

Base exception for all request errors.

```python
try:
    response = bsecure.get('https://example.com')
except bsecure.RequestException as e:
    print(f"Request failed: {e}")
```

### `bsecure.HTTPError`

Raised when `response.raise_for_status()` is called on a response with status code >= 400.

```python
try:
    response = bsecure.get('https://example.com/notfound')
    response.raise_for_status()
except bsecure.HTTPError as e:
    print(f"HTTP error: {e}")
```

### `bsecure.ConnectionError`

Raised when a connection cannot be established.

```python
try:
    response = bsecure.get('https://nonexistent.example.com')
except bsecure.ConnectionError as e:
    print(f"Connection failed: {e}")
```

### `bsecure.Timeout`

Raised when a request times out.

```python
try:
    response = bsecure.get('https://example.com', timeout=0.001)
except bsecure.Timeout:
    print("Request timed out")
```

### `bsecure.JSONDecodeError`

Raised when JSON parsing fails. Inherits from `ValueError`.

```python
try:
    data = bsecure.loads('invalid json')
except bsecure.JSONDecodeError:
    print("Invalid JSON")
```

### `bsecure.TooManyRedirects`

Raised when max redirects limit exceeded.

```python
try:
    response = bsecure.get('https://example.com/redirect-loop', allow_redirects=True)
except bsecure.TooManyRedirects:
    print("Too many redirects")
```

### `bsecure.URLRequired`

Raised when a valid URL is required but not provided.

```python
try:
    response = bsecure.get(None)
except bsecure.URLRequired:
    print("URL is required")
```

---

## Constants

### `bsecure.__version__`

The version string of the bsecure module.

```python
print(bsecure.__version__)  # '2.1.0'
```

---

## Type Reference

### Supported JSON Types

| Python Type | JSON Type |
|-------------|-----------|
| `dict` | object |
| `list`, `tuple` | array |
| `str` | string |
| `int` | number |
| `float` | number |
| `True` | true |
| `False` | false |
| `None` | null |

### HTTP Status Codes with Reasons

| Code | Reason |
|------|--------|
| 100 | Continue |
| 200 | OK |
| 201 | Created |
| 202 | Accepted |
| 204 | No Content |
| 206 | Partial Content |
| 301 | Moved Permanently |
| 302 | Found |
| 303 | See Other |
| 304 | Not Modified |
| 307 | Temporary Redirect |
| 308 | Permanent Redirect |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 405 | Method Not Allowed |
| 408 | Request Timeout |
| 409 | Conflict |
| 410 | Gone |
| 413 | Payload Too Large |
| 414 | URI Too Long |
| 415 | Unsupported Media Type |
| 422 | Unprocessable Entity |
| 429 | Too Many Requests |
| 500 | Internal Server Error |
| 501 | Not Implemented |
| 502 | Bad Gateway |
| 503 | Service Unavailable |
| 504 | Gateway Timeout |
