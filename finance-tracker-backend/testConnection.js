const mongoose = require('mongoose');

async function testConnection() {
    try {
        await mongoose.connect('mongodb://127.0.0.1:27017/rudradb', {
            useNewUrlParser: true,
            useUnifiedTopology: true
        });
        console.log('MongoDB connected successfully!');
    } catch (error) {
        console.error('Failed to connect to MongoDB:', error.message);
    }
}

testConnection();
