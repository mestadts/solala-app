import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { useAuth } from './hooks/useAuth'
import Layout from './components/Layout'
import LoginPage from './pages/LoginPage'
import DashboardPage from './pages/DashboardPage'
import UsersPage from './pages/UsersPage'
import OrganizationsPage from './pages/OrganizationsPage'
import OrgDetailPage from './pages/OrgDetailPage'
import AnimalsPage from './pages/AnimalsPage'
import BreedsPage from './pages/BreedsPage'
import ColorsPage from './pages/ColorsPage'
import VaccinesPage from './pages/VaccinesPage'
import MedicationsPage from './pages/MedicationsPage'
import AgeClassesPage from './pages/AgeClassesPage'
import CountriesPage from './pages/CountriesPage'
import AnalyticsPage from './pages/AnalyticsPage'
import NotificationsPage from './pages/NotificationsPage'
import CustomFieldsPage from './pages/CustomFieldsPage'
import AdminsPage from './pages/AdminsPage'
import SpeciesTermsPage from './pages/SpeciesTermsPage'

export default function App() {
  const { user, loading, isAdmin, login, logout } = useAuth()

  if (loading) {
    return (
      <div className="min-h-screen bg-[#FAF6EF] flex items-center justify-center font-['Inter']">
        <div className="text-center">
          <div className="text-5xl mb-4">🐄</div>
          <div className="text-gray-500 text-sm">Loading HerdIQ Admin…</div>
        </div>
      </div>
    )
  }

  if (!user) {
    return <LoginPage onLogin={login} />
  }

  // User is logged in but not yet an admin — show their UID for bootstrapping
  if (!isAdmin) {
    return (
      <div className="min-h-screen bg-[#FAF6EF] flex items-center justify-center font-['Inter'] p-4">
        <div className="bg-white rounded-2xl shadow-lg p-8 w-full max-w-md space-y-5">
          <div className="text-center">
            <div className="text-4xl mb-3">🔒</div>
            <h1 className="text-xl font-bold text-[#3B1500]">Access Not Granted</h1>
            <p className="text-sm text-gray-500 mt-2">
              Your account is not authorized as an admin yet.
              Ask an existing admin to add your UID to the admin panel.
            </p>
          </div>
          <div className="bg-gray-50 border border-gray-200 rounded-xl p-4 space-y-2">
            <p className="text-xs font-semibold text-gray-500 uppercase tracking-wide">Your Firebase UID</p>
            <p className="font-mono text-sm text-gray-800 break-all select-all">{user.uid}</p>
            <p className="text-xs text-gray-400">Email: {user.email}</p>
          </div>
          <p className="text-xs text-amber-700 bg-amber-50 border border-amber-200 rounded-lg px-3 py-2">
            Copy the UID above and paste it into the Admin Panel → Admin Users → Add Existing.
            Alternatively, go to Firebase Console → Firestore → admins collection → add a document
            with ID = your UID.
          </p>
          <button
            onClick={logout}
            className="w-full py-2.5 border border-gray-200 rounded-lg text-sm text-gray-600 hover:bg-gray-50 transition-colors"
          >
            Sign Out
          </button>
        </div>
      </div>
    )
  }

  return (
    <BrowserRouter>
      <Routes>
        <Route element={<Layout onLogout={logout} />}>
          <Route index element={<Navigate to="/dashboard" replace />} />
          <Route path="dashboard" element={<DashboardPage />} />
          <Route path="users" element={<UsersPage />} />
          <Route path="organizations" element={<OrganizationsPage />} />
          <Route path="organizations/:orgId" element={<OrgDetailPage />} />
          <Route path="animals" element={<AnimalsPage />} />
          <Route path="breeds" element={<BreedsPage />} />
          <Route path="colors" element={<ColorsPage />} />
          <Route path="vaccines" element={<VaccinesPage />} />
          <Route path="medications" element={<MedicationsPage />} />
          <Route path="age-classes" element={<AgeClassesPage />} />
          <Route path="countries" element={<CountriesPage />} />
          <Route path="analytics" element={<AnalyticsPage />} />
          <Route path="notifications" element={<NotificationsPage />} />
          <Route path="custom-fields" element={<CustomFieldsPage />} />
          <Route path="species-terms" element={<SpeciesTermsPage />} />
          <Route path="admins" element={<AdminsPage />} />
          <Route path="*" element={<Navigate to="/dashboard" replace />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}
