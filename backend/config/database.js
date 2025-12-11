// config/database.jsss
const mongoose = require('mongoose');

const connectToMongoDB = async () => {
  const uri = process.env.MONGO_URI;

  console.log('🔌 Connecting to MongoDB:', uri);

  try {
    // just pass the URI
    await mongoose.connect(uri);
    console.log('✅ Connected to MongoDB');
  } catch (err) {
    console.error('❌ MongoDB connection error:', err.message);
    console.log('⚠️ Continuing without database connection...');
    return false;
  }
  return true;
};

module.exports = connectToMongoDB;
