import React, { lazy, Suspense } from 'react';
import { Routes, Route, Navigate, useLocation } from 'react-router-dom';

// home pages  & dashboard
//import Dashboard from "./pages/dashboard";
const Ecommerce = lazy(() => import('./pages/dashboard/ecommerce'));
const CrmDashboard = lazy(() => import('./pages/dashboard/crm'));
const MemberInfo = lazy(() => import('./pages/members/search/index'));
const MemberInfoModal = lazy(() => import('./pages/members/search/member-modal'));
const SearchedMember = lazy(() => import('./pages/members/search/member-result'));

const ProductPage = lazy(() => import("./pages/dashboard/Product"));
const ProductInfo = lazy(() => import("./pages/product-info/index"));
const ProductRegister = lazy(() => import("./pages/product-register/index"));

const Login = lazy(() => import("./pages/auth/login"));
const Register = lazy(() => import("./pages/auth/register"));
const Register2 = lazy(() => import("./pages/auth/register2"));
const Register3 = lazy(() => import("./pages/auth/register3"));
const ForgotPass = lazy(() => import("./pages/auth/forgot-password"));
const ForgotPass2 = lazy(() => import("./pages/auth/forgot-password2"));
const ForgotPass3 = lazy(() => import("./pages/auth/forgot-password3"));
const LockScreen = lazy(() => import("./pages/auth/lock-screen"));
const LockScreen2 = lazy(() => import("./pages/auth/lock-screen2"));
const LockScreen3 = lazy(() => import("./pages/auth/lock-screen3"));

import Layout from "./layout/Layout";
import AuthLayout from "./layout/AuthLayout";
import Error from './pages/404';
// import MemberInfoModal from './pages/members/search/member-modal';

function App() {
  const location = useLocation();
  // const background = location.state && location.state.backgroundLocation;
  let state = location.state;
  console.log('location: ', location);

  return (
    <main className='App  relative'>
      {/* <Routes location={state?.backgroundLocation || location}> */}
      <Routes>
        {/* <Route path='/admin' element={<AuthLayout />}>
          <Route path='/admin' element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/register2" element={<Register2 />} />
          <Route path="/register3" element={<Register3 />} />
          <Route path="/forgot-password" element={<ForgotPass />} />
          <Route path="/forgot-password2" element={<ForgotPass2 />} />
          <Route path="/forgot-password3" element={<ForgotPass3 />} />
          <Route path="/lock-screen" element={<LockScreen />} />
          <Route path="/lock-screen2" element={<LockScreen2 />} />
          <Route path="/lock-screen3" element={<LockScreen3 />} />
        </Route> */}
        <Route path='/' element={<Layout />}>
          <Route index element={<Navigate to='admin/home' />} />
          <Route path='admin/home' element={<Ecommerce />} />
          <Route path='admin/members' element={<Navigate to='dashboard' />} />
          <Route path='admin/members/dashboard' element={<CrmDashboard />} />
          <Route path='admin/members/search' element={<MemberInfo />} />
          {/* <Route path='admin/members/search/detail' element={<MemberCrmPage />} /> */}
          <Route path="admin/products/dashboard" element={<ProductPage />} />
          <Route path="admin/products/product-info" element={<ProductInfo />} />
          <Route
            path="admin/products/product-register"
            element={<ProductRegister />}
          />
          <Route path='/*' element={<Error />} />
        </Route>
      </Routes>
    </main>
  );
}

export default App;
