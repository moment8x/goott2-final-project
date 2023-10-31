import React, { lazy, Suspense } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';

// home pages  & dashboard
//import Dashboard from "./pages/dashboard";
const Test = lazy(() => import('./pages/test'));
const Ecommerce = lazy(() => import('./pages/dashboard/ecommerce'));
const CrmPage = lazy(() => import('./pages/dashboard/crm'));
const MemberInfo = lazy(() => import('./pages/member-info/index'));

const Login = lazy(() => import('./pages/auth/login'));
const Register = lazy(() => import('./pages/auth/register'));
const Register2 = lazy(() => import('./pages/auth/register2'));
const Register3 = lazy(() => import('./pages/auth/register3'));
const ForgotPass = lazy(() => import('./pages/auth/forgot-password'));
const ForgotPass2 = lazy(() => import('./pages/auth/forgot-password2'));
const ForgotPass3 = lazy(() => import('./pages/auth/forgot-password3'));
const LockScreen = lazy(() => import('./pages/auth/lock-screen'));
const LockScreen2 = lazy(() => import('./pages/auth/lock-screen2'));
const LockScreen3 = lazy(() => import('./pages/auth/lock-screen3'));

import Layout from './layout/Layout';
import AuthLayout from './layout/AuthLayout';

function App() {
  return (
    <main className="App  relative">
      <Routes>
        <Route path="/admin" element={<AuthLayout />}>
          <Route path="/admin" element={<Login />} />
          {/* <Route path="/register" element={<Register />} />
          <Route path="/register2" element={<Register2 />} />
          <Route path="/register3" element={<Register3 />} />
          <Route path="/forgot-password" element={<ForgotPass />} />
          <Route path="/forgot-password2" element={<ForgotPass2 />} />
          <Route path="/forgot-password3" element={<ForgotPass3 />} />
          <Route path="/lock-screen" element={<LockScreen />} />
          <Route path="/lock-screen2" element={<LockScreen2 />} />
          <Route path="/lock-screen3" element={<LockScreen3 />} /> */}
        </Route>
        <Route path="/*" element={<Layout />}>
          <Route index element={<Navigate to="admin/home" />} />
          <Route path="admin/home" element={<Ecommerce />} />
          <Route path="admin/members/dashboard" element={<CrmPage />} />
          <Route path="admin/members/member-info" element={<MemberInfo />} />
        </Route>
      </Routes>
    </main>
  );
}

export default App;
