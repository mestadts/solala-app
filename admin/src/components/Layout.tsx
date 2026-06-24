import { Outlet } from 'react-router-dom'
import Sidebar from './Sidebar'

interface Props { onLogout: () => void }

export default function Layout({ onLogout }: Props) {
  return (
    <div className="flex min-h-screen bg-gray-50 font-['Inter']">
      <Sidebar onLogout={onLogout} />
      <main className="flex-1 overflow-auto">
        <Outlet />
      </main>
    </div>
  )
}
