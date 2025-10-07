<div align="center">

# 🔐 BSecure

### A High-Performance, Security-Hardened HTTP Library for Python

[![GitHub Release](https://img.shields.io/github/v/release/binyaminbinni/bsecure?style=for-the-badge&logo=github&color=blue)](https://github.com/binyaminbinni/bsecure/releases/latest)
[![Python Version](https://img.shields.io/badge/python-3.6+-blue?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org)
[![License](https://img.shields.io/github/license/binyaminbinni/bsecure?style=for-the-badge)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/binyaminbinni/bsecure?style=for-the-badge&logo=github)](https://github.com/binyaminbinni/bsecure/stargazers)

**BSecure** combines the simplicity of `requests` with advanced security features and blazing-fast performance. Perfect for developers who need a reliable, secure HTTP client without the complexity.

[📥 Download Latest Release](https://github.com/binyaminbinni/bsecure/releases/latest) • [📖 Documentation](#-api-reference) • [💡 Examples](#-examples) • [⭐ Star Us](https://github.com/binyaminbinni/bsecure)

</div>

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🚀 Performance & Security
- **⚡ Fast Performance** - Optimized for speed
- **🔒 Security Hardened** - Advanced security features
- **🗜️ Smart Compression** - Auto gzip, deflate, brotli, zstd

</td>
<td width="50%">

### 🛠️ Developer Friendly
- **📝 Simple API** - Familiar requests-like interface
- **🎯 Full HTTP Support** - All HTTP methods supported
- **🔧 Session Management** - Persistent sessions & cookies

</td>
</tr>
<tr>
<td width="50%">

### 🌐 Advanced Features
- **🍪 Cookie Management** - Multiple formats supported
- **📤 File Uploads** - Multipart/form-data support
- **🔐 Authentication** - Basic, Bearer, custom auth

</td>
<td width="50%">

### 🎨 Flexibility
- **🌍 Proxy Support** - HTTP/HTTPS proxy config
- **📊 JSON Support** - Built-in encoding/decoding
- **⏱️ Timeout Control** - Flexible timeout settings

</td>
</tr>
</table>

---

## 📥 Installation

### Download from GitHub Releases (Recommended)

**BSecure** is available as a compiled module on GitHub Releases. To get started:

1. **Download the latest release:**
   
   Visit the [**Releases Page**](https://github.com/binyaminbinni/bsecure/releases/latest) and download the latest version of the module.

2. **Place the module in your project:**
   
   Extract and place the `bsecure` module file in your Python project directory or in your Python path.

3. **Import and use:**

```python
import bsecure

# You're ready to go! 🚀
response = bsecure.get('https://api.example.com/data')
print(response.text)
```

> 💡 **Tip:** Always download the **latest release** for the best performance, security updates, and new features!

---

## 🚀 Quick Start

### Basic Usage

Get up and running in seconds:

```python
import bsecure

# 🌟 Simple GET request
response = bsecure.get('https://api.example.com/data')
print(response.text)
print(response.status_code)

# 📤 POST with JSON
response = bsecure.post('https://api.example.com/users', 
                        json={'name': 'John', 'age': 30})
print(response.json())

# 🔑 POST with form data
response = bsecure.post('https://api.example.com/login',
                        data={'username': 'user', 'password': 'pass'})
```

### Session Usage

Maintain persistent sessions effortlessly:

```python
import bsecure

# 🔧 Create a session
s = bsecure.Session()

# 📋 Set session headers
s.headers = {'User-Agent': 'MyApp/1.0', 'Accept': 'application/json'}

# 🍪 Set session cookies
s.cookies = {'session_id': 'abc123'}

# 🚀 Make requests with session
response = s.get('https://api.example.com/data')
print(response.text)
```

---

## 📚 API Reference

### Module Functions

All core HTTP methods at your fingertips:

```python
bsecure.get(url, **kwargs)      # 🔵 Send GET request
bsecure.post(url, **kwargs)     # 🟢 Send POST request
bsecure.put(url, **kwargs)      # 🟡 Send PUT request
bsecure.delete(url, **kwargs)   # 🔴 Send DELETE request
bsecure.head(url, **kwargs)     # ⚪ Send HEAD request
bsecure.patch(url, **kwargs)    # 🟣 Send PATCH request
bsecure.options(url, **kwargs)  # 🟠 Send OPTIONS request
```

### Session Object

```python
session = bsecure.Session()
```

#### 🔧 Properties:
- **`headers`** (dict) - Session headers
- **`cookies`** (Cookies) - Session cookies object
- **`auth`** (tuple/str/dict) - Authentication credentials
- **`proxies`** (dict) - Proxy configuration
- **`timeout`** (float) - Request timeout in seconds
- **`verify`** (bool) - SSL verification

#### 📋 Methods:
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

#### 📊 Properties:
- **`status_code`** (int) - HTTP status code
- **`headers`** (dict) - Response headers
- **`content`** (bytes) - Raw response body
- **`text`** (str) - Decoded response body
- **`url`** (str) - Final URL
- **`cookies`** (Cookies) - Response cookies
- **`reason`** (str) - HTTP status reason
- **`elapsed`** (float) - Request duration in seconds

#### 🛠️ Methods:
- `raise_for_status()` - Raise exception for 4xx/5xx status codes
- `json()` - Parse response body as JSON

### Cookies Object

#### 🍪 Methods:
- `get_dict()` - Get cookies as dictionary
- `get_list_dict()` - Get cookies as list of dictionaries
- `get_string()` - Get cookies as semicolon-separated string

---

## ⚙️ Request Parameters

All request functions accept the following keyword arguments:

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| **`url`** | `str` | Target URL (required) | `'https://api.example.com'` |
| **`params`** | `dict` | URL query parameters | `{'page': 1, 'limit': 10}` |
| **`data`** | `bytes/str/dict` | Request body data | `{'key': 'value'}` |
| **`json`** | `dict/list` | JSON request body | `{'name': 'John'}` |
| **`files`** | `dict/list` | Files for multipart upload | `{'file': ('name.txt', data)}` |
| **`headers`** | `dict` | Request headers | `{'User-Agent': 'MyApp'}` |
| **`cookies`** | `dict/str/list` | Request cookies | `{'session': 'abc123'}` |
| **`auth`** | `tuple/str/dict` | Authentication | `('user', 'pass')` |
| **`proxies`** | `dict` | Proxy configuration | `{'http': 'http://proxy'}` |
| **`timeout`** | `float` | Request timeout in seconds | `5.0` |
| **`verify`** | `bool` | SSL verification | `True` |

---

## 💡 Examples

### 📋 Headers

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

### 🍪 Cookies

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

### 📤 POST Data

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

### 📁 File Uploads

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

### 🔐 Authentication

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

### 🌐 Proxies

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

### ⏱️ Timeouts

```python
import bsecure

# Request timeout (seconds)
response = bsecure.get('https://example.com', timeout=5.0)

# Session timeout
s = bsecure.Session()
s.timeout = 10.0
response = s.get('https://example.com')
```

### ⚠️ Error Handling

```python
import bsecure

try:
    response = bsecure.get('https://api.example.com/data')
    response.raise_for_status()
    data = response.json()
except Exception as e:
    print(f"Request failed: {e}")
```

### 🔍 Query Parameters

```python
import bsecure

# URL parameters
params = {'page': 1, 'limit': 10, 'sort': 'date'}
response = bsecure.get('https://api.example.com/items', params=params)
# Requests: https://api.example.com/items?page=1&limit=10&sort=date
```

### 📊 JSON Utilities

```python
import bsecure

# Serialize to JSON
obj = {'name': 'John', 'items': [1, 2, 3]}
json_string = bsecure.json_dumps(obj)

# Deserialize from JSON
json_string = '{"name": "John", "age": 30}'
obj = bsecure.json_loads(json_string)
```

---

## 🔧 Advanced Cookie Management

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

---

## 🎯 Complete Example

Here's a comprehensive example showcasing BSecure's capabilities:

```python
import bsecure

# 🔧 Create session
session = bsecure.Session()

# ⚙️ Configure session
session.headers = {
    'User-Agent': 'MyApp/1.0',
    'Accept': 'application/json'
}
session.timeout = 30.0

# 🔑 Login
login_data = {'username': 'user', 'password': 'pass'}
response = session.post('https://api.example.com/login', json=login_data)
response.raise_for_status()

# ✅ Session cookies are automatically stored
print(f"Logged in: {response.cookies.get_dict()}")

# 📊 Make authenticated requests
response = session.get('https://api.example.com/user/profile')
profile = response.json()
print(f"Profile: {profile}")

# 📁 Upload file
files = {'avatar': ('profile.jpg', open('profile.jpg', 'rb').read())}
response = session.post('https://api.example.com/user/avatar', files=files)
print(f"Upload status: {response.status_code}")

# 👋 Logout
response = session.post('https://api.example.com/logout')
print(f"Logged out: {response.status_code}")
```

---

## 📖 Module Information

<div align="center">

**Author:** Binyamin Binni  
**Repository:** [github.com/binyaminbinni/bsecure](https://github.com/binyaminbinni/bsecure)  
**Download:** [Latest Release](https://github.com/binyaminbinni/bsecure/releases/latest)

</div>

---

## 🤝 Contributing

We welcome contributions! If you'd like to improve BSecure:

1. 🍴 Fork the repository
2. 🔨 Create a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🎯 Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the repository for details.

---

## 💬 Support

- 📫 **Issues:** [GitHub Issues](https://github.com/binyaminbinni/bsecure/issues)
- ⭐ **Star us:** If you find BSecure useful, give us a star on [GitHub](https://github.com/binyaminbinni/bsecure)!
- 📚 **Documentation:** Visit the [repository](https://github.com/binyaminbinni/bsecure) for more examples

---

<div align="center">

**Made with ❤️ by [Binyamin Binni](https://github.com/binyaminbinni)**

[![GitHub](https://img.shields.io/badge/GitHub-binyaminbinni-181717?style=for-the-badge&logo=github)](https://github.com/binyaminbinni)

</div>
