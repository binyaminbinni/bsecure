# 🔐 BSecure - Python HTTP Library

> **A high-performance, secure Python HTTP library with an elegant and intuitive API**

<div align="center">

[![Author](https://img.shields.io/badge/Author-Binyamin%20Binni-blue.svg)](https://github.com/binyaminbinni)
[![Python](https://img.shields.io/badge/Python-3.7+-green.svg)](https://www.python.org/)
[![Security](https://img.shields.io/badge/Security-Enhanced%20TLS-red.svg)](https://github.com/binyaminbinni/bsecure)

</div>

---

## 📋 Table of Contents

- [✨ Overview](#-overview)
- [🚀 Quick Start](#-quick-start)
- [🌐 HTTP Methods](#-http-methods)
- [💼 Session Management](#-session-management)
- [📦 Request Parameters](#-request-parameters)
- [📬 Response Handling](#-response-handling)
- [🍪 Cookie Management](#-cookie-management)
- [🔑 Authentication](#-authentication)
- [📤 File Uploads](#-file-uploads)
- [⚡ Advanced Features](#-advanced-features)
- [🛡️ Error Handling](#️-error-handling)
- [🔧 Utilities](#-utilities)
- [💡 Best Practices](#-best-practices)

---

## ✨ Overview

**BSecure** is a cutting-edge Python HTTP library engineered for developers who demand both **performance** and **security**. Built with a requests-like interface, it provides seamless integration while offering advanced features under the hood.

### 🎯 Key Features

| Feature | Description |
|---------|-------------|
| 🎨 **Elegant API** | Intuitive, requests-compatible interface |
| 🔄 **Session Management** | Persistent connections with automatic cookie handling |
| 🔐 **Enhanced Security** | Built-in TLS/SSL certificate validation |
| 🚀 **High Performance** | Optimized for speed with automatic compression support |
| 🔁 **Smart Retries** | Configurable retry logic for failed requests |
| 🌍 **Proxy Support** | Full HTTP/HTTPS proxy configuration |
| 📊 **JSON Built-in** | Native JSON encoding/decoding utilities |
| 📁 **File Uploads** | Simple multipart file upload support |
| ⚠️ **Rich Exceptions** | Detailed error types for precise handling |

---

## 🚀 Quick Start

### Installation

```python
import bsecure
```

### Your First Request

```python
import bsecure

# Simple GET request
response = bsecure.get('https://api.github.com/users/octocat')
print(f"Status: {response.status_code}")
print(f"User: {response.json()['name']}")
```

### POST with JSON

```python
response = bsecure.post(
    'https://api.example.com/users',
    json={'name': 'John Doe', 'email': 'john@example.com'}
)
print(response.json())
```

---

## 🌐 HTTP Methods

BSecure provides full support for all standard HTTP methods. Each method is available both as a **module-level function** and as a **session method**.

### 📥 GET - Retrieve Resources

```python
# Module-level request
response = bsecure.get('https://api.example.com/users/123')

# With query parameters
response = bsecure.get(
    'https://api.example.com/search',
    params={'q': 'python', 'limit': 10}
)
```

### 📤 POST - Create Resources

```python
# JSON data
response = bsecure.post(
    'https://api.example.com/users',
    json={
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'developer'
    }
)

# Form data
response = bsecure.post(
    'https://example.com/login',
    data={'username': 'alice', 'password': 'secret'}
)
```

### 🔄 PUT - Update Resources

```python
response = bsecure.put(
    'https://api.example.com/users/123',
    json={'name': 'Alice Smith', 'role': 'senior developer'}
)
```

### ❌ DELETE - Remove Resources

```python
response = bsecure.delete('https://api.example.com/users/123')
```

### 📋 HEAD - Get Headers Only

```python
response = bsecure.head('https://example.com/large-file.zip')
print(f"Content-Length: {response.headers['Content-Length']}")
print(f"Content-Type: {response.headers['Content-Type']}")
```

### 🔧 PATCH - Partial Updates

```python
response = bsecure.patch(
    'https://api.example.com/users/123',
    json={'role': 'team lead'}
)
```

### ⚙️ OPTIONS - Discover Capabilities

```python
response = bsecure.options('https://api.example.com/users')
allowed_methods = response.headers.get('Allow')
print(f"Allowed methods: {allowed_methods}")
```

### 📊 Method Summary Table

| Method | Purpose | Common Use Case |
|--------|---------|-----------------|
| `GET` | Retrieve data | Fetching user profiles, lists |
| `POST` | Create new resource | User registration, form submission |
| `PUT` | Full update | Replacing entire resource |
| `DELETE` | Remove resource | Deleting user account |
| `HEAD` | Get metadata | Checking file size before download |
| `PATCH` | Partial update | Updating specific fields |
| `OPTIONS` | Check capabilities | API discovery |

---

## 💼 Session Management

**Sessions** are the powerhouse of BSecure, enabling persistent connections, cookie retention, and shared configuration across multiple requests.

### Creating a Session

```python
import bsecure

session = bsecure.Session()
```

### 🎛️ Session Properties

Configure your session with these powerful properties:

#### Headers
```python
session.headers = {
    'User-Agent': 'MyAwesomeApp/2.0',
    'Accept': 'application/json',
    'X-Custom-Header': 'value'
}
```

#### Cookies
```python
# Set session-wide cookies
session.cookies = {'session_id': 'abc123', 'preference': 'dark_mode'}
```

#### Authentication
```python
# Basic auth (tuple)
session.auth = ('username', 'password')

# Bearer token (string)
session.auth = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'

# Custom headers (dict)
session.auth = {'Authorization': 'Custom token', 'X-API-Key': 'key123'}
```

#### Proxy Configuration
```python
session.proxies = {
    'http': 'http://proxy.example.com:8080',
    'https': 'http://proxy.example.com:8080'
}
```

#### Timeout
```python
# Set timeout in seconds (float)
session.timeout = 30.0
```

#### SSL Verification
```python
# Enable/disable SSL certificate verification
session.verify = True  # Default
```

#### Retry Configuration
```python
# Maximum number of retries for failed requests
session.max_retries = 5  # Default

# Delay between retries in seconds
session.retry_delay = 1.0  # Default
```

#### Redirect Settings
```python
# Enable/disable automatic redirects
session.allow_redirects = True  # Default

# Maximum number of redirects to follow
session.max_redirects = 30  # Default
```

### 🔄 Making Requests with Sessions

```python
# Create session with configuration
session = bsecure.Session()
session.headers = {'User-Agent': 'MyApp/1.0'}
session.timeout = 10.0
session.max_retries = 3

# All requests inherit session configuration
response = session.get('https://api.example.com/users')
response = session.post('https://api.example.com/users', json={'name': 'Bob'})
response = session.put('https://api.example.com/users/1', json={'name': 'Robert'})
response = session.delete('https://api.example.com/users/1')
```

### 🍪 Advanced Cookie Methods

```python
session = bsecure.Session()

# Get cookies for a specific URL as dictionary
cookies_dict = session.get_cookies_dict('https://example.com')
print(cookies_dict)  # {'session': 'abc123', 'token': 'xyz'}

# Get cookies as string (Cookie header format)
cookie_string = session.get_cookies_string('https://example.com')
print(cookie_string)  # "session=abc123; token=xyz"

# Set cookies for a specific URL
session.set_cookies_dict(
    'https://example.com',
    {'new_cookie': 'value123'}
)
```

### 💡 Real-World Session Example

```python
import bsecure

# Initialize session with configuration
session = bsecure.Session()
session.headers = {
    'User-Agent': 'MyApp/2.0',
    'Accept': 'application/json'
}
session.timeout = 15.0
session.max_retries = 3
session.retry_delay = 2.0

# Step 1: Login (cookies are automatically stored)
login_response = session.post(
    'https://api.example.com/auth/login',
    json={'email': 'user@example.com', 'password': 'secure_pass'}
)

# Step 2: Extract token and set as auth
token = login_response.json()['access_token']
session.auth = f'Bearer {token}'

# Step 3: Make authenticated requests (session maintains auth and cookies)
profile = session.get('https://api.example.com/user/profile').json()
print(f"Welcome, {profile['name']}!")

# Step 4: Upload a file
with open('report.pdf', 'rb') as f:
    upload_response = session.post(
        'https://api.example.com/documents',
        files={'document': ('report.pdf', f.read())}
    )
    print(f"Upload status: {upload_response.status_code}")

# Step 5: Fetch data with parameters
documents = session.get(
    'https://api.example.com/documents',
    params={'page': 1, 'limit': 20, 'sort': 'date_desc'}
).json()
print(f"Retrieved {len(documents)} documents")

# Step 6: Logout
session.post('https://api.example.com/auth/logout')
```

### 🎯 Session Configuration Reference

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `headers` | `dict` | `{}` | HTTP headers sent with all requests |
| `cookies` | `dict` | `{}` | Cookies sent with all requests |
| `auth` | `tuple/str/dict` | `None` | Authentication credentials |
| `proxies` | `dict` | `None` | Proxy configuration |
| `timeout` | `float` | `60.0` | Request timeout in seconds |
| `verify` | `bool` | `True` | SSL certificate verification |
| `max_retries` | `int` | `5` | Maximum retry attempts |
| `retry_delay` | `float` | `1.0` | Delay between retries (seconds) |
| `allow_redirects` | `bool` | `True` | Follow HTTP redirects |
| `max_redirects` | `int` | `30` | Maximum redirects to follow |

---

## 📦 Request Parameters

Fine-tune your requests with these powerful parameters, available for all HTTP methods.

### 🔍 URL Parameters (`params`)

Add query string parameters to your request URL:

```python
# Single page request
params = {'page': 1, 'limit': 20}
response = bsecure.get('https://api.example.com/items', params=params)
# Results in: https://api.example.com/items?page=1&limit=20

# Complex search
params = {
    'q': 'python programming',
    'category': 'books',
    'sort': 'popularity',
    'filter': 'in_stock'
}
response = bsecure.get('https://api.example.com/search', params=params)
```

### 📝 Request Body Data (`data`)

Send form-encoded or raw data:

```python
# Dictionary (automatically form-encoded)
data = {'username': 'alice', 'password': 'secret123'}
response = bsecure.post('https://example.com/login', data=data)
# Content-Type: application/x-www-form-urlencoded

# String data
data = "raw text data for processing"
response = bsecure.post('https://example.com/api/process', data=data)

# Binary data
with open('image.png', 'rb') as f:
    data = f.read()
response = bsecure.post('https://example.com/api/upload', data=data)
```

### 📊 JSON Data (`json`)

The most elegant way to send structured data:

```python
# Simple JSON
response = bsecure.post(
    'https://api.example.com/users',
    json={
        'name': 'Jane Doe',
        'email': 'jane@example.com',
        'age': 28
    }
)
# Automatically sets Content-Type: application/json

# Complex nested JSON
response = bsecure.post(
    'https://api.example.com/orders',
    json={
        'customer': {
            'id': 12345,
            'name': 'John Smith'
        },
        'items': [
            {'product_id': 101, 'quantity': 2},
            {'product_id': 205, 'quantity': 1}
        ],
        'shipping': {
            'method': 'express',
            'address': '123 Main St, City, Country'
        },
        'total': 149.99
    }
)
```

### 📄 Custom Headers (`headers`)

Override or add specific headers:

```python
headers = {
    'User-Agent': 'MyCustomApp/3.0',
    'Accept': 'application/json',
    'Accept-Language': 'en-US',
    'X-API-Version': '2.0',
    'X-Request-ID': 'abc-123-def'
}
response = bsecure.get('https://api.example.com/data', headers=headers)
```

### 🍪 Request Cookies (`cookies`)

Send cookies with individual requests:

```python
# Dictionary format (recommended)
cookies = {'session': 'abc123', 'preferences': 'theme=dark'}
response = bsecure.get('https://example.com/dashboard', cookies=cookies)

# String format
cookies = 'session=abc123; preferences=theme=dark'
response = bsecure.get('https://example.com/dashboard', cookies=cookies)
```

### ⏱️ Timeout (`timeout`)

Set request timeout in seconds:

```python
# 5 second timeout
response = bsecure.get('https://slow-api.example.com', timeout=5.0)

# Different timeout for different operations
fast_response = bsecure.get('https://api.example.com/quick', timeout=2.0)
slow_response = bsecure.post('https://api.example.com/process', 
                              json=data, timeout=30.0)
```

### 🌐 Proxy Configuration (`proxies`)

Route requests through proxy servers:

```python
# HTTP and HTTPS proxies
proxies = {
    'http': 'http://proxy.example.com:8080',
    'https': 'http://proxy.example.com:8080'
}
response = bsecure.get('https://example.com', proxies=proxies)

# With authentication
proxies = {
    'http': 'http://user:pass@proxy.example.com:8080',
    'https': 'http://user:pass@proxy.example.com:8080'
}
response = bsecure.get('https://example.com', proxies=proxies)
```

### 🔐 Authentication (`auth`)

Multiple authentication methods supported:

```python
# Basic Authentication (tuple)
auth = ('username', 'password')
response = bsecure.get('https://api.example.com/protected', auth=auth)

# Bearer Token (string)
auth = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
response = bsecure.get('https://api.example.com/protected', auth=auth)

# Custom headers (dict)
auth = {
    'Authorization': 'Custom token_value',
    'X-API-Key': 'your_api_key_here'
}
response = bsecure.get('https://api.example.com/protected', auth=auth)
```

### ✅ SSL Verification (`verify`)

Control SSL certificate verification:

```python
# Verify SSL certificates (default, recommended)
response = bsecure.get('https://secure-api.example.com', verify=True)

# Disable verification (not recommended for production)
response = bsecure.get('https://self-signed.example.com', verify=False)
```

### 🔁 Retry Configuration (`max_retries`, `retry_delay`)

Configure automatic retry behavior:

```python
# Retry up to 10 times with 2 second delay
response = bsecure.get(
    'https://unstable-api.example.com',
    max_retries=10,
    retry_delay=2.0
)

# Quick retries for time-sensitive operations
response = bsecure.post(
    'https://api.example.com/realtime',
    json=data,
    max_retries=3,
    retry_delay=0.5
)
```

### ↪️ Redirect Settings (`allow_redirects`, `max_redirects`)

Control redirect behavior:

```python
# Follow redirects (default)
response = bsecure.get('https://example.com/old-url', allow_redirects=True)

# Don't follow redirects
response = bsecure.get('https://example.com/redirect', allow_redirects=False)
print(response.status_code)  # Will be 301, 302, etc.

# Limit number of redirects
response = bsecure.get(
    'https://example.com/many-redirects',
    allow_redirects=True,
    max_redirects=5
)
```

### 📁 File Uploads (`files`)

Upload files using multipart/form-data:

```python
# Single file from bytes
with open('document.pdf', 'rb') as f:
    files = {'document': ('report.pdf', f.read())}
    response = bsecure.post('https://example.com/upload', files=files)

# Multiple files
files = {
    'document': ('report.pdf', open('report.pdf', 'rb').read()),
    'image': ('photo.jpg', open('photo.jpg', 'rb').read()),
    'video': ('demo.mp4', '/path/to/demo.mp4')  # Can use file path
}
response = bsecure.post('https://example.com/upload', files=files)

# Files with additional form data
files = {'document': ('report.pdf', open('report.pdf', 'rb').read())}
params = {'title': 'Q3 Report', 'category': 'finance'}
response = bsecure.post('https://example.com/upload', 
                        files=files, params=params)
```

### 🎯 Parameter Combination Example

```python
# Combining multiple parameters
response = bsecure.post(
    'https://api.example.com/data',
    params={'version': 'v2', 'format': 'detailed'},  # Query params
    json={'items': [1, 2, 3]},                       # JSON body
    headers={'X-Client-ID': 'mobile-app'},           # Custom header
    cookies={'session': 'xyz789'},                   # Cookie
    auth='Bearer token123',                          # Authentication
    timeout=15.0,                                    # Timeout
    max_retries=5,                                   # Retry count
    retry_delay=1.0,                                 # Retry delay
    allow_redirects=True,                            # Follow redirects
    verify=True                                      # Verify SSL
)
```

### 📋 Parameters Reference Table

| Parameter | Type | Description | Available In |
|-----------|------|-------------|-------------|
| `params` | `dict` | URL query parameters | All methods |
| `data` | `dict/str/bytes` | Request body (form/raw) | POST, PUT, PATCH |
| `json` | `dict/list` | JSON request body | POST, PUT, PATCH |
| `files` | `dict/list` | File uploads (multipart) | POST, PUT, PATCH |
| `headers` | `dict` | HTTP headers | All methods |
| `cookies` | `dict/str` | Request cookies | All methods |
| `auth` | `tuple/str/dict` | Authentication | All methods |
| `timeout` | `float` | Request timeout (seconds) | All methods |
| `proxies` | `dict` | Proxy configuration | All methods |
| `verify` | `bool` | SSL verification | All methods |
| `max_retries` | `int` | Maximum retry attempts | All methods |
| `retry_delay` | `float` | Delay between retries | All methods |
| `allow_redirects` | `bool` | Follow redirects | All methods |
| `max_redirects` | `int` | Max redirect count | All methods |

---

## 📬 Response Handling

Every request returns a powerful **Response** object packed with useful properties and methods.

### 📊 Response Properties

```python
response = bsecure.get('https://api.example.com/users/123')

# HTTP Status Code
print(response.status_code)  # 200

# Status Reason Phrase
print(response.reason)  # "OK"

# Response Headers (dict)
print(response.headers)
# {'Content-Type': 'application/json', 'Content-Length': '1234', ...}

# Raw Content (bytes)
print(response.content)  # b'{"id": 123, "name": "John"}'

# Decoded Text (string)
print(response.text)  # '{"id": 123, "name": "John"}'

# Final URL (after redirects)
print(response.url)  # "https://api.example.com/users/123"

# Request Duration (seconds)
print(response.elapsed)  # 0.523

# Response Cookies
print(response.cookies)  # <Cookies object>

# Original Request Object
print(response.request)  # Request details
```

### 🔧 Response Methods

#### 📦 JSON Parsing

Automatically parse JSON responses:

```python
response = bsecure.get('https://api.example.com/users/123')

# Parse JSON response
user_data = response.json()
print(user_data)
# {'id': 123, 'name': 'John Doe', 'email': 'john@example.com'}

# Access nested data
print(f"User: {user_data['name']}")
print(f"Email: {user_data['email']}")
```

#### ⚠️ Raise for Status

Automatically raise exceptions for error status codes:

```python
response = bsecure.get('https://api.example.com/users/123')

# Raises exception if status >= 400
response.raise_for_status()

# Use in error handling
try:
    response = bsecure.get('https://api.example.com/protected')
    response.raise_for_status()
    data = response.json()
except Exception as e:
    print(f"Request failed: {e}")
```

### 🎨 Working with Response Headers

```python
response = bsecure.get('https://api.example.com/download')

# Get specific header
content_type = response.headers.get('Content-Type')
content_length = response.headers.get('Content-Length')

# Check header existence
if 'ETag' in response.headers:
    etag = response.headers['ETag']
    print(f"Resource ETag: {etag}")

# Common headers
print(f"Server: {response.headers.get('Server')}")
print(f"Date: {response.headers.get('Date')}")
print(f"Cache-Control: {response.headers.get('Cache-Control')}")
```

### 🍪 Accessing Response Cookies

```python
response = bsecure.post('https://example.com/login', 
                        json={'username': 'user', 'password': 'pass'})

# Get cookies as dictionary
cookies_dict = response.cookies.get_dict()
print(cookies_dict)  # {'session_id': 'abc123', 'token': 'xyz789'}

# Get cookies as string (Cookie header format)
cookies_string = response.cookies.get_string()
print(cookies_string)  # "session_id=abc123; token=xyz789"

# Get detailed cookie information
cookies_list = response.cookies.get_list_dict()
print(cookies_list)
# [
#   {
#     'name': 'session_id',
#     'value': 'abc123',
#     'domain': '.example.com',
#     'path': '/',
#     'secure': True,
#     'http_only': True
#   },
#   ...
# ]
```

### 📈 Status Code Handling

```python
response = bsecure.get('https://api.example.com/resource')

# Success codes (2xx)
if response.status_code == 200:
    print("✅ Success!")
elif response.status_code == 201:
    print("✅ Created!")
elif response.status_code == 204:
    print("✅ No Content")

# Redirect codes (3xx)
elif response.status_code == 301:
    print("↪️ Moved Permanently")
elif response.status_code == 302:
    print("↪️ Found (Temporary Redirect)")

# Client error codes (4xx)
elif response.status_code == 400:
    print("❌ Bad Request")
elif response.status_code == 401:
    print("🔐 Unauthorized")
elif response.status_code == 403:
    print("🚫 Forbidden")
elif response.status_code == 404:
    print("🔍 Not Found")
elif response.status_code == 429:
    print("⏰ Too Many Requests")

# Server error codes (5xx)
elif response.status_code >= 500:
    print("⚠️ Server Error")

# Generic range checking
if 200 <= response.status_code < 300:
    print("Success range")
elif 400 <= response.status_code < 500:
    print("Client error range")
elif response.status_code >= 500:
    print("Server error range")
```

### 💡 Complete Response Example

```python
import bsecure

# Make request
response = bsecure.get('https://api.github.com/users/octocat')

# Status information
print(f"Status: {response.status_code} {response.reason}")
print(f"Request took: {response.elapsed:.3f} seconds")
print(f"Final URL: {response.url}")

# Headers
print(f"\nContent-Type: {response.headers.get('Content-Type')}")
print(f"Content-Length: {response.headers.get('Content-Length')} bytes")

# Parse JSON
user = response.json()
print(f"\nUser Information:")
print(f"  Name: {user['name']}")
print(f"  Bio: {user['bio']}")
print(f"  Public Repos: {user['public_repos']}")
print(f"  Followers: {user['followers']}")

# Raw content
print(f"\nRaw content size: {len(response.content)} bytes")
```

### 🎯 Response Property Reference

| Property | Type | Description |
|----------|------|-------------|
| `status_code` | `int` | HTTP status code (e.g., 200, 404) |
| `reason` | `str` | HTTP reason phrase (e.g., "OK", "Not Found") |
| `headers` | `dict` | Response headers |
| `content` | `bytes` | Raw response body (binary) |
| `text` | `str` | Decoded response body (text) |
| `url` | `str` | Final URL (after redirects) |
| `elapsed` | `float` | Request duration in seconds |
| `cookies` | `Cookies` | Response cookies object |
| `request` | `object` | Original request object |

### 🔧 Response Method Reference

| Method | Returns | Description |
|--------|---------|-------------|
| `json()` | `dict/list` | Parse JSON response body |
| `raise_for_status()` | `None` | Raise exception if status >= 400 |

---

## 🍪 Cookie Management

BSecure provides comprehensive cookie handling with multiple formats and powerful management features.

### 🎭 Cookie Formats

BSecure supports three flexible cookie formats:

#### 1️⃣ Dictionary Format (Recommended)

```python
cookies = {
    'session_id': 'abc123',
    'user_token': 'xyz789',
    'preferences': 'dark_mode'
}
response = bsecure.get('https://example.com', cookies=cookies)
```

#### 2️⃣ String Format (Cookie Header)

```python
cookies = 'session_id=abc123; user_token=xyz789; preferences=dark_mode'
response = bsecure.get('https://example.com', cookies=cookies)
```

#### 3️⃣ Detailed List Format

```python
cookies = [
    {
        'name': 'session_id',
        'value': 'abc123',
        'domain': '.example.com',
        'path': '/',
        'secure': 'true',
        'http_only': 'true',
        'same_site': 'Lax'
    },
    {
        'name': 'user_token',
        'value': 'xyz789',
        'domain': '.example.com',
        'path': '/',
        'max_age': 3600
    }
]
response = bsecure.get('https://example.com', cookies=cookies)
```

### 📤 Setting Cookies

#### Request-Level Cookies

```python
# Per-request cookies (temporary)
response = bsecure.get(
    'https://example.com/dashboard',
    cookies={'session': 'abc123', 'theme': 'dark'}
)
```

#### Session-Level Cookies

```python
# Session cookies (persistent across requests)
session = bsecure.Session()
session.cookies = {'session': 'abc123', 'api_key': 'key123'}

# Cookies automatically sent with all requests
response = session.get('https://example.com/api/data')
response = session.post('https://example.com/api/update', json={...})
```

### 📥 Getting Cookies

#### From Response Object

```python
response = bsecure.post('https://example.com/login',
                        json={'username': 'user', 'password': 'pass'})

# As dictionary (simple key-value pairs)
cookies_dict = response.cookies.get_dict()
print(cookies_dict)
# {'session_id': 'abc123', 'token': 'xyz789'}

# As string (Cookie header format)
cookies_string = response.cookies.get_string()
print(cookies_string)
# "session_id=abc123; token=xyz789"

# As detailed list (all cookie attributes)
cookies_list = response.cookies.get_list_dict()
print(cookies_list)
# [
#   {
#     'name': 'session_id',
#     'value': 'abc123',
#     'domain': '.example.com',
#     'path': '/',
#     'expires': 'Thu, 01 Jan 2025 00:00:00 GMT',
#     'max_age': 3600,
#     'secure': True,
#     'http_only': True,
#     'same_site': 'Lax'
#   }
# ]
```

### 🎯 Session Cookie Methods

Sessions provide advanced cookie management for specific URLs:

```python
session = bsecure.Session()

# Make a request to set cookies
session.post('https://example.com/login', json={'user': 'alice'})

# Get cookies for specific URL as dictionary
cookies = session.get_cookies_dict('https://example.com')
print(cookies)  # {'session': 'abc123', 'token': 'xyz'}

# Get cookies as string for specific URL
cookie_string = session.get_cookies_string('https://example.com')
print(cookie_string)  # "session=abc123; token=xyz"

# Set cookies for specific URL
session.set_cookies_dict(
    'https://example.com',
    {'new_session': 'def456', 'user_pref': 'compact_view'}
)

# Cookies are now available for that domain
response = session.get('https://example.com/profile')
```

### 🔄 Cookie Persistence Workflow

```python
import bsecure

# Create session
session = bsecure.Session()

# Step 1: Login - Cookies are automatically captured
login_response = session.post(
    'https://example.com/api/login',
    json={'username': 'alice@example.com', 'password': 'secure123'}
)

# Step 2: View captured cookies
print("🍪 Cookies after login:")
cookies = session.get_cookies_dict('https://example.com')
for name, value in cookies.items():
    print(f"  {name}: {value}")

# Step 3: Cookies automatically sent with subsequent requests
profile_response = session.get('https://example.com/api/profile')
print(f"\n✅ Profile loaded: {profile_response.json()['name']}")

# Step 4: Update specific cookies
session.set_cookies_dict(
    'https://example.com',
    {'theme': 'dark', 'language': 'en'}
)

# Step 5: All cookies (old + new) are sent
settings_response = session.get('https://example.com/api/settings')
print(f"\n⚙️ Settings: {settings_response.json()}")
```

### 🎨 Cookie Attributes Reference

When using detailed list format, these attributes are available:

| Attribute | Type | Description |
|-----------|------|-------------|
| `name` | `str` | Cookie name (required) |
| `value` | `str` | Cookie value (required) |
| `domain` | `str` | Cookie domain (e.g., `.example.com`) |
| `path` | `str` | Cookie path (e.g., `/`, `/api`) |
| `expires` | `str` | Expiration date (RFC1123 format) |
| `max_age` | `int` | Max age in seconds |
| `secure` | `bool/str` | Only send over HTTPS |
| `http_only` | `bool/str` | Not accessible via JavaScript |
| `same_site` | `str` | SameSite policy (`Strict`, `Lax`, `None`) |

### 💡 Real-World Cookie Example

```python
import bsecure

def login_and_fetch_data():
    # Initialize session
    session = bsecure.Session()
    
    # Step 1: Login
    print("🔐 Logging in...")
    login_resp = session.post(
        'https://api.example.com/auth/login',
        json={'email': 'user@example.com', 'password': 'secret'}
    )
    
    if login_resp.status_code != 200:
        print("❌ Login failed")
        return
    
    # Step 2: Check received cookies
    print("\n🍪 Received cookies:")
    cookies_detail = login_resp.cookies.get_list_dict()
    for cookie in cookies_detail:
        print(f"  📌 {cookie['name']}")
        print(f"     Value: {cookie['value'][:20]}...")
        print(f"     Domain: {cookie.get('domain', 'N/A')}")
        print(f"     Secure: {cookie.get('secure', False)}")
        print(f"     HttpOnly: {cookie.get('http_only', False)}")
    
    # Step 3: Use cookies for authenticated requests
    print("\n📊 Fetching user data...")
    user_resp = session.get('https://api.example.com/user/profile')
    user_data = user_resp.json()
    print(f"✅ Welcome, {user_data['name']}!")
    
    # Step 4: Check active cookies
    print("\n🔍 Active cookies for domain:")
    active_cookies = session.get_cookies_string('https://api.example.com')
    print(f"  {active_cookies}")
    
    # Step 5: Logout (cookies will be cleared by server)
    print("\n👋 Logging out...")
    session.post('https://api.example.com/auth/logout')
    
login_and_fetch_data()
```

### 🎯 Cookie Method Reference

| Method | Context | Returns | Description |
|--------|---------|---------|-------------|
| `get_dict()` | Response/Cookies | `dict` | Simple name-value pairs |
| `get_string()` | Response/Cookies | `str` | Cookie header format |
| `get_list_dict()` | Response/Cookies | `list` | Detailed cookie attributes |
| `get_cookies_dict(url)` | Session | `dict` | Cookies for specific URL |
| `get_cookies_string(url)` | Session | `str` | Cookie string for URL |
| `set_cookies_dict(url, dict)` | Session | `None` | Set cookies for URL |

---

## 🔑 Authentication

BSecure supports multiple authentication methods to integrate with any API.

### 🔐 Basic Authentication

Use tuple format for traditional username/password authentication:

```python
# Tuple format (username, password)
auth = ('alice@example.com', 'secure_password123')
response = bsecure.get('https://api.example.com/protected', auth=auth)

# Session-level basic auth
session = bsecure.Session()
session.auth = ('admin', 'admin_password')
response = session.get('https://api.example.com/admin/dashboard')
```

### 🎫 Bearer Token Authentication

Perfect for modern APIs using JWT or OAuth tokens:

```python
# With "Bearer" prefix (recommended)
token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIn0.dozjgNryP4J3jVmNHl0w5N_XgL0n3I9PlFUP0THsR8U'
auth = f'Bearer {token}'
response = bsecure.get('https://api.example.com/user/profile', auth=auth)

# Without prefix (automatically adds "Bearer")
auth = token
response = bsecure.get('https://api.example.com/user/profile', auth=auth)

# Token prefix (custom token type)
auth = 'Token abc123def456'
response = bsecure.get('https://api.example.com/data', auth=auth)
```

### 🔧 Custom Authentication Headers

Use dictionary format for complex authentication schemes:

```python
# API Key in custom header
auth = {
    'X-API-Key': 'your_api_key_here',
    'X-Client-ID': 'mobile_app_v2'
}
response = bsecure.get('https://api.example.com/data', auth=auth)

# Multiple authentication headers
auth = {
    'Authorization': 'Custom scheme token_value',
    'X-API-Key': 'api_key_123',
    'X-Request-Signature': 'hmac_sha256_signature'
}
response = bsecure.post('https://api.example.com/secure', json=data, auth=auth)
```

### 🔄 Session Authentication

Set authentication once, use everywhere:

```python
session = bsecure.Session()

# Basic auth
session.auth = ('user@example.com', 'password123')

# Bearer token
session.auth = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'

# Custom headers
session.auth = {'X-API-Key': 'key123', 'X-Client-ID': 'web'}

# All requests now include authentication
response = session.get('https://api.example.com/profile')
response = session.post('https://api.example.com/data', json={...})
```

### 💡 Authentication Workflow Examples

#### Example 1: OAuth2 Bearer Token Flow

```python
import bsecure

# Step 1: Get access token
token_response = bsecure.post(
    'https://auth.example.com/oauth/token',
    data={
        'grant_type': 'password',
        'username': 'user@example.com',
        'password': 'secure_pass',
        'client_id': 'my_app',
        'client_secret': 'app_secret'
    }
)

token_data = token_response.json()
access_token = token_data['access_token']

# Step 2: Create session with token
session = bsecure.Session()
session.auth = f'Bearer {access_token}'

# Step 3: Make authenticated requests
profile = session.get('https://api.example.com/user/profile').json()
print(f"Logged in as: {profile['name']}")

# Step 4: Refresh token when expired
if token_data.get('expires_in'):
    refresh_token = token_data['refresh_token']
    # ... refresh logic here
```

#### Example 2: API Key Authentication

```python
import bsecure

# Create session with API key
session = bsecure.Session()
session.auth = {'X-API-Key': 'your_api_key_here'}

# All requests include API key
users = session.get('https://api.example.com/users').json()
print(f"Total users: {len(users)}")

# Create new resource
new_user = session.post(
    'https://api.example.com/users',
    json={'name': 'Bob', 'email': 'bob@example.com'}
).json()
print(f"Created user: {new_user['id']}")
```

#### Example 3: Basic Auth with Sensitive Data

```python
import bsecure
import os

# Load credentials from environment variables
username = os.getenv('API_USERNAME')
password = os.getenv('API_PASSWORD')

# Use basic authentication
session = bsecure.Session()
session.auth = (username, password)
session.timeout = 10.0

try:
    # Access protected resource
    response = session.get('https://api.example.com/admin/stats')
    response.raise_for_status()
    
    stats = response.json()
    print(f"📊 Stats: {stats}")
except Exception as e:
    print(f"❌ Authentication failed: {e}")
```

#### Example 4: Multi-Step Authentication

```python
import bsecure

# Step 1: Login to get session cookie
session = bsecure.Session()
login_response = session.post(
    'https://example.com/api/login',
    json={'username': 'admin', 'password': 'admin123'}
)

# Step 2: Extract token from response
auth_token = login_response.json()['token']

# Step 3: Set token for subsequent requests
session.auth = f'Bearer {auth_token}'

# Step 4: Make authenticated request
dashboard_data = session.get('https://example.com/api/dashboard').json()
print(f"Dashboard: {dashboard_data}")

# Session maintains both cookies and auth headers
```

### 🎯 Authentication Method Reference

| Method | Format | Example | Use Case |
|--------|--------|---------|----------|
| **Basic Auth** | `tuple` | `('user', 'pass')` | Traditional username/password |
| **Bearer Token** | `str` | `'Bearer token123'` | JWT, OAuth2 tokens |
| **Token Auth** | `str` | `'Token abc123'` | Custom token schemes |
| **API Key** | `dict` | `{'X-API-Key': 'key'}` | API key in headers |
| **Custom** | `dict` | `{'Header': 'value'}` | Complex auth schemes |

### 🔒 Security Best Practices

```python
import bsecure
import os

# ✅ DO: Use environment variables
api_key = os.getenv('API_KEY')
session = bsecure.Session()
session.auth = {'X-API-Key': api_key}

# ✅ DO: Use HTTPS for authentication
response = session.get('https://api.example.com/secure')  # ✓

# ❌ DON'T: Hard-code credentials
# session.auth = ('user', 'password123')  # ✗

# ❌ DON'T: Send credentials over HTTP
# response = session.get('http://api.example.com/data')  # ✗

# ✅ DO: Handle auth errors gracefully
try:
    response = session.get('https://api.example.com/protected')
    response.raise_for_status()
except bsecure.RequestError as e:
    print(f"Authentication failed: {e}")
```

---

## 📤 File Uploads

BSecure makes file uploads simple with support for multiple formats and configurations.

### 📋 Upload Formats

#### Dictionary Format (Recommended)

```python
files = {
    'field_name': ('filename', file_data_or_path)
}
```

#### List Format

```python
files = [
    ('field_name', 'filename', file_data_or_path)
]
```

### 📁 Upload from File Content

Read file and upload as bytes:

```python
# Single file upload
with open('document.pdf', 'rb') as f:
    file_data = f.read()

files = {
    'document': ('report.pdf', file_data)
}
response = bsecure.post('https://example.com/upload', files=files)

print(f"Upload status: {response.status_code}")
print(f"Response: {response.json()}")
```

### 📂 Upload from File Path

Provide file path directly:

```python
# BSecure will read the file
files = {
    'document': ('report.pdf', '/path/to/report.pdf')
}
response = bsecure.post('https://example.com/upload', files=files)
```

### 📦 Multiple File Upload

Upload several files in one request:

```python
# Multiple files with different types
files = {
    'document': ('report.pdf', open('report.pdf', 'rb').read()),
    'image': ('screenshot.png', open('screenshot.png', 'rb').read()),
    'video': ('demo.mp4', '/path/to/demo.mp4')
}
response = bsecure.post('https://example.com/upload', files=files)

# Check upload results
if response.status_code == 200:
    result = response.json()
    print(f"✅ Uploaded {len(result['files'])} files successfully")
```

### 📋 Upload with Additional Form Data

Combine file uploads with form parameters:

```python
# Files + metadata
files = {
    'document': ('quarterly_report.pdf', open('Q3_report.pdf', 'rb').read())
}
params = {
    'title': 'Q3 Financial Report',
    'category': 'finance',
    'department': 'accounting',
    'year': '2024'
}

response = bsecure.post(
    'https://example.com/api/documents',
    files=files,
    params=params
)

print(f"Document ID: {response.json()['id']}")
```

### 🎨 Advanced Upload Examples

#### Example 1: Profile Picture Upload

```python
import bsecure

def upload_profile_picture(user_id, image_path):
    # Read image file
    with open(image_path, 'rb') as f:
        image_data = f.read()
    
    # Prepare upload
    files = {
        'avatar': (os.path.basename(image_path), image_data)
    }
    
    # Upload to server
    response = bsecure.post(
        f'https://api.example.com/users/{user_id}/avatar',
        files=files
    )
    
    if response.status_code == 200:
        result = response.json()
        print(f"✅ Profile picture updated!")
        print(f"   URL: {result['avatar_url']}")
        return result['avatar_url']
    else:
        print(f"❌ Upload failed: {response.status_code}")
        return None

# Usage
avatar_url = upload_profile_picture(123, 'profile.jpg')
```

#### Example 2: Batch File Upload with Progress

```python
import bsecure
import os

def upload_multiple_documents(folder_path):
    session = bsecure.Session()
    session.timeout = 60.0  # Longer timeout for large files
    
    uploaded_files = []
    
    # Get all PDF files from folder
    pdf_files = [f for f in os.listdir(folder_path) if f.endswith('.pdf')]
    
    for i, filename in enumerate(pdf_files, 1):
        file_path = os.path.join(folder_path, filename)
        
        print(f"📤 Uploading {i}/{len(pdf_files)}: {filename}")
        
        with open(file_path, 'rb') as f:
            files = {'document': (filename, f.read())}
            
            response = session.post(
                'https://api.example.com/documents',
                files=files,
                params={'category': 'reports'}
            )
            
            if response.status_code == 201:
                doc_id = response.json()['id']
                uploaded_files.append({'filename': filename, 'id': doc_id})
                print(f"   ✅ Uploaded successfully (ID: {doc_id})")
            else:
                print(f"   ❌ Failed: {response.status_code}")
    
    print(f"\n📊 Summary: {len(uploaded_files)}/{len(pdf_files)} files uploaded")
    return uploaded_files

# Usage
results = upload_multiple_documents('./reports')
```

#### Example 3: Upload with Authentication

```python
import bsecure

# Create authenticated session
session = bsecure.Session()
session.auth = 'Bearer your_access_token_here'
session.headers = {'X-Client-ID': 'web_app'}

# Upload file
with open('contract.pdf', 'rb') as f:
    files = {'contract': ('signed_contract.pdf', f.read())}
    
    response = session.post(
        'https://api.example.com/legal/contracts',
        files=files,
        params={
            'contract_type': 'NDA',
            'party_a': 'Company Inc.',
            'party_b': 'Client Corp.'
        }
    )

if response.status_code == 201:
    contract = response.json()
    print(f"✅ Contract uploaded!")
    print(f"   ID: {contract['id']}")
    print(f"   Status: {contract['status']}")
    print(f"   URL: {contract['download_url']}")
```

#### Example 4: Image Upload with Validation

```python
import bsecure
import os

def upload_image(image_path, max_size_mb=5):
    # Validate file exists
    if not os.path.exists(image_path):
        print(f"❌ File not found: {image_path}")
        return None
    
    # Check file size
    file_size = os.path.getsize(image_path)
    file_size_mb = file_size / (1024 * 1024)
    
    if file_size_mb > max_size_mb:
        print(f"❌ File too large: {file_size_mb:.2f}MB (max {max_size_mb}MB)")
        return None
    
    # Validate image extension
    valid_extensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp']
    file_ext = os.path.splitext(image_path)[1].lower()
    
    if file_ext not in valid_extensions:
        print(f"❌ Invalid file type: {file_ext}")
        return None
    
    # Upload image
    print(f"📤 Uploading {os.path.basename(image_path)} ({file_size_mb:.2f}MB)...")
    
    with open(image_path, 'rb') as f:
        files = {'image': (os.path.basename(image_path), f.read())}
        
        response = bsecure.post(
            'https://api.example.com/images/upload',
            files=files,
            timeout=30.0
        )
    
    if response.status_code == 200:
        result = response.json()
        print(f"✅ Upload successful!")
        print(f"   Image URL: {result['url']}")
        print(f"   Thumbnail: {result['thumbnail_url']}")
        return result
    else:
        print(f"❌ Upload failed: {response.text}")
        return None

# Usage
result = upload_image('vacation_photo.jpg', max_size_mb=10)
```

#### Example 5: Resume Upload to Job Portal

```python
import bsecure

def submit_job_application(applicant_info, resume_path):
    session = bsecure.Session()
    session.timeout = 30.0
    
    # Read resume file
    with open(resume_path, 'rb') as f:
        resume_data = f.read()
    
    # Prepare multipart upload
    files = {
        'resume': (os.path.basename(resume_path), resume_data)
    }
    
    # Application form data
    params = {
        'first_name': applicant_info['first_name'],
        'last_name': applicant_info['last_name'],
        'email': applicant_info['email'],
        'phone': applicant_info['phone'],
        'position': applicant_info['position'],
        'experience_years': applicant_info['experience_years']
    }
    
    # Submit application
    print(f"📋 Submitting application for {applicant_info['position']}...")
    
    response = session.post(
        'https://careers.example.com/api/applications',
        files=files,
        params=params
    )
    
    if response.status_code == 201:
        application = response.json()
        print(f"✅ Application submitted successfully!")
        print(f"   Application ID: {application['id']}")
        print(f"   Status: {application['status']}")
        print(f"   Reference: {application['reference_number']}")
        return application
    else:
        print(f"❌ Submission failed: {response.status_code}")
        return None

# Usage
applicant = {
    'first_name': 'John',
    'last_name': 'Doe',
    'email': 'john.doe@email.com',
    'phone': '+1-555-0123',
    'position': 'Senior Python Developer',
    'experience_years': 5
}

application = submit_job_application(applicant, 'john_doe_resume.pdf')
```

### 🎯 File Upload Reference

| Format | Syntax | Example |
|--------|--------|---------|
| **Dict with bytes** | `{field: (name, bytes)}` | `{'file': ('doc.pdf', data)}` |
| **Dict with path** | `{field: (name, path)}` | `{'file': ('doc.pdf', '/path')}` |
| **List format** | `[(field, name, data)]` | `[('file', 'doc.pdf', data)]` |

### 💡 Upload Best Practices

```python
# ✅ DO: Use context managers for file handling
with open('file.pdf', 'rb') as f:
    files = {'document': ('file.pdf', f.read())}
    response = bsecure.post(url, files=files)

# ✅ DO: Set appropriate timeout for large files
response = bsecure.post(
    url,
    files=files,
    timeout=60.0  # Longer timeout for large uploads
)

# ✅ DO: Validate file before uploading
import os
if os.path.exists(file_path) and os.path.getsize(file_path) < 10_000_000:
    # Upload file
    pass

# ✅ DO: Handle upload errors gracefully
try:
    response = bsecure.post(url, files=files)
    response.raise_for_status()
    print("Upload successful!")
except Exception as e:
    print(f"Upload failed: {e}")
```

---

## ⚡ Advanced Features

Unlock BSecure's full potential with these advanced capabilities.

### 🔁 Automatic Retry Logic

BSecure automatically retries failed requests with configurable behavior:

```python
# Configure retry settings
response = bsecure.get(
    'https://unstable-api.example.com/data',
    max_retries=10,      # Maximum retry attempts (default: 5)
    retry_delay=2.0      # Seconds between retries (default: 1.0)
)

# Session-level retry configuration
session = bsecure.Session()
session.max_retries = 7
session.retry_delay = 1.5

# All session requests use these settings
response = session.get('https://api.example.com/data')
```

**Retry Behavior:**
- ✅ Retries on: Network errors, timeouts, 5xx server errors, 429 rate limits
- ❌ No retry on: SSL/TLS errors, authentication errors, 4xx client errors

### ↪️ Redirect Handling

Control how BSecure follows HTTP redirects:

```python
# Follow redirects (default behavior)
response = bsecure.get(
    'https://example.com/redirect',
    allow_redirects=True,
    max_redirects=10  # Maximum redirects to follow (default: 30)
)
print(f"Final URL: {response.url}")

# Don't follow redirects
response = bsecure.get(
    'https://example.com/redirect',
    allow_redirects=False
)
print(f"Status: {response.status_code}")  # 301, 302, etc.
print(f"Location: {response.headers.get('Location')}")

# Session-level redirect control
session = bsecure.Session()
session.allow_redirects = True
session.max_redirects = 5
```

### 🗜️ Automatic Decompression

BSecure automatically handles compressed responses:

```python
# Supported encodings: gzip, deflate, br (Brotli), zstd
response = bsecure.get('https://api.example.com/compressed-data')

# Content is automatically decompressed
print(response.text)  # Decompressed text
print(response.content)  # Decompressed bytes

# Headers show original encoding
print(response.headers.get('Content-Encoding'))  # 'gzip', 'br', etc.
```

**Supported Compression:**
- ✅ gzip
- ✅ deflate
- ✅ Brotli (br)
- ✅ Zstandard (zstd)

### 🌐 Proxy Configuration

Route requests through HTTP/HTTPS proxies:

```python
# Per-request proxy
proxies = {
    'http': 'http://proxy.example.com:8080',
    'https': 'http://proxy.example.com:8080'
}
response = bsecure.get('https://api.example.com', proxies=proxies)

# Proxy with authentication
proxies = {
    'http': 'http://user:pass@proxy.example.com:8080',
    'https': 'http://user:pass@proxy.example.com:8080'
}

# Session-level proxy
session = bsecure.Session()
session.proxies = proxies

# All requests go through proxy
response = session.get('https://api.example.com/data')
```

### ⏱️ Timeout Configuration

Fine-tune request timeouts:

```python
# Per-request timeout (seconds)
response = bsecure.get('https://api.example.com', timeout=5.0)

# Different timeouts for different operations
quick_data = bsecure.get('https://api.example.com/quick', timeout=2.0)
heavy_process = bsecure.post('https://api.example.com/process', 
                              json=data, timeout=60.0)

# Session-level timeout
session = bsecure.Session()
session.timeout = 30.0  # All requests timeout after 30 seconds
```

### 🔒 SSL/TLS Verification

Control certificate verification:

```python
# Verify SSL certificates (default, recommended)
response = bsecure.get('https://secure-api.example.com', verify=True)

# Disable verification (use with caution!)
response = bsecure.get('https://self-signed.local', verify=False)

# Session-level SSL verification
session = bsecure.Session()
session.verify = True  # Default
```

### 🎛️ Custom Headers Management

Advanced header configuration:

```python
session = bsecure.Session()

# Set default headers for all requests
session.headers = {
    'User-Agent': 'MyApp/3.0',
    'Accept': 'application/json',
    'Accept-Language': 'en-US',
    'X-Client-Version': '3.0.1'
}

# Override specific header for one request
response = session.get(
    'https://api.example.com/data',
    headers={'User-Agent': 'SpecialBot/1.0'}
)
# Other session headers still sent, User-Agent is overridden

# Add header without overriding session headers
custom_headers = session.headers.copy()
custom_headers['X-Request-ID'] = 'req-123-456'
response = session.get('https://api.example.com', headers=custom_headers)
```

### 🔄 Complete Workflow Example

```python
import bsecure

# Create a production-ready session
session = bsecure.Session()

# Configure session
session.headers = {
    'User-Agent': 'ProductionApp/2.0',
    'Accept': 'application/json'
}
session.timeout = 30.0
session.max_retries = 5
session.retry_delay = 2.0
session.allow_redirects = True
session.max_redirects = 10
session.verify = True

# Optional: Configure proxy
# session.proxies = {'https': 'http://proxy.company.com:8080'}

# Step 1: Authenticate
print("🔐 Authenticating...")
auth_response = session.post(
    'https://api.example.com/auth/login',
    json={
        'email': 'user@example.com',
        'password': 'secure_password'
    },
    timeout=10.0
)

if auth_response.status_code != 200:
    print(f"❌ Authentication failed: {auth_response.status_code}")
    exit(1)

# Extract token
token = auth_response.json()['access_token']
session.auth = f'Bearer {token}'
print("✅ Authenticated successfully")

# Step 2: Fetch data with retries
print("\n📊 Fetching user data...")
try:
    user_response = session.get(
        'https://api.example.com/user/profile',
        max_retries=3,
        retry_delay=1.0
    )
    user_response.raise_for_status()
    user = user_response.json()
    print(f"✅ User: {user['name']} ({user['email']})")
except Exception as e:
    print(f"❌ Failed to fetch user: {e}")

# Step 3: Upload file with authentication
print("\n📤 Uploading document...")
with open('report.pdf', 'rb') as f:
    files = {'document': ('quarterly_report.pdf', f.read())}
    
    upload_response = session.post(
        'https://api.example.com/documents',
        files=files,
        params={'category': 'reports', 'quarter': 'Q3'},
        timeout=60.0  # Longer timeout for upload
    )
    
    if upload_response.status_code == 201:
        doc = upload_response.json()
        print(f"✅ Document uploaded (ID: {doc['id']})")

# Step 4: Batch operations with retry logic
print("\n🔄 Fetching multiple resources...")
resource_ids = [101, 102, 103, 104, 105]

for res_id in resource_ids:
    try:
        response = session.get(
            f'https://api.example.com/resources/{res_id}',
            max_retries=3,
            timeout=15.0
        )
        response.raise_for_status()
        resource = response.json()
        print(f"  ✓ Resource {res_id}: {resource['name']}")
    except Exception as e:
        print(f"  ✗ Resource {res_id}: {e}")

# Step 5: Logout
print("\n👋 Logging out...")
logout_response = session.post('https://api.example.com/auth/logout')
print(f"✅ Logged out ({logout_response.status_code})")
```

### 🎯 Advanced Features Reference

| Feature | Configuration | Description |
|---------|--------------|-------------|
| **Retries** | `max_retries`, `retry_delay` | Automatic retry on failures |
| **Redirects** | `allow_redirects`, `max_redirects` | HTTP redirect handling |
| **Compression** | Automatic | gzip, deflate, br, zstd support |
| **Proxies** | `proxies` | HTTP/HTTPS proxy support |
| **Timeout** | `timeout` | Request timeout in seconds |
| **SSL** | `verify` | Certificate verification |
| **Headers** | `headers` | Custom HTTP headers |

---

## 🛡️ Error Handling

BSecure provides detailed exception types for precise error handling.

### 🎯 Exception Hierarchy

```
BSecureError (Base exception)
├── SSLError              # SSL/TLS certificate errors
├── TimeoutError          # Request timeout errors
├── RedirectError         # Too many redirects
├── ConnectionError       # Network connection failures
├── ProxyError           # Proxy-related errors
└── RequestError         # General request errors
```

### 📝 Exception Types

#### 🔐 SSLError

Raised for SSL/TLS certificate validation failures:

```python
import bsecure

try:
    response = bsecure.get('https://self-signed.example.com')
except bsecure.SSLError as e:
    print(f"🔒 SSL Error: {e}")
    # Handle SSL error (e.g., use verify=False for development)
```

#### ⏰ TimeoutError

Raised when requests exceed timeout:

```python
try:
    response = bsecure.get('https://slow-api.example.com', timeout=5.0)
except bsecure.TimeoutError as e:
    print(f"⏰ Timeout: {e}")
    # Handle timeout (e.g., retry with longer timeout)
```

#### ↪️ RedirectError

Raised when redirect limit is exceeded:

```python
try:
    response = bsecure.get(
        'https://example.com/infinite-redirect',
        max_redirects=10
    )
except bsecure.RedirectError as e:
    print(f"↪️ Too many redirects: {e}")
```

#### 🌐 ConnectionError

Raised for network connection failures:

```python
try:
    response = bsecure.get('https://unreachable-server.example.com')
except bsecure.ConnectionError as e:
    print(f"🌐 Connection failed: {e}")
    # Handle connection error (check network, DNS, etc.)
```

#### 🔌 ProxyError

Raised for proxy-related issues:

```python
try:
    response = bsecure.get(
        'https://example.com',
        proxies={'https': 'http://invalid-proxy.com:8080'}
    )
except bsecure.ProxyError as e:
    print(f"🔌 Proxy error: {e}")
```

#### ⚠️ RequestError

General request failures:

```python
try:
    response = bsecure.get('https://api.example.com/data')
except bsecure.RequestError as e:
    print(f"⚠️ Request failed: {e}")
```

### 🎨 Error Handling Patterns

#### Pattern 1: Specific Exception Handling

```python
import bsecure

def fetch_data(url):
    try:
        response = bsecure.get(url, timeout=10.0)
        response.raise_for_status()
        return response.json()
    
    except bsecure.TimeoutError:
        print("⏰ Request timed out. Retrying with longer timeout...")
        response = bsecure.get(url, timeout=30.0)
        return response.json()
    
    except bsecure.SSLError as e:
        print(f"🔒 SSL verification failed: {e}")
        print("⚠️ Using unverified connection (NOT recommended for production)")
        response = bsecure.get(url, verify=False)
        return response.json()
    
    except bsecure.ConnectionError:
        print("🌐 Network connection failed. Check your internet connection.")
        return None
    
    except bsecure.RequestError as e:
        print(f"⚠️ Request failed: {e}")
        return None

# Usage
data = fetch_data('https://api.example.com/data')
```

#### Pattern 2: Catch-All with Logging

```python
import bsecure
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def api_call(url, method='GET', **kwargs):
    try:
        if method == 'GET':
            response = bsecure.get(url, **kwargs)
        elif method == 'POST':
            response = bsecure.post(url, **kwargs)
        
        response.raise_for_status()
        return response.json()
    
    except bsecure.BSecureError as e:
        logger.error(f"API call failed: {type(e).__name__}: {e}")
        raise
    
    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        raise

# Usage
try:
    data = api_call('https://api.example.com/users', method='GET')
except bsecure.BSecureError:
    # Handle BSecure-specific errors
    pass
```

#### Pattern 3: Retry with Exponential Backoff

```python
import bsecure
import time

def fetch_with_retry(url, max_attempts=5):
    for attempt in range(1, max_attempts + 1):
        try:
            response = bsecure.get(url, timeout=10.0)
            response.raise_for_status()
            return response.json()
        
        except bsecure.TimeoutError:
            wait_time = 2 ** attempt  # Exponential backoff
            print(f"⏰ Timeout on attempt {attempt}. Retrying in {wait_time}s...")
            time.sleep(wait_time)
        
        except bsecure.ConnectionError:
            wait_time = 2 ** attempt
            print(f"🌐 Connection failed on attempt {attempt}. Retrying in {wait_time}s...")
            time.sleep(wait_time)
        
        except bsecure.BSecureError as e:
            print(f"❌ Request failed: {e}")
            return None
    
    print(f"❌ Failed after {max_attempts} attempts")
    return None

# Usage
data = fetch_with_retry('https://api.example.com/data')
```

#### Pattern 4: Status Code Checking

```python
import bsecure

def safe_api_call(url, **kwargs):
    try:
        response = bsecure.get(url, **kwargs)
        
        # Check status code
        if response.status_code == 200:
            return {'success': True, 'data': response.json()}
        
        elif response.status_code == 404:
            return {'success': False, 'error': 'Resource not found'}
        
        elif response.status_code == 401:
            return {'success': False, 'error': 'Unauthorized'}
        
        elif response.status_code == 429:
            retry_after = response.headers.get('Retry-After', 60)
            return {'success': False, 'error': f'Rate limited. Retry after {retry_after}s'}
        
        elif response.status_code >= 500:
            return {'success': False, 'error': 'Server error'}
        
        else:
            return {'success': False, 'error': f'Unexpected status: {response.status_code}'}
    
    except bsecure.BSecureError as e:
        return {'success': False, 'error': str(e)}

# Usage
result = safe_api_call('https://api.example.com/users/123')
if result['success']:
    print(f"Data: {result['data']}")
else:
    print(f"Error: {result['error']}")
```

### 🎯 Error Handling Best Practices

```python
import bsecure

# ✅ DO: Handle specific exceptions
try:
    response = bsecure.get(url)
except bsecure.TimeoutError:
    # Handle timeout
    pass
except bsecure.ConnectionError:
    # Handle connection error
    pass

# ✅ DO: Use raise_for_status() for quick error detection
response = bsecure.get(url)
response.raise_for_status()  # Raises exception if status >= 400

# ✅ DO: Log errors for debugging
import logging
try:
    response = bsecure.get(url)
except bsecure.BSecureError as e:
    logging.error(f"Request failed: {e}")

# ✅ DO: Provide fallback behavior
try:
    data = bsecure.get(url).json()
except bsecure.BSecureError:
    data = get_cached_data()  # Use cached data as fallback

# ❌ DON'T: Catch and ignore all exceptions
try:
    response = bsecure.get(url)
except:  # Too broad!
    pass

# ❌ DON'T: Use bare except with BSecure errors
try:
    response = bsecure.get(url)
except Exception:  # Catches everything, not recommended
    pass
```

### 📊 Exception Reference Table

| Exception | Trigger | Common Causes |
|-----------|---------|---------------|
| `SSLError` | SSL/TLS validation fails | Self-signed cert, expired cert, hostname mismatch |
| `TimeoutError` | Request exceeds timeout | Slow server, network latency, large response |
| `RedirectError` | Too many redirects | Redirect loop, misconfigured server |
| `ConnectionError` | Can't connect to server | DNS failure, server down, network issue |
| `ProxyError` | Proxy configuration issue | Invalid proxy, auth failure, proxy unreachable |
| `RequestError` | General request failure | Invalid URL, JSON parse error, other errors |

---

## 🔧 Utilities

BSecure provides powerful utility functions for common tasks.

### 📦 JSON Utilities

Built-in JSON serialization and deserialization:

#### `json_dumps()` - Serialize to JSON

```python
import bsecure

# Simple object
data = {'name': 'Alice', 'age': 30, 'active': True}
json_string = bsecure.json_dumps(data)
print(json_string)
# Output: '{"name":"Alice","age":30,"active":true}'

# Complex nested object
user = {
    'id': 12345,
    'profile': {
        'name': 'John Doe',
        'email': 'john@example.com',
        'preferences': {
            'theme': 'dark',
            'notifications': True
        }
    },
    'posts': [
        {'id': 1, 'title': 'First Post'},
        {'id': 2, 'title': 'Second Post'}
    ],
    'score': 98.5
}

json_str = bsecure.json_dumps(user)
print(json_str)
```

#### `json_loads()` - Deserialize from JSON

```python
import bsecure

# Parse JSON string
json_string = '{"name":"Bob","age":25,"city":"NYC"}'
data = bsecure.json_loads(json_string)
print(data)
# Output: {'name': 'Bob', 'age': 25, 'city': 'NYC'}

# Access parsed data
print(f"Name: {data['name']}")
print(f"Age: {data['age']}")

# Parse complex JSON
json_response = '''
{
    "status": "success",
    "data": {
        "users": [
            {"id": 1, "name": "Alice"},
            {"id": 2, "name": "Bob"}
        ],
        "total": 2
    }
}
'''

result = bsecure.json_loads(json_response)
print(f"Status: {result['status']}")
print(f"Total users: {result['data']['total']}")
for user in result['data']['users']:
    print(f"  - {user['name']}")
```

### 💡 Utility Examples

#### Example 1: API Response Processing

```python
import bsecure

# Fetch and process JSON response
response = bsecure.get('https://api.example.com/users')

# Parse using response.json()
users = response.json()

# Or parse manually using json_loads
text_response = response.text
users = bsecure.json_loads(text_response)

# Process data
for user in users:
    print(f"{user['id']}: {user['name']}")
```

#### Example 2: Data Transformation Pipeline

```python
import bsecure

def transform_and_send(data):
    # Step 1: Transform data
    transformed = {
        'timestamp': '2024-01-01T00:00:00Z',
        'source': 'python_client',
        'payload': data
    }
    
    # Step 2: Serialize to JSON
    json_payload = bsecure.json_dumps(transformed)
    print(f"Sending: {json_payload}")
    
    # Step 3: Send to API
    response = bsecure.post(
        'https://api.example.com/events',
        data=json_payload,
        headers={'Content-Type': 'application/json'}
    )
    
    # Step 4: Parse response
    if response.status_code == 200:
        result = bsecure.json_loads(response.text)
        return result
    
    return None

# Usage
event_data = {'event': 'user_login', 'user_id': 12345}
result = transform_and_send(event_data)
```

#### Example 3: Configuration File Processing

```python
import bsecure

def load_api_config(json_string):
    """Parse JSON configuration"""
    config = bsecure.json_loads(json_string)
    
    # Create configured session
    session = bsecure.Session()
    session.headers = config.get('headers', {})
    session.timeout = config.get('timeout', 30.0)
    session.max_retries = config.get('max_retries', 5)
    
    if 'auth' in config:
        session.auth = tuple(config['auth']) if isinstance(config['auth'], list) else config['auth']
    
    if 'proxies' in config:
        session.proxies = config['proxies']
    
    return session

# JSON configuration
config_json = '''
{
    "headers": {
        "User-Agent": "MyApp/2.0",
        "Accept": "application/json"
    },
    "timeout": 15.0,
    "max_retries": 3,
    "auth": ["username", "password"],
    "proxies": {
        "https": "http://proxy.example.com:8080"
    }
}
'''

# Load and use configuration
session = load_api_config(config_json)
response = session.get('https://api.example.com/data')
```

### 🎯 Utility Functions Reference

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `json_dumps(obj)` | Python object | JSON string | Serialize object to JSON |
| `json_loads(str)` | JSON string | Python object | Deserialize JSON to object |

### 💡 Utility Best Practices

```python
import bsecure

# ✅ DO: Use for custom JSON processing
data = {'key': 'value'}
json_str = bsecure.json_dumps(data)

# ✅ DO: Use response.json() for simple cases
response = bsecure.get(url)
data = response.json()  # Built-in method

# ✅ DO: Handle JSON errors
try:
    data = bsecure.json_loads(json_string)
except ValueError as e:
    print(f"Invalid JSON: {e}")

# ✅ DO: Use for data transformation
original = bsecure.json_loads(input_json)
processed = transform(original)
output = bsecure.json_dumps(processed)
```

---

## 💡 Best Practices

Follow these guidelines to write robust, efficient code with BSecure.

### 1️⃣ Use Sessions for Multiple Requests

**Why:** Sessions reuse TCP connections, significantly improving performance.

```python
# ✅ GOOD: Use session for multiple requests
session = bsecure.Session()
session.headers = {'User-Agent': 'MyApp/1.0'}

for endpoint in ['/users', '/posts', '/comments']:
    response = session.get(f'https://api.example.com{endpoint}')
    print(response.json())

# ❌ BAD: Create new connection each time
for endpoint in ['/users', '/posts', '/comments']:
    response = bsecure.get(f'https://api.example.com{endpoint}')
    print(response.json())
```

### 2️⃣ Set Appropriate Timeouts

**Why:** Prevent hanging requests and improve responsiveness.

```python
# ✅ GOOD: Set reasonable timeout
response = bsecure.get('https://api.example.com/data', timeout=10.0)

# ✅ GOOD: Different timeouts for different operations
quick = bsecure.get('https://api.example.com/status', timeout=2.0)
upload = bsecure.post('https://api.example.com/upload', 
                      files=files, timeout=60.0)

# ❌ BAD: No timeout (can hang forever)
response = bsecure.get('https://api.example.com/data')
```

### 3️⃣ Handle Errors Gracefully

**Why:** Robust error handling prevents crashes and provides better UX.

```python
# ✅ GOOD: Specific error handling
try:
    response = bsecure.get(url, timeout=10.0)
    response.raise_for_status()
    data = response.json()
except bsecure.TimeoutError:
    print("Request timed out")
    data = get_cached_data()
except bsecure.ConnectionError:
    print("Connection failed")
    data = None
except bsecure.BSecureError as e:
    print(f"Request error: {e}")
    data = None

# ❌ BAD: Ignore errors
try:
    response = bsecure.get(url)
    data = response.json()
except:
    pass  # Silent failure
```

### 4️⃣ Use Context Managers for Files

**Why:** Ensures files are properly closed, preventing resource leaks.

```python
# ✅ GOOD: Context manager automatically closes file
with open('document.pdf', 'rb') as f:
    files = {'document': ('report.pdf', f.read())}
    response = bsecure.post(url, files=files)

# ❌ BAD: File might not be closed properly
f = open('document.pdf', 'rb')
files = {'document': ('report.pdf', f.read())}
response = bsecure.post(url, files=files)
f.close()  # Might not execute if error occurs
```

### 5️⃣ Validate Input Data

**Why:** Catch errors early and provide better debugging information.

```python
# ✅ GOOD: Validate before sending
import os

def upload_file(file_path):
    # Validate file exists
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"File not found: {file_path}")
    
    # Validate file size
    file_size = os.path.getsize(file_path)
    max_size = 10 * 1024 * 1024  # 10MB
    if file_size > max_size:
        raise ValueError(f"File too large: {file_size} bytes")
    
    # Upload file
    with open(file_path, 'rb') as f:
        files = {'file': (os.path.basename(file_path), f.read())}
        response = bsecure.post(upload_url, files=files)
    
    return response.json()

# ❌ BAD: No validation
def upload_file(file_path):
    with open(file_path, 'rb') as f:  # Crashes if file doesn't exist
        files = {'file': ('file', f.read())}
        return bsecure.post(upload_url, files=files).json()
```

### 6️⃣ Use Retry Logic for Unreliable Networks

**Why:** Increases success rate in unstable network conditions.

```python
# ✅ GOOD: Configure retries
session = bsecure.Session()
session.max_retries = 5
session.retry_delay = 2.0

response = session.get('https://unstable-api.example.com')

# ✅ GOOD: Per-request retry override
response = bsecure.get(
    'https://api.example.com/critical-data',
    max_retries=10,
    retry_delay=3.0
)

# ❌ BAD: No retry mechanism
response = bsecure.get('https://unstable-api.example.com')
```

### 7️⃣ Keep Secrets Secure

**Why:** Protect sensitive information from exposure.

```python
import os
import bsecure

# ✅ GOOD: Use environment variables
api_key = os.getenv('API_KEY')
session = bsecure.Session()
session.auth = {'X-API-Key': api_key}

# ✅ GOOD: Load from secure config
import json
with open('/secure/config.json') as f:
    config = json.load(f)
    session.auth = (config['username'], config['password'])

# ❌ BAD: Hard-coded credentials
session.auth = ('admin', 'password123')  # Don't do this!

# ❌ BAD: Credentials in code
api_key = 'sk-1234567890abcdef'  # Don't do this!
```

### 8️⃣ Log Important Events

**Why:** Aids debugging and monitoring in production.

```python
import bsecure
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# ✅ GOOD: Log important events
def fetch_user(user_id):
    logger.info(f"Fetching user {user_id}")
    
    try:
        response = bsecure.get(f'https://api.example.com/users/{user_id}')
        response.raise_for_status()
        logger.info(f"Successfully fetched user {user_id}")
        return response.json()
    except bsecure.BSecureError as e:
        logger.error(f"Failed to fetch user {user_id}: {e}")
        raise

# ❌ BAD: No logging
def fetch_user(user_id):
    response = bsecure.get(f'https://api.example.com/users/{user_id}')
    return response.json()
```

### 9️⃣ Use Type Hints (Python 3.6+)

**Why:** Improves code readability and enables better IDE support.

```python
import bsecure
from typing import Optional, Dict, Any

# ✅ GOOD: Type hints for clarity
def api_call(
    endpoint: str,
    method: str = 'GET',
    data: Optional[Dict[str, Any]] = None,
    timeout: float = 10.0
) -> Dict[str, Any]:
    """Make API call and return JSON response."""
    session = bsecure.Session()
    session.timeout = timeout
    
    if method == 'GET':
        response = session.get(endpoint)
    elif method == 'POST':
        response = session.post(endpoint, json=data)
    else:
        raise ValueError(f"Unsupported method: {method}")
    
    response.raise_for_status()
    return response.json()
```

### 🔟 Monitor Request Performance

**Why:** Identify slow endpoints and optimize performance.

```python
import bsecure
import time

# ✅ GOOD: Track request duration
def monitored_request(url):
    start = time.time()
    
    response = bsecure.get(url)
    
    duration = time.time() - start
    print(f"Request to {url} took {duration:.3f}s")
    
    # Use response.elapsed for server processing time
    print(f"Server processing time: {response.elapsed:.3f}s")
    
    if duration > 5.0:
        print(f"⚠️ WARNING: Slow request detected!")
    
    return response.json()
```

### 📊 Best Practices Summary

| Practice | Why | Example |
|----------|-----|---------|
| Use Sessions | Reuse connections | `session = bsecure.Session()` |
| Set Timeouts | Prevent hanging | `timeout=10.0` |
| Handle Errors | Robust code | `try/except bsecure.BSecureError` |
| Close Files | Resource management | `with open(...) as f:` |
| Validate Input | Early error detection | Check file exists before upload |
| Configure Retries | Handle failures | `max_retries=5` |
| Secure Secrets | Protect credentials | `os.getenv('API_KEY')` |
| Log Events | Aid debugging | `logger.info(...)` |
| Type Hints | Better IDE support | `def func(x: str) -> dict:` |
| Monitor Performance | Optimize speed | Track `response.elapsed` |

---

## 📚 Complete Example: Production-Ready API Client

Here's a comprehensive example combining all best practices:

```python
"""
Production-ready API client using BSecure
"""
import bsecure
import os
import logging
from typing import Optional, Dict, Any, List

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class APIClient:
    """Production-ready API client with error handling and monitoring."""
    
    def __init__(self, base_url: str, api_key: Optional[str] = None):
        self.base_url = base_url
        self.session = bsecure.Session()
        
        # Configure session
        self.session.headers = {
            'User-Agent': 'ProductionApp/1.0',
            'Accept': 'application/json'
        }
        self.session.timeout = 30.0
        self.session.max_retries = 5
        self.session.retry_delay = 2.0
        self.session.verify = True
        
        # Set authentication if provided
        if api_key:
            self.session.auth = {'X-API-Key': api_key}
        
        logger.info(f"API client initialized for {base_url}")
    
    def get(self, endpoint: str, params: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """Make GET request."""
        url = f"{self.base_url}{endpoint}"
        logger.info(f"GET {url}")
        
        try:
            response = self.session.get(url, params=params)
            response.raise_for_status()
            
            logger.info(f"GET {url} - {response.status_code} ({response.elapsed:.3f}s)")
            return response.json()
        
        except bsecure.TimeoutError as e:
            logger.error(f"GET {url} - Timeout: {e}")
            raise
        except bsecure.ConnectionError as e:
            logger.error(f"GET {url} - Connection failed: {e}")
            raise
        except bsecure.BSecureError as e:
            logger.error(f"GET {url} - Error: {e}")
            raise
    
    def post(self, endpoint: str, data: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """Make POST request."""
        url = f"{self.base_url}{endpoint}"
        logger.info(f"POST {url}")
        
        try:
            response = self.session.post(url, json=data)
            response.raise_for_status()
            
            logger.info(f"POST {url} - {response.status_code} ({response.elapsed:.3f}s)")
            return response.json()
        
        except bsecure.BSecureError as e:
            logger.error(f"POST {url} - Error: {e}")
            raise
    
    def upload_file(self, endpoint: str, file_path: str, **metadata) -> Dict[str, Any]:
        """Upload file with validation."""
        # Validate file
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"File not found: {file_path}")
        
        file_size = os.path.getsize(file_path)
        max_size = 50 * 1024 * 1024  # 50MB
        
        if file_size > max_size:
            raise ValueError(f"File too large: {file_size} bytes (max {max_size})")
        
        # Upload
        url = f"{self.base_url}{endpoint}"
        logger.info(f"Uploading {file_path} ({file_size} bytes) to {url}")
        
        with open(file_path, 'rb') as f:
            files = {'file': (os.path.basename(file_path), f.read())}
            
            response = self.session.post(
                url,
                files=files,
                params=metadata,
                timeout=120.0  # Longer timeout for uploads
            )
            response.raise_for_status()
        
        logger.info(f"File uploaded successfully ({response.status_code})")
        return response.json()


# Usage
if __name__ == '__main__':
    # Load API key from environment
    api_key = os.getenv('API_KEY')
    
    # Create client
    client = APIClient('https://api.example.com', api_key=api_key)
    
    try:
        # Fetch users
        users = client.get('/users', params={'page': 1, 'limit': 10})
        logger.info(f"Fetched {len(users)} users")
        
        # Create new user
        new_user = client.post('/users', data={
            'name': 'Alice Johnson',
            'email': 'alice@example.com',
            'role': 'developer'
        })
        logger.info(f"Created user: {new_user['id']}")
        
        # Upload document
        doc = client.upload_file(
            '/documents',
            'report.pdf',
            title='Q4 Report',
            category='finance'
        )
        logger.info(f"Uploaded document: {doc['id']}")
        
    except bsecure.BSecureError as e:
        logger.error(f"API error: {e}")
        exit(1)
```

---

## 📞 Support & Resources

- **Author**: Binyamin Binni
- **Repository**: [github.com/binyaminbinni/bsecure](https://github.com/binyaminbinni/bsecure)

---

<div align="center">

**Made with ❤️ by Binyamin Binni**

*BSecure - Secure, Fast, Elegant HTTP for Python*

</div>
