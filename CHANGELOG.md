# Changelog

All notable changes to bsecure will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2024

### Added
- **File uploads**: `files` parameter for multipart/form-data uploads
  - Supports tuple format: `{'field': ('filename', data, 'content/type')}`
  - Supports file paths: `{'field': '/path/to/file'}`
  - Supports file objects: `{'field': open('file.txt', 'rb')}`
  - Can combine with `data` parameter for mixed multipart forms
- **response.request**: Access original request object (`PreparedRequest` type)
- **response.is_redirect**: Property indicating if response is a redirect
- **response.is_permanent_redirect**: Property for 301/308 redirects
- **response.apparent_encoding**: Fallback encoding detection
- **response.links**: Parse Link headers into dict
- **response.iter_content(chunk_size)**: Iterate over response content in chunks
- **response.iter_lines(delimiter)**: Iterate over response text by lines
- **PreparedRequest type**: Stores method, url, headers, body of original request
- **TooManyRedirects exception**: Raised when max redirects exceeded
- **URLRequired exception**: For completeness with requests API

### Changed
- Thread-safe curl initialization using `pthread_once`
- User-Agent updated to `python-bsecure/2.1`
- Improved error messages for `raise_for_status()` (includes URL)

### Fixed
- File upload support now properly implemented using libcurl mime API

## [2.0.0] - 2024

### Added
- Embedded Mozilla CA certificate bundle for HTTPS without system dependencies
- Static linking of all dependencies (libcurl, OpenSSL, json-c, etc.)
- HTTP/2 support via nghttp2
- Complete test suite with 8 test categories
- Comprehensive documentation
- Source distribution package (bsecure-src.zip)

### Changed
- Binary is now fully self-contained (~8MB)
- Only Python is dynamically linked
- SSL verification uses embedded certificates by default

### Fixed
- Format string bugs in PyArg_ParseTupleAndKeywords calls
- Proper reference counting in Response and Session objects

## [1.0.0] - Initial Release

### Added
- Core HTTP methods: get, post, put, delete, patch, head, options
- Session support with persistent cookies and headers
- Response object with text, content, headers, cookies
- JSON functions: loads, dumps, load, dump
- Exception hierarchy: RequestException, HTTPError, ConnectionError, Timeout
- Basic authentication support
- Proxy support
- SSL/TLS configuration options
- Timeout support
- Redirect following with history
