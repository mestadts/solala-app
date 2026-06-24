import { initializeApp } from 'firebase/app'
import { getAuth } from 'firebase/auth'
import { getFirestore } from 'firebase/firestore'

const firebaseConfig = {
  apiKey: 'AIzaSyCnZHgAQ-_wAQGOk_X9sud_BlPYRb9TXGo',
  authDomain: 'herdiq-prod.firebaseapp.com',
  projectId: 'herdiq-prod',
  storageBucket: 'herdiq-prod.firebasestorage.app',
  messagingSenderId: '797006457224',
  appId: '1:797006457224:web:e24ddd0e772354f519323d',
  measurementId: 'G-9LFEJZD484',
}

const app = initializeApp(firebaseConfig)
export const auth = getAuth(app)
export const db = getFirestore(app)
