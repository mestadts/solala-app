import { NavLink } from 'react-router-dom'
import {
  LayoutDashboard, Users, Building2, Dog, Dna, Palette,
  Syringe, FlaskConical, CalendarDays, Globe, BarChart3,
  Bell, LogOut, Sliders, ShieldCheck, VenetianMask,
} from 'lucide-react'
import clsx from 'clsx'

const nav = [
  { label: 'Dashboard', icon: LayoutDashboard, to: '/dashboard' },
  { label: 'Users', icon: Users, to: '/users' },
  { label: 'Organizations', icon: Building2, to: '/organizations' },
  { label: 'Animals', icon: Dog, to: '/animals' },
  { divider: true },
  { label: 'Breed Lists', icon: Dna, to: '/breeds' },
  { label: 'Color Lists', icon: Palette, to: '/colors' },
  { label: 'Vaccines', icon: Syringe, to: '/vaccines' },
  { label: 'Medications', icon: FlaskConical, to: '/medications' },
  { label: 'Age Classes', icon: CalendarDays, to: '/age-classes' },
  { label: 'Country Templates', icon: Globe, to: '/countries' },
  { label: 'Custom Fields', icon: Sliders, to: '/custom-fields' },
  { label: 'Species Terms', icon: VenetianMask, to: '/species-terms' },
  { divider: true },
  { label: 'Analytics', icon: BarChart3, to: '/analytics' },
  { label: 'Notifications', icon: Bell, to: '/notifications' },
  { label: 'Admin Users', icon: ShieldCheck, to: '/admins' },
]

interface Props { onLogout: () => void }

export default function Sidebar({ onLogout }: Props) {
  return (
    <aside className="w-60 min-h-screen bg-[#3B1500] flex flex-col">
      {/* Logo */}
      <div className="px-6 py-5 border-b border-white/10">
        <div className="text-white font-bold text-xl tracking-tight">🐄 HerdIQ</div>
        <div className="text-white/50 text-xs mt-0.5">Admin Panel</div>
      </div>

      {/* Nav */}
      <nav className="flex-1 py-4 overflow-y-auto">
        {nav.map((item, i) =>
          'divider' in item ? (
            <div key={i} className="my-2 mx-4 border-t border-white/10" />
          ) : (
            <NavLink
              key={item.to}
              to={item.to!}
              className={({ isActive }) =>
                clsx(
                  'flex items-center gap-3 px-5 py-2.5 mx-2 rounded-lg text-sm transition-colors',
                  isActive
                    ? 'bg-white/15 text-white font-medium'
                    : 'text-white/60 hover:text-white hover:bg-white/10',
                )
              }
            >
              <item.icon size={16} />
              {item.label}
            </NavLink>
          ),
        )}
      </nav>

      {/* Logout */}
      <button
        onClick={onLogout}
        className="flex items-center gap-3 px-5 py-4 text-white/50 hover:text-white text-sm border-t border-white/10 transition-colors"
      >
        <LogOut size={16} />
        Logout
      </button>
    </aside>
  )
}
