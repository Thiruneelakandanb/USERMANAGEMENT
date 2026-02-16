const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Database connection
const pool = new Pool({
  host: process.env.SUPABASE_DB_HOST || 'aws-1-ap-south-1.pooler.supabase.com',
  port: process.env.SUPABASE_DB_PORT || 6543,
  database: process.env.SUPABASE_DB_NAME || 'postgres',
  user: process.env.SUPABASE_DB_USERNAME || 'postgres.rhebewpkkimrlddyceax',
  password: process.env.SUPABASE_DB_PASSWORD,
  ssl: { rejectUnauthorized: false }
});

// Test database connection
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Database connection error:', err);
  } else {
    console.log('Database connected successfully');
  }
});

// Routes

// Get all users
app.get('/api/user/getall', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users ORDER BY id');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: 'Failed to fetch users' });
  }
});

// Get user by ID
app.get('/api/user/get/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('SELECT * FROM users WHERE id = $1', [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ error: 'Failed to fetch user' });
  }
});

// Create user
app.post('/api/user/create', async (req, res) => {
  try {
    const { name, email, phone, address } = req.body;
    
    // Validation
    if (!name || !email) {
      return res.status(400).json({ error: 'Name and email are required' });
    }
    
    const result = await pool.query(
      'INSERT INTO users (name, email, phone, address) VALUES ($1, $2, $3, $4) RETURNING *',
      [name, email, phone, address]
    );
    
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error creating user:', error);
    
    // Handle unique constraint violation
    if (error.code === '23505') {
      return res.status(409).json({ error: 'Email already exists' });
    }
    
    res.status(500).json({ error: 'Failed to create user' });
  }
});

// Update user
app.put('/api/user/update', async (req, res) => {
  try {
    const { id, name, email, phone, address } = req.body;
    
    // Validation
    if (!id || !name || !email) {
      return res.status(400).json({ error: 'ID, name, and email are required' });
    }
    
    const result = await pool.query(
      'UPDATE users SET name = $1, email = $2, phone = $3, address = $4 WHERE id = $5 RETURNING *',
      [name, email, phone, address, id]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error updating user:', error);
    
    // Handle unique constraint violation
    if (error.code === '23505') {
      return res.status(409).json({ error: 'Email already exists' });
    }
    
    res.status(500).json({ error: 'Failed to update user' });
  }
});

// Delete user
app.delete('/api/user/delete/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    const result = await pool.query('DELETE FROM users WHERE id = $1 RETURNING *', [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json({ message: 'User deleted successfully', user: result.rows[0] });
  } catch (error) {
    console.error('Error deleting user:', error);
    res.status(500).json({ error: 'Failed to delete user' });
  }
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Root endpoint
app.get('/api', (req, res) => {
  res.json({
    message: 'User Management API',
    version: '1.0.0',
    endpoints: {
      getAll: 'GET /api/user/getall',
      getById: 'GET /api/user/get/:id',
      create: 'POST /api/user/create',
      update: 'PUT /api/user/update',
      delete: 'DELETE /api/user/delete/:id'
    }
  });
});

// For local development
if (process.env.NODE_ENV !== 'production') {
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
  });
}

// Export for Vercel
module.exports = app;
