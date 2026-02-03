# bsecure Examples

Practical examples for common use cases with bsecure.

## Table of Contents

- [Basic Usage](#basic-usage)
- [Working with JSON APIs](#working-with-json-apis)
- [Authentication](#authentication)
- [Sessions & Cookies](#sessions--cookies)
- [File Downloads](#file-downloads)
- [Error Handling](#error-handling)
- [Advanced Configuration](#advanced-configuration)
- [Real-World Patterns](#real-world-patterns)

---

## Basic Usage

### Simple GET Request

```python
import bsecure

response = bsecure.get('https://httpbin.org/get')
print(response.status_code)  # 200
print(response.text)         # Response body as string
```

### POST with Form Data

```python
response = bsecure.post('https://httpbin.org/post', data={
    'username': 'john',
    'password': 'secret'
})
print(response.json())
```

### POST with JSON

```python
response = bsecure.post('https://api.example.com/users', json={
    'name': 'John Doe',
    'email': 'john@example.com'
})
user = response.json()
print(f"Created user with ID: {user['id']}")
```

### Query Parameters

```python
# As a dict
response = bsecure.get('https://api.example.com/search', params={
    'q': 'python',
    'page': 1,
    'limit': 10
})
# URL becomes: https://api.example.com/search?q=python&page=1&limit=10

# As a list of tuples (for duplicate keys)
response = bsecure.get('https://api.example.com/filter', params=[
    ('tag', 'python'),
    ('tag', 'programming'),
    ('tag', 'tutorial')
])
# URL becomes: ...?tag=python&tag=programming&tag=tutorial
```

### Custom Headers

```python
response = bsecure.get('https://api.example.com/data', headers={
    'User-Agent': 'MyApp/1.0',
    'Accept': 'application/json',
    'X-Custom-Header': 'my-value'
})
```

---

## Working with JSON APIs

### Complete REST API Client

```python
import bsecure

BASE_URL = 'https://api.example.com'
HEADERS = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}

# List resources
def list_users(page=1, limit=10):
    response = bsecure.get(f'{BASE_URL}/users', 
                           params={'page': page, 'limit': limit},
                           headers=HEADERS)
    response.raise_for_status()
    return response.json()

# Get single resource
def get_user(user_id):
    response = bsecure.get(f'{BASE_URL}/users/{user_id}', headers=HEADERS)
    response.raise_for_status()
    return response.json()

# Create resource
def create_user(data):
    response = bsecure.post(f'{BASE_URL}/users', json=data, headers=HEADERS)
    response.raise_for_status()
    return response.json()

# Update resource
def update_user(user_id, data):
    response = bsecure.put(f'{BASE_URL}/users/{user_id}', json=data, headers=HEADERS)
    response.raise_for_status()
    return response.json()

# Partial update
def patch_user(user_id, data):
    response = bsecure.patch(f'{BASE_URL}/users/{user_id}', json=data, headers=HEADERS)
    response.raise_for_status()
    return response.json()

# Delete resource
def delete_user(user_id):
    response = bsecure.delete(f'{BASE_URL}/users/{user_id}', headers=HEADERS)
    response.raise_for_status()
    return True

# Usage
users = list_users(page=1, limit=20)
user = create_user({'name': 'Jane', 'email': 'jane@example.com'})
update_user(user['id'], {'name': 'Jane Doe'})
delete_user(user['id'])
```

### Parsing JSON Response

```python
response = bsecure.get('https://api.example.com/data')

# Method 1: response.json()
data = response.json()

# Method 2: bsecure.loads()
data = bsecure.loads(response.text)

# Check content type before parsing
if 'application/json' in response.headers.get('Content-Type', ''):
    data = response.json()
else:
    print("Response is not JSON:", response.text)
```

### Working with JSON Files

```python
# Read JSON file
with open('config.json', 'r') as f:
    config = bsecure.load(f)

# Modify and save
config['version'] = '2.0.0'
with open('config.json', 'w') as f:
    bsecure.dump(config, f, indent=2)
```

---

## Authentication

### Basic Authentication

```python
response = bsecure.get('https://api.example.com/private', 
                       auth=('username', 'password'))
```

### Bearer Token (OAuth/JWT)

```python
token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
response = bsecure.get('https://api.example.com/data', headers={
    'Authorization': f'Bearer {token}'
})
```

### API Key Authentication

```python
# In header
response = bsecure.get('https://api.example.com/data', headers={
    'X-API-Key': 'your-api-key'
})

# In query parameter
response = bsecure.get('https://api.example.com/data', params={
    'api_key': 'your-api-key'
})
```

### Session with Authentication

```python
# Create authenticated session
session = bsecure.Session()
session.headers['Authorization'] = f'Bearer {token}'

# All requests automatically include the token
users = session.get('https://api.example.com/users').json()
posts = session.get('https://api.example.com/posts').json()
```

---

## Sessions & Cookies

### Persistent Session

```python
session = bsecure.Session()

# Login (cookies are automatically captured)
login_response = session.post('https://example.com/login', data={
    'username': 'john',
    'password': 'secret'
})

# Subsequent requests include cookies
profile = session.get('https://example.com/profile')
settings = session.get('https://example.com/settings')

# View cookies
print(session.cookies)
```

### Session with Default Headers

```python
session = bsecure.Session()
session.headers.update({
    'User-Agent': 'MyApp/1.0',
    'Accept': 'application/json',
    'Accept-Language': 'en-US'
})

# All requests include these headers
response1 = session.get('https://api.example.com/endpoint1')
response2 = session.get('https://api.example.com/endpoint2')
```

### Context Manager

```python
with bsecure.Session() as session:
    session.headers['User-Agent'] = 'MyApp/1.0'
    
    # Login
    session.post('https://example.com/login', data={'user': 'john'})
    
    # Make authenticated requests
    data = session.get('https://example.com/api/data').json()
    
# session.close() called automatically
```

### Manual Cookie Management

```python
# Send specific cookies
response = bsecure.get('https://example.com', cookies={
    'session_id': 'abc123',
    'user_pref': 'dark_mode'
})

# Access response cookies
print(response.cookies)
```

---

## File Downloads

### Download to Memory

```python
response = bsecure.get('https://example.com/file.pdf')
content = response.content  # bytes

# Save to file
with open('downloaded.pdf', 'wb') as f:
    f.write(content)
```

### Check File Size Before Download

```python
# HEAD request to get headers only
head = bsecure.head('https://example.com/large-file.zip')
size = int(head.headers.get('Content-Length', 0))

print(f"File size: {size / 1024 / 1024:.2f} MB")

if size < 100 * 1024 * 1024:  # < 100 MB
    response = bsecure.get('https://example.com/large-file.zip')
    with open('large-file.zip', 'wb') as f:
        f.write(response.content)
```

### Download with Progress (simple)

```python
import sys

response = bsecure.get('https://example.com/file.zip')

# Note: bsecure downloads fully before returning
# For streaming progress, you'd need to check Content-Length first
size = len(response.content)
print(f"Downloaded {size} bytes")

with open('file.zip', 'wb') as f:
    f.write(response.content)
```

---

## Error Handling

### Comprehensive Error Handling

```python
import bsecure

def safe_request(url):
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
        print(f"HTTP error: {e}")
        return None
        
    except bsecure.JSONDecodeError:
        print("Response was not valid JSON")
        return None
        
    except bsecure.RequestException as e:
        print(f"Request failed: {e}")
        return None
```

### Retry Pattern

```python
import time
import bsecure

def request_with_retry(url, max_retries=3, backoff=1.0):
    for attempt in range(max_retries):
        try:
            response = bsecure.get(url, timeout=10)
            response.raise_for_status()
            return response
            
        except (bsecure.Timeout, bsecure.ConnectionError) as e:
            if attempt < max_retries - 1:
                wait_time = backoff * (2 ** attempt)  # Exponential backoff
                print(f"Attempt {attempt + 1} failed, retrying in {wait_time}s...")
                time.sleep(wait_time)
            else:
                raise
                
        except bsecure.HTTPError as e:
            # Don't retry on client errors (4xx)
            if response.status_code >= 400 and response.status_code < 500:
                raise
            # Retry on server errors (5xx)
            if attempt < max_retries - 1:
                time.sleep(backoff * (2 ** attempt))
            else:
                raise

# Usage
try:
    response = request_with_retry('https://api.example.com/data')
except bsecure.RequestException as e:
    print(f"All retries failed: {e}")
```

### Check Response Status

```python
response = bsecure.get('https://api.example.com/data')

# Method 1: Check status code directly
if response.status_code == 200:
    data = response.json()
elif response.status_code == 404:
    print("Resource not found")
elif response.status_code >= 500:
    print("Server error")

# Method 2: Use ok property
if response.ok:
    data = response.json()
else:
    print(f"Error: {response.status_code} {response.reason}")

# Method 3: Boolean evaluation
if response:
    data = response.json()
else:
    print("Request failed")

# Method 4: raise_for_status()
try:
    response.raise_for_status()
    data = response.json()
except bsecure.HTTPError:
    print(f"Error: {response.status_code}")
```

---

## Advanced Configuration

### Timeout Configuration

```python
# Single timeout (applies to entire request)
response = bsecure.get('https://example.com', timeout=5)

# Tuple timeout (connect, read)
response = bsecure.get('https://example.com', timeout=(3.0, 10.0))
```

### SSL Configuration

```python
# Disable SSL verification (not recommended for production)
response = bsecure.get('https://self-signed.example.com', verify=False)

# Use custom CA bundle
response = bsecure.get('https://internal.example.com', 
                       verify='/path/to/ca-bundle.crt')

# Client certificate
response = bsecure.get('https://secure.example.com',
                       cert=('/path/to/client.crt', '/path/to/client.key'))

# Or single file with both cert and key
response = bsecure.get('https://secure.example.com',
                       cert='/path/to/client.pem')
```

### Proxy Configuration

```python
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
```

### Redirect Control

```python
# Disable redirects
response = bsecure.get('https://example.com/redirect', allow_redirects=False)
print(response.status_code)  # 301/302/etc.
print(response.headers['Location'])

# Enable redirects (default)
response = bsecure.get('https://example.com/redirect', allow_redirects=True)
print(response.url)  # Final URL after redirects

# Check redirect history
for resp in response.history:
    print(f"Redirected from {resp.url} with status {resp.status_code}")
```

---

## Real-World Patterns

### API Client Class

```python
import bsecure

class APIClient:
    def __init__(self, base_url, api_key=None, timeout=30):
        self.base_url = base_url.rstrip('/')
        self.session = bsecure.Session()
        self.session.headers['Accept'] = 'application/json'
        self.session.headers['Content-Type'] = 'application/json'
        if api_key:
            self.session.headers['Authorization'] = f'Bearer {api_key}'
        self.timeout = timeout
    
    def _url(self, endpoint):
        return f"{self.base_url}/{endpoint.lstrip('/')}"
    
    def _request(self, method, endpoint, **kwargs):
        kwargs.setdefault('timeout', self.timeout)
        response = self.session.request(method, self._url(endpoint), **kwargs)
        response.raise_for_status()
        return response.json() if response.text else None
    
    def get(self, endpoint, params=None):
        return self._request('GET', endpoint, params=params)
    
    def post(self, endpoint, data):
        return self._request('POST', endpoint, json=data)
    
    def put(self, endpoint, data):
        return self._request('PUT', endpoint, json=data)
    
    def patch(self, endpoint, data):
        return self._request('PATCH', endpoint, json=data)
    
    def delete(self, endpoint):
        return self._request('DELETE', endpoint)

# Usage
api = APIClient('https://api.example.com', api_key='your-api-key')

users = api.get('/users', params={'page': 1})
user = api.post('/users', {'name': 'John', 'email': 'john@example.com'})
api.patch(f'/users/{user["id"]}', {'name': 'John Doe'})
api.delete(f'/users/{user["id"]}')
```

### Webhook Handler

```python
import bsecure
import time

def send_webhook(url, payload, max_retries=3):
    """Send webhook with retry logic."""
    for attempt in range(max_retries):
        try:
            response = bsecure.post(url, json=payload, timeout=10)
            
            if response.status_code == 200:
                return {'success': True, 'attempt': attempt + 1}
            elif response.status_code >= 500:
                # Server error, retry
                raise bsecure.RequestException(f"Server error: {response.status_code}")
            else:
                # Client error, don't retry
                return {
                    'success': False,
                    'status': response.status_code,
                    'error': response.text
                }
                
        except bsecure.RequestException as e:
            if attempt < max_retries - 1:
                time.sleep(2 ** attempt)  # Exponential backoff
            else:
                return {'success': False, 'error': str(e)}
    
    return {'success': False, 'error': 'Max retries exceeded'}

# Usage
result = send_webhook('https://hooks.example.com/webhook', {
    'event': 'user.created',
    'data': {'user_id': 123, 'email': 'john@example.com'}
})
```

### Health Check

```python
import bsecure

def check_service_health(url, timeout=5):
    """Check if a service is healthy."""
    try:
        response = bsecure.get(url, timeout=timeout)
        return {
            'status': 'healthy' if response.ok else 'unhealthy',
            'status_code': response.status_code,
            'response_time': response.elapsed
        }
    except bsecure.Timeout:
        return {'status': 'timeout', 'error': 'Request timed out'}
    except bsecure.ConnectionError:
        return {'status': 'unreachable', 'error': 'Connection failed'}
    except bsecure.RequestException as e:
        return {'status': 'error', 'error': str(e)}

# Usage
services = [
    'https://api.example.com/health',
    'https://auth.example.com/health',
    'https://db.example.com/health'
]

for service in services:
    health = check_service_health(service)
    print(f"{service}: {health['status']}")
```

### Pagination Handler

```python
import bsecure

def fetch_all_pages(base_url, params=None, page_param='page', limit=100):
    """Fetch all pages from a paginated API."""
    params = params or {}
    params['limit'] = limit
    all_results = []
    page = 1
    
    while True:
        params[page_param] = page
        response = bsecure.get(base_url, params=params)
        response.raise_for_status()
        
        data = response.json()
        
        # Handle different pagination formats
        if isinstance(data, list):
            results = data
        elif 'results' in data:
            results = data['results']
        elif 'data' in data:
            results = data['data']
        else:
            results = data
        
        if not results:
            break
            
        all_results.extend(results)
        
        # Check if more pages
        if len(results) < limit:
            break
            
        page += 1
    
    return all_results

# Usage
all_users = fetch_all_pages('https://api.example.com/users')
print(f"Total users: {len(all_users)}")
```

### Rate Limiter

```python
import time
import bsecure

class RateLimitedClient:
    def __init__(self, requests_per_second=10):
        self.min_interval = 1.0 / requests_per_second
        self.last_request_time = 0
    
    def request(self, method, url, **kwargs):
        # Wait if needed to respect rate limit
        now = time.time()
        elapsed = now - self.last_request_time
        if elapsed < self.min_interval:
            time.sleep(self.min_interval - elapsed)
        
        self.last_request_time = time.time()
        return bsecure.request(method, url, **kwargs)
    
    def get(self, url, **kwargs):
        return self.request('GET', url, **kwargs)
    
    def post(self, url, **kwargs):
        return self.request('POST', url, **kwargs)

# Usage - max 5 requests per second
client = RateLimitedClient(requests_per_second=5)

for i in range(100):
    response = client.get(f'https://api.example.com/item/{i}')
    print(f"Item {i}: {response.status_code}")
```
