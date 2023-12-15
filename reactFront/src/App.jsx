import { lazy } from 'react';
import { Navigate, Route, Routes, useLocation } from 'react-router-dom';

// home pages  & dashboard
//import Dashboard from "./pages/dashboard";
const Ecommerce = lazy(() => import('./pages/dashboard/ecommerce'));
const CrmDashboard = lazy(() => import('./pages/members/dashboard'));
const MemberInfo = lazy(() => import('./pages/members/search/index'));
const MemberInfoModal = lazy(() => import('./pages/members/search/member-modal'));
const SearchedMember = lazy(() => import('./pages/members/search/member-result'));

const ProductDashboard = lazy(() => import('./pages/dashboard/Product'));
const ProductInfo = lazy(() => import('./pages/products/search/index'));
const ProductRegister = lazy(() => import('./pages/products/register/index'));
const ProductStock = lazy(() => import('./pages/products/management/inventory/index'));

const StatisticsDashboard = lazy(() => import('./pages/statistics/dashboard/index'));
const DailyReport = lazy(() => import('./pages/statistics/revenue-analysis/daily/index'));
const WeeklyReport = lazy(() => import('./pages/statistics/revenue-analysis/weekly/index'));
const MonthlyReport = lazy(() => import('./pages/statistics/revenue-analysis/monthly'));
const RevenueAggregation = lazy(() => import('./pages/statistics/revenue-analysis/aggregation/index'));
const ProductRanking = lazy(() => import('./pages/statistics/product-analysis/products/index'));
const CategoryRanking = lazy(() => import('./pages/statistics/product-analysis/categories/index'));
const ReturnRanking = lazy(() => import('./pages/statistics/product-analysis/returns/index'));
const CartAnalysis = lazy(() => import('./pages/statistics/product-analysis/cart/index'));
const WishlistAnalysis = lazy(() => import('./pages/statistics/product-analysis/wishlist/index'));

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
import Error from './pages/error/404';
import Crm from './pages/members/search/crm';
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
          <Route path='admin' element={<Navigate to='home' />}>
            <Route index element={<Navigate to='admin/home' />} />
          </Route>
          <Route path='admin/home' element={<Ecommerce />} />
          <Route path='admin/members' element={<Navigate to='dashboard' />} />
          <Route path='admin/members/dashboard' element={<CrmDashboard />} />
          <Route path='admin/members/search' element={<MemberInfo />} />
          <Route path='admin/members/:memberId' element={<Crm />} />

          <Route path='admin/products' element={<Navigate to='dashboard' />} />
          <Route path='admin/products/dashboard' element={<ProductDashboard />} />
          <Route path='admin/products/search' element={<ProductInfo />} />
          <Route path='admin/products/register' element={<ProductRegister />} />
          <Route path='admin/products/inventory' element={<ProductStock />} />

          <Route path='admin/statistics/dashboard' element={<StatisticsDashboard />} />
          <Route path='admin/statistics/daily' element={<DailyReport />} />
          <Route path='admin/statistics/weekly' element={<WeeklyReport />} />
          <Route path='admin/statistics/monthly' element={<MonthlyReport />} />
          <Route path='admin/statistics/revenue' element={<RevenueAggregation />} />
          <Route path='admin/statistics/products' element={<ProductRanking />} />
          <Route path='admin/statistics/categories' element={<CategoryRanking />} />
          <Route path='admin/statistics/returns' element={<ReturnRanking />} />
          <Route path='admin/statistics/cart' element={<CartAnalysis />} />
          <Route path='admin/statistics/wishlist' element={<WishlistAnalysis />} />
        </Route>
        <Route path='/admin/*' element={<Error />} />
      </Routes>
    </main>
  );
}

export default App;
