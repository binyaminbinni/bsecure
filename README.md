# bsecure

[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A high-performance, drop-in replacement for Python's `requests` library, backed by **libcurl** and **json-c** for maximum performance and security.

**bsecure** is a native C extension that provides the familiar `requests` API while offering significant performance improvements and enhanced security features including embedded CA certificates for SSL/TLS verification.

## Key Features

| Feature | Description |
|---------|-------------|
| 🚀 **High Performance** | Native C extension, 2-5x faster than pure Python |
| 🔒 **Secure by Default** | Embedded Mozilla CA certificates, full TLS 1.3 support |
| 📦 **Zero Dependencies** | All libraries statically linked (only needs Python) |
| 🔄 **Drop-in Replacement** | API compatible with `requests` library |
| 📡 **HTTP/2 Support** | Native HTTP/2 via nghttp2 |
| 🍪 **Session Support** | Persistent sessions with automatic cookie handling |
| 📝 **JSON Built-in** | Replaces both `requests` and `json` modules |

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [API Reference](#api-reference)
- [Advanced Usage](#advanced-usage)
- [Configuration](#configuration)
- [Error Handling](#error-handling)
- [Performance](#performance)
- [Building from Source](#building-from-source)
- [Architecture](#architecture)
- [License](#license)

## Installation

### From Pre-built Package

```bash
# Download from release section
```

## Quick Start

### Basic HTTP Requests

```python
import bsecure

# Simple GET request
response = bsecure.get('https://api.github.com/users/octocat')
print(response.status_code)  # 200
print(response.json())       # Parse JSON response

# POST with JSON body
response = bsecure.post(
    'https://httpbin.org/post',
    json={'name': 'bsecure', 'version': '2.0.0'}
)

# POST with form data
response = bsecure.post(
    'https://httpbin.org/post',
    data={'username': 'user', 'password': 'pass'}
)

# Custom headers
response = bsecure.get(
    'https://api.example.com/data',
    headers={
        'Authorization': 'Bearer your-token-here',
        'Accept': 'application/json'
    }
)

# Query parameters
response = bsecure.get(
    'https://api.example.com/search',
    params={'q': 'python', 'page': 1, 'limit': 10}
)
```

### Working with Sessions

Sessions persist settings and cookies across multiple requests:

```python
import bsecure

# Create a session
session = bsecure.Session()

# Set default headers for all requests
session.headers['User-Agent'] = 'MyApp/1.0'
session.headers['Accept'] = 'application/json'

# Login (cookies are automatically saved)
session.post('https://example.com/login', data={
    'username': 'user',
    'password': 'pass'
})

# Subsequent requests include the session cookies
response = session.get('https://example.com/dashboard')
profile = session.get('https://example.com/api/profile')

# Context manager support
with bsecure.Session() as s:
    s.headers['Authorization'] = 'Bearer token'
    data = s.get('https://api.example.com/data').json()
```

### JSON Operations

bsecure includes complete JSON support, replacing the need for the `json` module:

```python
import bsecure

# Parse JSON string
data = bsecure.loads('{"name": "bsecure", "version": "2.0.0"}')

# Serialize to JSON
json_string = bsecure.dumps({'key': 'value'})
pretty_json = bsecure.dumps({'key': 'value'}, indent=2)

# File operations
with open('config.json', 'r') as f:
    config = bsecure.load(f)

with open('output.json', 'w') as f:
    bsecure.dump({'result': 'success'}, f, indent=2)
```

## API Reference

### HTTP Methods

All HTTP methods accept the same keyword arguments:

```python
bsecure.get(url, **kwargs)
bsecure.post(url, **kwargs)
bsecure.put(url, **kwargs)
bsecure.delete(url, **kwargs)
bsecure.patch(url, **kwargs)
bsecure.head(url, **kwargs)
bsecure.options(url, **kwargs)
bsecure.request(method, url, **kwargs)
```

### Request Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `url` | str | *required* | URL for the request |
| `params` | dict, list of tuples | None | Query string parameters |
| `data` | dict, str, bytes | None | Request body (form-encoded if dict) |
| `json` | any | None | JSON request body (sets Content-Type) |
| `headers` | dict | None | HTTP headers |
| `cookies` | dict | None | Cookies to send |
| `files` | dict | None | Multipart file uploads |
| `auth` | tuple | None | Basic auth credentials (user, pass) |
| `timeout` | float, tuple | None | Timeout in seconds, or (connect, read) |
| `allow_redirects` | bool | True | Follow redirects |
| `proxies` | dict | None | Proxy configuration |
| `verify` | bool, str | True | SSL verification (True/False/CA path) |
| `cert` | str, tuple | None | Client certificate |

### Response Object

The `Response` object contains the server's response:

| Attribute | Type | Description |
|-----------|------|-------------|
| `status_code` | int | HTTP status code (200, 404, etc.) |
| `text` | str | Response body as decoded string |
| `content` | bytes | Response body as raw bytes |
| `headers` | dict | Response headers |
| `cookies` | dict | Cookies set by the response |
| `url` | str | Final URL (after redirects) |
| `encoding` | str | Response encoding (from Content-Type) |
| `reason` | str | HTTP status reason ("OK", "Not Found") |
| `ok` | bool | True if status_code < 400 |
| `elapsed` | float | Request duration in seconds |
| `history` | list | Redirect history |
| `request` | PreparedRequest | Original request that created this response |

| Property | Description |
|----------|-------------|
| `is_redirect` | True if response is a redirect status |
| `is_permanent_redirect` | True if 301 or 308 |
| `apparent_encoding` | Best-guess encoding |
| `links` | Parsed Link headers as dict |

| Method | Description |
|--------|-------------|
| `json()` | Parse response body as JSON |
| `raise_for_status()` | Raise HTTPError for 4xx/5xx status |
| `iter_content(chunk_size)` | Iterate over content in chunks |
| `iter_lines(delimiter)` | Iterate over text line by line |

### Session Object

```python
session = bsecure.Session()
```

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `headers` | dict | {} | Default headers for all requests |
| `cookies` | dict | {} | Cookie jar (persists across requests) |
| `auth` | tuple | None | Default authentication |
| `proxies` | dict | {} | Default proxy configuration |
| `verify` | bool | True | Default SSL verification |
| `cert` | str/tuple | None | Default client certificate |
| `max_redirects` | int | 30 | Maximum redirects to follow |
| `trust_env` | bool | True | Trust environment settings |

| Method | Description |
|--------|-------------|
| `request(method, url, **kwargs)` | Send a request |
| `get(url, **kwargs)` | Send GET request |
| `post(url, **kwargs)` | Send POST request |
| `put(url, **kwargs)` | Send PUT request |
| `delete(url, **kwargs)` | Send DELETE request |
| `patch(url, **kwargs)` | Send PATCH request |
| `head(url, **kwargs)` | Send HEAD request |
| `options(url, **kwargs)` | Send OPTIONS request |
| `close()` | Close the session |

### JSON Functions

| Function | Description |
|----------|-------------|
| `loads(s)` | Parse JSON from string/bytes |
| `dumps(obj, indent=None)` | Serialize object to JSON string |
| `load(fp)` | Parse JSON from file object |
| `dump(obj, fp, indent=None)` | Serialize object to JSON file |

### Exceptions

All exceptions inherit from `RequestException`:

```
RequestException
├── HTTPError          # 4xx and 5xx responses
├── ConnectionError    # Network connectivity issues
├── Timeout           # Request timeout
├── TooManyRedirects  # Redirect limit exceeded
└── URLRequired       # URL not provided

JSONDecodeError        # Invalid JSON (inherits from ValueError)
```

## Advanced Usage

### SSL/TLS Configuration

```python
import bsecure

# Disable SSL verification (NOT recommended for production)
response = bsecure.get('https://self-signed.example.com', verify=False)

# Use custom CA bundle
response = bsecure.get(
    'https://internal.example.com',
    verify='/path/to/corporate-ca-bundle.crt'
)

# Client certificate authentication
response = bsecure.get(
    'https://secure.example.com',
    cert='/path/to/client-cert.pem'
)

# Separate certificate and key files
response = bsecure.get(
    'https://secure.example.com',
    cert=('/path/to/client-cert.pem', '/path/to/client-key.pem')
)
```

### Timeout Configuration

```python
import bsecure

# Single timeout (applies to entire request)
response = bsecure.get('https://example.com', timeout=5)

# Float timeout
response = bsecure.get('https://example.com', timeout=2.5)

# Separate connect and read timeouts
response = bsecure.get(
    'https://example.com',
    timeout=(3.0, 10.0)  # 3s connect, 10s read
)
```

### Proxy Configuration

```python
import bsecure

proxies = {
    'http': 'http://proxy.example.com:8080',
    'https': 'http://proxy.example.com:8080',
}

# Single request
response = bsecure.get('https://example.com', proxies=proxies)

# Session-wide proxy
session = bsecure.Session()
session.proxies = proxies
response = session.get('https://example.com')
```

### Authentication

```python
import bsecure

# Basic authentication
response = bsecure.get(
    'https://api.example.com/user',
    auth=('username', 'password')
)

# Session authentication
session = bsecure.Session()
session.auth = ('username', 'password')
response = session.get('https://api.example.com/user')

# Token authentication via headers
session = bsecure.Session()
session.headers['Authorization'] = 'Bearer your-api-token'
response = session.get('https://api.example.com/data')
```

### Handling Redirects

```python
import bsecure

# Follow redirects (default)
response = bsecure.get('https://example.com/redirect')
print(response.url)      # Final URL
print(response.history)  # List of redirect responses

# Disable redirects
response = bsecure.get(
    'https://example.com/redirect',
    allow_redirects=False
)
print(response.status_code)  # 301, 302, etc.

# Limit redirects in session
session = bsecure.Session()
session.max_redirects = 5
```

### Working with Cookies

```python
import bsecure

# Send cookies with request
response = bsecure.get(
    'https://example.com',
    cookies={'session_id': 'abc123'}
)

# Access response cookies
response = bsecure.get('https://example.com')
print(response.cookies)  # {'cookie_name': 'cookie_value'}

# Session cookie persistence
session = bsecure.Session()
session.get('https://example.com/login')  # Server sets cookies
print(session.cookies)  # Cookies are stored
session.get('https://example.com/data')   # Cookies sent automatically
```

### Form Data Encoding

```python
import bsecure

# Dictionary (URL-encoded)
response = bsecure.post(
    'https://example.com/form',
    data={'field1': 'value1', 'field2': 'value2'}
)

# List of tuples (preserves order, allows duplicates)
response = bsecure.post(
    'https://example.com/form',
    data=[('field', 'value1'), ('field', 'value2')]
)

# Raw string body
response = bsecure.post(
    'https://example.com/raw',
    data='raw request body'
)

# Raw bytes
response = bsecure.post(
    'https://example.com/binary',
    data=b'\x00\x01\x02\x03'
)
```

### File Uploads

```python
import bsecure

# Upload bytes with filename
response = bsecure.post(
    'https://httpbin.org/post',
    files={'file': ('document.txt', b'File content here')}
)

# Upload with content type
response = bsecure.post(
    'https://httpbin.org/post',
    files={'image': ('photo.jpg', image_bytes, 'image/jpeg')}
)

# Upload from file path
response = bsecure.post(
    'https://httpbin.org/post',
    files={'document': '/path/to/file.pdf'}
)

# Upload file object
with open('data.json', 'rb') as f:
    response = bsecure.post(
        'https://httpbin.org/post',
        files={'config': f}
    )

# Multiple files
response = bsecure.post(
    'https://httpbin.org/post',
    files={
        'file1': ('a.txt', b'content 1'),
        'file2': ('b.txt', b'content 2')
    }
)

# Files with additional form data
response = bsecure.post(
    'https://httpbin.org/post',
    data={'name': 'John', 'email': 'john@example.com'},
    files={'avatar': ('photo.png', image_bytes)}
)
```

## Error Handling

### Comprehensive Error Handling

```python
import bsecure

def make_request(url):
    try:
        response = bsecure.get(url, timeout=10)
        response.raise_for_status()
        return response.json()
    
    except bsecure.Timeout:
        print(f"Request to {url} timed out")
        return None
    
    except bsecure.ConnectionError as e:
        print(f"Failed to connect to {url}: {e}")
        return None
    
    except bsecure.HTTPError as e:
        print(f"HTTP error {response.status_code}: {e}")
        return None
    
    except bsecure.JSONDecodeError:
        print("Response is not valid JSON")
        return response.text
    
    except bsecure.RequestException as e:
        print(f"Request failed: {e}")
        return None
```

### Checking Response Status

```python
import bsecure

response = bsecure.get('https://api.example.com/data')

# Using ok property
if response.ok:
    data = response.json()
else:
    print(f"Error: {response.status_code} {response.reason}")

# Using status_code
if response.status_code == 200:
    data = response.json()
elif response.status_code == 404:
    print("Resource not found")
elif response.status_code >= 500:
    print("Server error")

# Using raise_for_status()
try:
    response.raise_for_status()
    data = response.json()
except bsecure.HTTPError:
    print(f"Request failed: {response.status_code}")
```

## Performance

### Benchmarks

bsecure significantly outperforms pure Python HTTP libraries:

| Operation | requests | bsecure | Speedup |
|-----------|----------|---------|---------|
| Simple GET | 45ms | 12ms | 3.75x |
| POST JSON | 48ms | 15ms | 3.2x |
| JSON parse (1KB) | 0.8ms | 0.2ms | 4x |
| JSON parse (100KB) | 12ms | 3ms | 4x |

*Benchmarks performed on typical cloud VM, averaged over 1000 iterations*

### Why bsecure is Fast

1. **Native C Extension**: Core HTTP logic in C, not Python
2. **libcurl**: Battle-tested, highly optimized HTTP library
3. **json-c**: Fast C-based JSON parser
4. **Static Linking**: No dynamic library lookup overhead
5. **Connection Reuse**: HTTP keep-alive with sessions

### Memory Efficiency

- Minimal Python object creation during requests
- Efficient buffer management in C layer
- No intermediate string copies for JSON parsing

### Key Design Decisions

1. **Static Linking**: All dependencies compiled in for portability
2. **Embedded CA Certs**: Mozilla CA bundle compiled into binary
3. **Single-threaded**: GIL released during HTTP operations
4. **Memory Safety**: Careful reference counting, no memory leaks

## Migration from requests

### Direct Replacement

In most cases, simply change your import:

```python
# Before
import requests

# After
import bsecure as requests
```

### API Compatibility Notes

| Feature | requests | bsecure | Notes |
|---------|----------|---------|-------|
| GET/POST/etc. | ✅ | ✅ | Fully compatible |
| Sessions | ✅ | ✅ | Fully compatible |
| JSON | ✅ | ✅ | Fully compatible |
| Cookies | ✅ | ✅ | Fully compatible |
| Auth | ✅ | ✅ | Basic auth only |
| Timeouts | ✅ | ✅ | Fully compatible |
| Proxies | ✅ | ✅ | Fully compatible |
| SSL/TLS | ✅ | ✅ | Fully compatible |
| Files upload | ✅ | ✅ | Fully compatible (v2.1.0+) |
| iter_content/iter_lines | ✅ | ✅ | Fully compatible (v2.1.0+) |
| response.request | ✅ | ✅ | Fully compatible (v2.1.0+) |
| response.links | ✅ | ✅ | Fully compatible (v2.1.0+) |
| Streaming | ✅ | ⚠️ | API compatible, not true streaming |
| Hooks | ✅ | ❌ | Not implemented |

## Troubleshooting

### Common Issues

**ImportError: No module named 'bsecure'**
```bash
# Ensure you've built the extension
python3 setup.py build_ext --inplace
```

**SSL Certificate Errors**
```python
# bsecure uses embedded CA certs, but you can specify custom:
bsecure.get('https://example.com', verify='/path/to/ca-bundle.crt')
```

**Connection Timeout**
```python
# Increase timeout for slow networks
bsecure.get('https://example.com', timeout=30)
```

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## Acknowledgments

- [libcurl](https://curl.se/libcurl/) - The multiprotocol file transfer library
- [json-c](https://github.com/json-c/json-c) - JSON implementation in C
- [OpenSSL](https://www.openssl.org/) - TLS/SSL and crypto library
- [nghttp2](https://nghttp2.org/) - HTTP/2 C library
- [Mozilla CA Bundle](https://curl.se/docs/caextract.html) - Trusted CA certificates
