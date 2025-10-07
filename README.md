# BSecure

A high-performance, security-hardened HTTP library for Python with a requests-like API.

## Features

- **Simple API**: Familiar requests-like interface
- **Fast Performance**: Optimized for speed
- **Security Hardened**: Advanced security features
- **Full HTTP Support**: GET, POST, PUT, DELETE, HEAD, PATCH, OPTIONS
- **Session Management**: Persistent sessions with cookie handling
- **Cookie Management**: Multiple formats (dict, list, string)
- **File Uploads**: Multipart/form-data support
- **Authentication**: Basic auth, Bearer tokens, custom headers
- **Proxy Support**: HTTP/HTTPS proxy configuration
- **Compression**: Automatic gzip, deflate, brotli, and zstd handling
- **JSON Support**: Built-in JSON encoding/decoding

## Installation

Import the module in your Python code:

```python
import bsecure
```

## Quick Start

### Basic Usage

```python
import bsecure

# Simple GET request
response = bsecure.get('https://api.example.com/data')
print(response.text)
print(response.status_code)

# POST with JSON
response = bsecure.post('https://api.example.com/users', 
                        json={'name': 'John', 'age': 30})
print(response.json())

# POST with form data
response = bsecure.post('https://api.example.com/login',
                        data={'username': 'user', 'password': 'pass'})
```

### Session Usage

```python
import bsecure

# Create a session
s = bsecure.Session()

# Set session headers
s.headers = {'User-Agent': 'MyApp/1.0', 'Accept': 'application/json'}

# Set session cookies
s.cookies = {'session_id': 'abc123'}

# Make requests with session
response = s.get('https://api.example.com/data')
print(response.text)
```

## API Reference

### Module Functions

```python
bsecure.get(url, **kwargs)      # Send GET request
bsecure.post(url, **kwargs)     # Send POST request
bsecure.put(url, **kwargs)      # Send PUT request
bsecure.delete(url, **kwargs)   # Send DELETE request
bsecure.head(url, **kwargs)     # Send HEAD request
bsecure.patch(url, **kwargs)    # Send PATCH request
bsecure.options(url, **kwargs)  # Send OPTIONS request
```

### Session Object

```python
session = bsecure.Session()
```

**Properties:**
- `headers` (dict) - Session headers
- `cookies` (Cookies) - Session cookies object
- `auth` (tuple/str/dict) - Authentication credentials
- `proxies` (dict) - Proxy configuration
- `timeout` (float) - Request timeout in seconds
- `verify` (bool) - SSL verification

**Methods:**
- `get(url, **kwargs)` - Send GET request
- `post(url, **kwargs)` - Send POST request
- `put(url, **kwargs)` - Send PUT request
- `delete(url, **kwargs)` - Send DELETE request
- `head(url, **kwargs)` - Send HEAD request
- `patch(url, **kwargs)` - Send PATCH request
- `options(url, **kwargs)` - Send OPTIONS request
- `get_cookies_dict(url)` - Get cookies as dict for URL
- `get_cookies_string(url)` - Get cookies as string for URL
- `set_cookies_dict(url, cookies)` - Set cookies from dict for URL

### Response Object

**Properties:**
- `status_code` (int) - HTTP status code
- `headers` (dict) - Response headers
- `content` (bytes) - Raw response body
- `text` (str) - Decoded response body
- `url` (str) - Final URL
- `cookies` (Cookies) - Response cookies
- `reason` (str) - HTTP status reason
- `elapsed` (float) - Request duration in seconds

**Methods:**
- `raise_for_status()` - Raise exception for 4xx/5xx status codes
- `json()` - Parse response body as JSON

### Cookies Object

**Methods:**
- `get_dict()` - Get cookies as dictionary
- `get_list_dict()` - Get cookies as list of dictionaries
- `get_string()` - Get cookies as semicolon-separated string

## Request Parameters

All request functions accept the following keyword arguments:

| Parameter | Type | Description |
|-----------|------|-------------|
| `url` | str | Target URL (required) |
| `params` | dict | URL query parameters |
| `data` | bytes/str/dict | Request body data |
| `json` | dict/list | JSON request body |
| `files` | dict/list | Files for multipart upload |
| `headers` | dict | Request headers |
| `cookies` | dict/str/list | Request cookies |
| `auth` | tuple/str/dict | Authentication |
| `proxies` | dict | Proxy configuration |
| `timeout` | float | Request timeout in seconds |
| `verify` | bool | SSL verification |

## Examples

### Headers

```python
import bsecure

# Single request with headers
headers = {'User-Agent': 'MyApp/1.0', 'Accept': 'application/json'}
response = bsecure.get('https://api.example.com', headers=headers)

# Session with persistent headers
s = bsecure.Session()
s.headers = {'Authorization': 'Bearer token123'}
response = s.get('https://api.example.com/protected')
```

### Cookies

```python
import bsecure

# Cookies as dictionary
response = bsecure.get('https://example.com', cookies={'session': 'abc123'})

# Cookies as string
response = bsecure.get('https://example.com', cookies='session=abc123; token=xyz')

# Session cookies
s = bsecure.Session()
s.cookies = {'session_id': 'abc123', 'preferences': 'dark_mode'}
response = s.get('https://example.com')

# Get cookies from response
print(response.cookies.get_dict())
print(response.cookies.get_string())
```

### POST Data

```python
import bsecure

# Form data (dictionary)
data = {'username': 'user', 'password': 'pass'}
response = bsecure.post('https://example.com/login', data=data)

# JSON data
json_data = {'name': 'John', 'email': 'john@example.com'}
response = bsecure.post('https://api.example.com/users', json=json_data)

# Raw data
raw_data = b'binary data here'
response = bsecure.post('https://example.com/upload', data=raw_data)
```

### File Uploads

```python
import bsecure

# Upload files (dictionary format)
files = {
    'document': ('report.pdf', open('report.pdf', 'rb').read()),
    'image': ('photo.jpg', open('photo.jpg', 'rb').read())
}
response = bsecure.post('https://example.com/upload', files=files)

# Upload with file path (tuple format)
files = {
    'document': ('report.pdf', '/path/to/report.pdf')
}
response = bsecure.post('https://example.com/upload', files=files)
```

### Authentication

```python
import bsecure

# Basic authentication
auth = ('username', 'password')
response = bsecure.get('https://api.example.com', auth=auth)

# Bearer token
auth = 'Bearer your_token_here'
response = bsecure.get('https://api.example.com', auth=auth)

# Custom auth headers
auth = {'Authorization': 'Custom token', 'X-API-Key': 'key123'}
response = bsecure.get('https://api.example.com', auth=auth)
```

### Proxies

```python
import bsecure

# Proxy configuration
proxies = {
    'http': 'http://proxy.example.com:8080',
    'https': 'http://proxy.example.com:8080'
}
response = bsecure.get('https://example.com', proxies=proxies)

# Session with proxy
s = bsecure.Session()
s.proxies = proxies
response = s.get('https://example.com')
```

### Timeouts

```python
import bsecure

# Request timeout (seconds)
response = bsecure.get('https://example.com', timeout=5.0)

# Session timeout
s = bsecure.Session()
s.timeout = 10.0
response = s.get('https://example.com')
```

### Error Handling

```python
import bsecure

try:
    response = bsecure.get('https://api.example.com/data')
    response.raise_for_status()
    data = response.json()
except Exception as e:
    print(f"Request failed: {e}")
```

### Query Parameters

```python
import bsecure

# URL parameters
params = {'page': 1, 'limit': 10, 'sort': 'date'}
response = bsecure.get('https://api.example.com/items', params=params)
# Requests: https://api.example.com/items?page=1&limit=10&sort=date
```

### JSON Utilities

```python
import bsecure

# Serialize to JSON
obj = {'name': 'John', 'items': [1, 2, 3]}
json_string = bsecure.json_dumps(obj)

# Deserialize from JSON
json_string = '{"name": "John", "age": 30}'
obj = bsecure.json_loads(json_string)
```

## Advanced Cookie Management

```python
import bsecure

s = bsecure.Session()

# Set session-level cookies
s.cookies = {'session_id': 'abc123'}

# Get cookies for specific URL
cookies = s.get_cookies_dict('https://example.com')
print(cookies)

# Get cookies as string
cookie_string = s.get_cookies_string('https://example.com')
print(cookie_string)

# Set cookies for specific URL
s.set_cookies_dict('https://example.com', {'token': 'xyz789'})

# Access detailed cookie information
response = s.get('https://example.com')
print(response.cookies.get_dict())       # Simple dict
print(response.cookies.get_string())     # String format
print(response.cookies.get_list_dict())  # Detailed list with all attributes
```

## Complete Example

```python
import bsecure

# Create session
session = bsecure.Session()

# Configure session
session.headers = {
    'User-Agent': 'MyApp/1.0',
    'Accept': 'application/json'
}
session.timeout = 30.0

# Login
login_data = {'username': 'user', 'password': 'pass'}
response = session.post('https://api.example.com/login', json=login_data)
response.raise_for_status()

# Session cookies are automatically stored
print(f"Logged in: {response.cookies.get_dict()}")

# Make authenticated requests
response = session.get('https://api.example.com/user/profile')
profile = response.json()
print(f"Profile: {profile}")

# Upload file
files = {'avatar': ('profile.jpg', open('profile.jpg', 'rb').read())}
response = session.post('https://api.example.com/user/avatar', files=files)
print(f"Upload status: {response.status_code}")

# Logout
response = session.post('https://api.example.com/logout')
print(f"Logged out: {response.status_code}")
```

## Module Information

- **Author**: Binyamin Binni
- **URL**: https://github.com/binyaminbinni/bsecure

---

For more examples and documentation, visit the project repository.
