const API_BASE_URL = 'http://localhost:8081/api/user';
let users = [];
let deleteUserId = null;

// Load users on page load
document.addEventListener('DOMContentLoaded', () => {
    loadUsers();
    setupFormSubmit();
});

// Load all users
async function loadUsers() {
    try {
        const response = await fetch(`${API_BASE_URL}/getall`);
        if (!response.ok) throw new Error('Failed to fetch users');
        
        users = await response.json();
        displayUsers(users);
    } catch (error) {
        console.error('Error loading users:', error);
        showToast('Failed to load users', 'error');
        document.getElementById('userTableBody').innerHTML = `
            <tr>
                <td colspan="6" class="loading" style="color: var(--danger);">
                    <i class="fas fa-exclamation-circle"></i> Failed to load users
                </td>
            </tr>
        `;
    }
}

// Display users in table
function displayUsers(userList) {
    const tbody = document.getElementById('userTableBody');
    
    if (userList.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="6" class="loading">
                    <i class="fas fa-inbox"></i> No users found
                </td>
            </tr>
        `;
        return;
    }
    
    tbody.innerHTML = userList.map(user => `
        <tr>
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${user.phone || '-'}</td>
            <td>${user.address || '-'}</td>
            <td>
                <div class="action-buttons">
                    <button class="btn btn-success" onclick="editUser(${user.id})">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="btn btn-danger" onclick="deleteUser(${user.id})">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </div>
            </td>
        </tr>
    `).join('');
}

// Setup form submit
function setupFormSubmit() {
    document.getElementById('addUserForm').addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const userId = document.getElementById('userId').value;
        const userData = {
            name: document.getElementById('name').value,
            email: document.getElementById('email').value,
            phone: document.getElementById('phone').value,
            address: document.getElementById('address').value
        };
        
        try {
            let response;
            if (userId) {
                userData.id = parseInt(userId);
                response = await fetch(`${API_BASE_URL}/update`, {
                    method: 'PUT',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(userData)
                });
            } else {
                response = await fetch(`${API_BASE_URL}/create`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(userData)
                });
            }
            
            if (!response.ok) throw new Error('Failed to save user');
            
            showToast(userId ? 'User updated successfully' : 'User created successfully', 'success');
            resetForm();
            loadUsers();
        } catch (error) {
            console.error('Error saving user:', error);
            showToast('Failed to save user', 'error');
        }
    });
}

// Edit user
async function editUser(id) {
    try {
        const response = await fetch(`${API_BASE_URL}/get/${id}`);
        if (!response.ok) throw new Error('Failed to fetch user');
        
        const user = await response.json();
        
        document.getElementById('userId').value = user.id;
        document.getElementById('name').value = user.name;
        document.getElementById('email').value = user.email;
        document.getElementById('phone').value = user.phone || '';
        document.getElementById('address').value = user.address || '';
        
        document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Update User';
        document.getElementById('userForm').style.display = 'block';
        
        // Scroll to form
        document.getElementById('userForm').scrollIntoView({ behavior: 'smooth' });
    } catch (error) {
        console.error('Error loading user:', error);
        showToast('Failed to load user details', 'error');
    }
}

// Delete user
function deleteUser(id) {
    deleteUserId = id;
    document.getElementById('modal').classList.add('show');
}

// Confirm delete
async function confirmDelete() {
    try {
        const response = await fetch(`${API_BASE_URL}/delete/${deleteUserId}`, {
            method: 'DELETE'
        });
        
        if (!response.ok) throw new Error('Failed to delete user');
        
        showToast('User deleted successfully', 'success');
        closeModal();
        loadUsers();
    } catch (error) {
        console.error('Error deleting user:', error);
        showToast('Failed to delete user', 'error');
    }
}

// Close modal
function closeModal() {
    document.getElementById('modal').classList.remove('show');
    deleteUserId = null;
}

// Reset form
function resetForm() {
    document.getElementById('addUserForm').reset();
    document.getElementById('userId').value = '';
    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Save User';
}

// Toggle form
function toggleForm() {
    const form = document.getElementById('userForm');
    const isVisible = form.style.display !== 'none';
    form.style.display = isVisible ? 'none' : 'block';
}

// Search users
function searchUsers() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const filteredUsers = users.filter(user => 
        user.name.toLowerCase().includes(searchTerm) ||
        user.email.toLowerCase().includes(searchTerm) ||
        (user.phone && user.phone.toLowerCase().includes(searchTerm)) ||
        (user.address && user.address.toLowerCase().includes(searchTerm))
    );
    displayUsers(filteredUsers);
}

// Show toast notification
function showToast(message, type) {
    const toast = document.getElementById('toast');
    toast.textContent = message;
    toast.className = `toast ${type} show`;
    
    setTimeout(() => {
        toast.classList.remove('show');
    }, 3000);
}
