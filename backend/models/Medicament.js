// models/Medicament.js
const mongoose = require('mongoose');

const medicamentSchema = new mongoose.Schema({
  medicamentName: {
    type: String,
    required: [true, 'Medicament name is required'],
    trim: true
  },
  // use camelCase field name so API and frontend align
  maladyId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Malady',
    required: [true, 'Malady ID is required']
  },
  isDeleted: {
    type: Boolean,
    default: false
  }
}, {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true }
});

// Transform output: _id -> id, remove __v, keep maladyId as string or object
medicamentSchema.method('toJSON', function () {
  const obj = this.toObject({ virtuals: true });
  obj.id = obj._id?.toString();
  // If maladyId is an object (populated), convert to id field
  if (obj.maladyId && typeof obj.maladyId === 'object') {
    obj.maladyId = obj.maladyId._id ? obj.maladyId._id.toString() : obj.maladyId.toString();
  }
  delete obj._id;
  delete obj.__v;
  return obj;
});

module.exports = mongoose.model('Medicament', medicamentSchema);
