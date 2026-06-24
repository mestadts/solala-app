import { useState, useEffect } from 'react'
import { onAuthStateChanged, signInWithEmailAndPassword, signOut } from 'firebase/auth'
import { doc, getDoc } from 'firebase/firestore'
import type { User } from 'firebase/auth'
import { auth, db } from '../firebase/config'

export function useAuth() {
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)
  const [isAdmin, setIsAdmin] = useState(false)

  useEffect(() => {
    const unsub = onAuthStateChanged(auth, async (u) => {
      setUser(u)
      if (u) {
        // Bootstrap fallback: hardcoded UID always has access
        // All other admins are checked via Firestore admins collection
        const BOOTSTRAP_UID = 'imi48i5pxcRpxOf8kNLNFL9b5LG2'
        if (u.uid === BOOTSTRAP_UID) {
          setIsAdmin(true)
        } else {
          try {
            const snap = await getDoc(doc(db, 'admins', u.uid))
            setIsAdmin(snap.exists())
          } catch {
            setIsAdmin(false)
          }
        }
      } else {
        setIsAdmin(false)
      }
      setLoading(false)
    })
    return unsub
  }, [])

  const login = async (email: string, password: string): Promise<void> => {
    await signInWithEmailAndPassword(auth, email, password)
  }

  const logout = () => signOut(auth)

  return { user, loading, isAdmin, login, logout }
}
