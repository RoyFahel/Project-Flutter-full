const mongoose = require('mongoose');
// config/database.js

const connectToMongoDB = async () => {
  const uri = process.env.MONGO_URI || 'mongodb+srv://royfahel:Royfahel123@pharmax.tsmesdk.mongodb.net/pharmax?retryWrites=true&w=majority&appName=spotify-api';

  console.log('🔌 Connecting to MongoDB:', uri);

  try {
    await mongoose.connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    console.log('✅ Connected to MongoDB');
  } catch (err) {
    console.error('❌ MongoDB connection error:', err.message);
    console.log('⚠️ Continuing without database connection...');
    // Don't crash the app if MongoDB failss
    return false;
  }
  return true;
};

module.exports = connectToMongoDB;



