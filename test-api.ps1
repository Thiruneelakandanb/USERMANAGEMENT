# PowerShell script to test all API endpoints
# Run this after the application starts successfully

$baseUrl = "http://localhost:8081/api/user"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Testing User Management API" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: Get all users (should be empty initially)
Write-Host "Test 1: GET /getall - Fetch all users" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/getall" -Method Get
    Write-Host "✓ Success! Users found: $($response.Count)" -ForegroundColor Green
    $response | ConvertTo-Json
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 2: Create User 1
Write-Host "Test 2: POST /create - Create User 1 (John Doe)" -ForegroundColor Yellow
$user1 = @{
    name = "John Doe"
    email = "john.doe@example.com"
    phone = "+91-9876543210"
    address = "123 Main St, Mumbai, India"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/create" -Method Post -Body $user1 -ContentType "application/json"
    Write-Host "✓ User created successfully! ID: $($response.id)" -ForegroundColor Green
    $userId1 = $response.id
    $response | ConvertTo-Json
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 3: Create User 2
Write-Host "Test 3: POST /create - Create User 2 (Jane Smith)" -ForegroundColor Yellow
$user2 = @{
    name = "Jane Smith"
    email = "jane.smith@example.com"
    phone = "+91-9876543211"
    address = "456 Park Ave, Delhi, India"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/create" -Method Post -Body $user2 -ContentType "application/json"
    Write-Host "✓ User created successfully! ID: $($response.id)" -ForegroundColor Green
    $userId2 = $response.id
    $response | ConvertTo-Json
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 4: Create User 3
Write-Host "Test 4: POST /create - Create User 3 (Bob Johnson)" -ForegroundColor Yellow
$user3 = @{
    name = "Bob Johnson"
    email = "bob.johnson@example.com"
    phone = "+91-9876543212"
    address = "789 Oak Rd, Bangalore, India"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/create" -Method Post -Body $user3 -ContentType "application/json"
    Write-Host "✓ User created successfully! ID: $($response.id)" -ForegroundColor Green
    $userId3 = $response.id
    $response | ConvertTo-Json
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 5: Get all users again
Write-Host "Test 5: GET /getall - Fetch all users (should have 3 now)" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/getall" -Method Get
    Write-Host "✓ Success! Total users: $($response.Count)" -ForegroundColor Green
    $response | ConvertTo-Json
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 6: Get user by ID
if ($userId1) {
    Write-Host "Test 6: GET /get/$userId1 - Fetch user by ID" -ForegroundColor Yellow
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/get/$userId1" -Method Get
        Write-Host "✓ User found: $($response.name)" -ForegroundColor Green
        $response | ConvertTo-Json
    } catch {
        Write-Host "✗ Failed: $_" -ForegroundColor Red
    }
    Write-Host ""
}

# Test 7: Update user
if ($userId1) {
    Write-Host "Test 7: PUT /update - Update User 1" -ForegroundColor Yellow
    $updateUser = @{
        id = $userId1
        name = "John Doe Updated"
        email = "john.doe@example.com"
        phone = "+91-1234567890"
        address = "New Address, Mumbai, India"
    } | ConvertTo-Json

    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/update" -Method Put -Body $updateUser -ContentType "application/json"
        Write-Host "✓ User updated successfully!" -ForegroundColor Green
        $response | ConvertTo-Json
    } catch {
        Write-Host "✗ Failed: $_" -ForegroundColor Red
    }
    Write-Host ""
}

# Test 8: Delete user
if ($userId3) {
    Write-Host "Test 8: DELETE /delete/$userId3 - Delete User 3" -ForegroundColor Yellow
    try {
        Invoke-RestMethod -Uri "$baseUrl/delete/$userId3" -Method Delete
        Write-Host "✓ User deleted successfully!" -ForegroundColor Green
    } catch {
        Write-Host "✗ Failed: $_" -ForegroundColor Red
    }
    Write-Host ""
}

# Test 9: Final count
Write-Host "Test 9: GET /getall - Final user count (should have 2)" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/getall" -Method Get
    Write-Host "✓ Success! Final user count: $($response.Count)" -ForegroundColor Green
    $response | ConvertTo-Json
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "API Testing Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next: Open http://localhost:8081/ in your browser to see the UI!" -ForegroundColor Green
