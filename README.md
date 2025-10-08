<div align="center">

# 🔐 BSecure

### A High-Performance, Security-Hardened HTTP Library for Python

[![GitHub Release](https://img.shields.io/github/v/release/binyaminbinni/bsecure?style=for-the-badge&logo=github&color=blue)](https://github.com/binyaminbinni/bsecure/releases/latest)
[![Python Version](https://img.shields.io/badge/python-3.6+-blue?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org)
[![License](https://img.shields.io/github/license/binyaminbinni/bsecure?style=for-the-badge)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/binyaminbinni/bsecure?style=for-the-badge&logo=github)](https://github.com/binyaminbinni/bsecure/stargazers)

**BSecure** combines the simplicity of `requests` with advanced security features and blazing-fast performance. Perfect for developers who need a reliable, secure HTTP client without the complexity.

[📥 Download](https://github.com/binyaminbinni/bsecure/releases/latest) • [📖 Full Documentation](DOCUMENTATIONS.md) • [⭐ Star Us](https://github.com/binyaminbinni/bsecure)

</div>

---

## ✨ Key Features

- 🚀 **High Performance** - Optimized for speed with automatic compression (gzip, deflate, brotli, zstd)
- 🔒 **Security First** - Enhanced TLS/SSL verification and security-hardened by default
- 🎯 **Simple API** - Familiar requests-like interface for easy adoption
- 🔄 **Smart Retries** - Configurable automatic retry logic for failed requests
- 🍪 **Advanced Cookies** - Comprehensive cookie management with multiple formats
- 🔐 **Flexible Auth** - Support for Basic, Bearer, and custom authentication
- 📁 **File Uploads** - Easy multipart/form-data file uploads
- 🌐 **Proxy Support** - Full HTTP/HTTPS proxy configuration
- 📊 **Built-in JSON** - Native JSON encoding and decoding utilities
- ⏱️ **Timeout Control** - Configurable request timeouts

---

## 📥 Installation

**BSecure** is available as a compiled module on GitHub Releases.

1. **Download** the latest release from the [Releases Page](https://github.com/binyaminbinni/bsecure/releases/latest)
2. **Extract** and place the `bsecure` module in your project directory or Python path
3. **Import** and start using:

```python
import bsecure

response = bsecure.get('https://api.example.com/data')
print(response.json())
```

---

## 🚀 Quick Start

### Basic Request

```python
import bsecure

# Simple GET request
response = bsecure.get('https://api.example.com/users')
print(response.status_code)
print(response.json())

# POST with JSON data
response = bsecure.post(
    'https://api.example.com/users',
    json={'name': 'Alice', 'email': 'alice@example.com'}
)
```

### Using Sessions

```python
import bsecure

# Create a session for persistent connections
session = bsecure.Session()
session.headers = {'User-Agent': 'MyApp/1.0'}
session.timeout = 10.0

# Login
response = session.post(
    'https://api.example.com/login',
    json={'username': 'user', 'password': 'pass'}
)

# Session automatically maintains cookies
profile = session.get('https://api.example.com/profile').json()
print(f"Welcome, {profile['name']}!")
```

### Authentication

```python
import bsecure

# Basic authentication
response = bsecure.get(
    'https://api.example.com/protected',
    auth=('username', 'password')
)

# Bearer token
session = bsecure.Session()
session.auth = 'Bearer your_access_token_here'
response = session.get('https://api.example.com/data')

# API Key
session.auth = {'X-API-Key': 'your_api_key'}
```

### File Upload

```python
import bsecure

# Upload a file
with open('document.pdf', 'rb') as f:
    files = {'document': ('report.pdf', f.read())}
    response = bsecure.post(
        'https://api.example.com/upload',
        files=files
    )
print(f"Uploaded: {response.status_code}")
```

### Error Handling

```python
import bsecure

try:
    response = bsecure.get('https://api.example.com/data', timeout=5.0)
    response.raise_for_status()
    data = response.json()
except bsecure.TimeoutError:
    print("Request timed out")
except bsecure.ConnectionError:
    print("Connection failed")
except bsecure.BSecureError as e:
    print(f"Error: {e}")
```

---

## 📚 Core API

### HTTP Methods

```python
bsecure.get(url, **kwargs)      # GET request
bsecure.post(url, **kwargs)     # POST request
bsecure.put(url, **kwargs)      # PUT request
bsecure.delete(url, **kwargs)   # DELETE request
bsecure.patch(url, **kwargs)    # PATCH request
bsecure.head(url, **kwargs)     # HEAD request
bsecure.options(url, **kwargs)  # OPTIONS request
```

### Request Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `params` | `dict` | URL query parameters |
| `data` | `dict/str/bytes` | Request body (form/raw) |
| `json` | `dict/list` | JSON request body |
| `files` | `dict` | File uploads |
| `headers` | `dict` | HTTP headers |
| `cookies` | `dict/str` | Cookies |
| `auth` | `tuple/str/dict` | Authentication |
| `timeout` | `float` | Timeout in seconds |
| `proxies` | `dict` | Proxy configuration |
| `verify` | `bool` | SSL verification |
| `max_retries` | `int` | Retry attempts |
| `allow_redirects` | `bool` | Follow redirects |

### Response Object

```python
response.status_code    # HTTP status code (int)
response.text          # Response body as text (str)
response.content       # Response body as bytes
response.json()        # Parse JSON response
response.headers       # Response headers (dict)
response.cookies       # Response cookies
response.url           # Final URL after redirects
response.elapsed       # Request duration (float)
response.raise_for_status()  # Raise exception for errors
```

### Session Object

```python
session = bsecure.Session()

# Session properties
session.headers = {'User-Agent': 'MyApp/1.0'}
session.cookies = {'session': 'abc123'}
session.auth = ('user', 'pass')
session.timeout = 30.0
session.proxies = {'https': 'http://proxy.com:8080'}
session.verify = True
session.max_retries = 5
session.retry_delay = 1.0

# Cookie management methods
session.get_cookies_dict(url)        # Get cookies for URL
session.get_cookies_string(url)      # Get cookie string
session.set_cookies_dict(url, dict)  # Set cookies for URL
```

---

## 📖 Full Documentation

For comprehensive documentation including:

- 🌐 **All HTTP Methods** - Detailed examples for GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS
- 💼 **Session Management** - Advanced session configuration and usage
- 📦 **Request Parameters** - Complete parameter reference with examples
- 📬 **Response Handling** - Working with response objects and data
- 🍪 **Cookie Management** - Cookie formats, persistence, and workflows
- 🔑 **Authentication** - OAuth2, API keys, Basic Auth, custom schemes
- 📤 **File Uploads** - Single and multiple file uploads with validation
- ⚡ **Advanced Features** - Retries, redirects, proxies, compression
- 🛡️ **Error Handling** - Exception types and handling patterns
- 🔧 **Utilities** - JSON utilities and helper functions
- 💡 **Best Practices** - Production-ready patterns and examples

**👉 See the complete [DOCUMENTATIONS.md](DOCUMENTATIONS.md) for detailed guides and examples.**

---

## 🎯 Complete Example

```python
import bsecure

# Create and configure a session
session = bsecure.Session()
session.headers = {'User-Agent': 'MyApp/1.0', 'Accept': 'application/json'}
session.timeout = 30.0
session.max_retries = 3

# Authenticate
auth_response = session.post(
    'https://api.example.com/login',
    json={'username': 'user', 'password': 'pass'}
)

# Extract token and set authentication
token = auth_response.json()['access_token']
session.auth = f'Bearer {token}'

# Make authenticated requests
profile = session.get('https://api.example.com/profile').json()
print(f"Hello, {profile['name']}!")

# Upload a file
with open('report.pdf', 'rb') as f:
    upload_response = session.post(
        'https://api.example.com/documents',
        files={'document': ('report.pdf', f.read())},
        params={'category': 'reports'}
    )
    print(f"Uploaded: {upload_response.status_code}")

# Logout
session.post('https://api.example.com/logout')
```

---

## 🛡️ Exception Handling

BSecure provides specific exception types for precise error handling:

```python
import bsecure

try:
    response = bsecure.get('https://api.example.com/data', timeout=10.0)
    response.raise_for_status()
except bsecure.SSLError:
    print("SSL certificate validation failed")
except bsecure.TimeoutError:
    print("Request timed out")
except bsecure.ConnectionError:
    print("Network connection failed")
except bsecure.ProxyError:
    print("Proxy configuration error")
except bsecure.BSecureError as e:
    print(f"Request error: {e}")
```

**Exception Types:**
- `BSecureError` - Base exception
- `SSLError` - SSL/TLS errors
- `TimeoutError` - Request timeout
- `ConnectionError` - Network failures
- `ProxyError` - Proxy issues
- `RedirectError` - Too many redirects
- `RequestError` - General request errors

---

## 📖 Resources

- 📚 **[Complete Documentation](DOCUMENTATIONS.md)** - Full API reference and guides
- 📥 **[Latest Release](https://github.com/binyaminbinni/bsecure/releases/latest)** - Download the module
- 🐛 **[Issues](https://github.com/binyaminbinni/bsecure/issues)** - Report bugs or request features
- ⭐ **[Star on GitHub](https://github.com/binyaminbinni/bsecure)** - Show your support

---

## 🤝 Contributing

We welcome contributions! To contribute:

1. 🍴 Fork the repository
2. 🔨 Create a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🎯 Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the repository for details.

---

<div align="center">

**Made with ❤️ by [Binyamin Binni](https://github.com/binyaminbinni)**

[![GitHub](https://img.shields.io/badge/GitHub-binyaminbinni-181717?style=for-the-badge&logo=github)](https://github.com/binyaminbinni)

**BSecure - Secure, Fast, Elegant HTTP for Python**

</div>
