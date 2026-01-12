import '../domain/patient.dart';
import '../domain/patient_record.dart';
import '../domain/prescription.dart';

/// Temporary dummy patient data for development.
/// Will be replaced with repository/API calls.
const dummyPatients = [
  Patient(
    id: '1',
    name: 'Max',
    species: 'Dog',
    breed: 'Golden Retriever',
    ownerName: 'Juan dela Cruz',
    ownerPhone: '+63 912 345 6789',
    age: '3 years',
  ),
  Patient(
    id: '2',
    name: 'Whiskers',
    species: 'Cat',
    breed: 'Persian',
    ownerName: 'Maria Santos',
    ownerPhone: '+63 923 456 7890',
    age: '2 years',
  ),
  Patient(
    id: '3',
    name: 'Buddy',
    species: 'Dog',
    breed: 'Labrador',
    ownerName: 'Pedro Reyes',
    ownerPhone: '+63 934 567 8901',
    age: '5 years',
  ),
  Patient(
    id: '4',
    name: 'Luna',
    species: 'Cat',
    breed: 'Siamese',
    ownerName: 'Ana Garcia',
    ownerPhone: '+63 945 678 9012',
    age: '1 year',
  ),
  Patient(
    id: '5',
    name: 'Rocky',
    species: 'Dog',
    breed: 'German Shepherd',
    ownerName: 'Carlos Mendoza',
    ownerPhone: '+63 956 789 0123',
    age: '4 years',
  ),
  Patient(
    id: '6',
    name: 'Milo',
    species: 'Dog',
    breed: 'Beagle',
    ownerName: 'Sofia Lim',
    ownerPhone: '+63 967 890 1234',
    age: '2 years',
  ),
  Patient(
    id: '7',
    name: 'Cleo',
    species: 'Cat',
    breed: 'Maine Coon',
    ownerName: 'Roberto Cruz',
    ownerPhone: '+63 978 901 2345',
    age: '3 years',
  ),
  Patient(
    id: '8',
    name: 'Charlie',
    species: 'Dog',
    breed: 'Poodle',
    ownerName: 'Elena Torres',
    ownerPhone: '+63 989 012 3456',
    age: '6 years',
  ),
];

/// Temporary dummy record data for development.
/// Will be replaced with repository/API calls.
final dummyRecords = [
  PatientRecord(
    id: 'r1',
    patientId: '1',
    date: DateTime(2024, 1, 15, 10, 30),
    diagnosis: 'Annual checkup - All vitals normal',
    weight: '25kg',
    temperature: '38.5°C',
    notes: 'Patient is healthy. Recommended annual vaccination.',
  ),
  PatientRecord(
    id: 'r2',
    patientId: '1',
    date: DateTime(2024, 1, 10, 14, 0),
    diagnosis: 'Vaccination - Rabies booster',
    weight: '24.5kg',
    temperature: '38.2°C',
    notes: 'Administered rabies booster. No adverse reactions.',
  ),
  PatientRecord(
    id: 'r3',
    patientId: '1',
    date: DateTime(2023, 12, 5, 11, 0),
    diagnosis: 'Minor skin irritation - Prescribed ointment',
    weight: '24.8kg',
    temperature: '38.4°C',
    notes: 'Skin irritation on left hind leg. Prescribed treatment for 7 days.',
  ),
  PatientRecord(
    id: 'r4',
    patientId: '2',
    date: DateTime(2024, 1, 20, 9, 0),
    diagnosis: 'Dental cleaning',
    weight: '4.2kg',
    temperature: '38.8°C',
    notes: 'Routine dental cleaning performed. Minor tartar buildup removed.',
  ),
  PatientRecord(
    id: 'r5',
    patientId: '3',
    date: DateTime(2024, 1, 18, 15, 30),
    diagnosis: 'Ear infection treatment',
    weight: '28kg',
    temperature: '38.6°C',
    notes: 'Prescribed ear drops for 10 days.',
  ),
];

/// Temporary dummy prescription data for development.
/// Will be replaced with repository/API calls.
List<Prescription> dummyPrescriptions = [
  const Prescription(
    id: 'p1',
    recordId: 'r1',
    medication: 'Heartworm Prevention',
    dosage: '1 tablet',
    frequency: 'Monthly',
    duration: '12 months',
    instructions: 'Give with food on the same day each month.',
  ),
  const Prescription(
    id: 'p2',
    recordId: 'r3',
    medication: 'Hydrocortisone Cream',
    dosage: 'Apply thin layer',
    frequency: '2x daily',
    duration: '7 days',
    instructions: 'Apply to affected area. Prevent licking for 10 minutes after application.',
  ),
  const Prescription(
    id: 'p3',
    recordId: 'r3',
    medication: 'Apoquel',
    dosage: '16mg',
    frequency: '1x daily',
    duration: '14 days',
    instructions: 'Give with or without food.',
  ),
  const Prescription(
    id: 'p4',
    recordId: 'r4',
    medication: 'Amoxicillin',
    dosage: '50mg',
    frequency: '2x daily',
    duration: '7 days',
    instructions: 'Antibiotic post dental cleaning. Complete full course.',
  ),
  const Prescription(
    id: 'p5',
    recordId: 'r5',
    medication: 'Otibiotic Ointment',
    dosage: '4 drops',
    frequency: '2x daily',
    duration: '10 days',
    instructions: 'Apply directly to ear canal. Massage base of ear after application.',
  ),
];
