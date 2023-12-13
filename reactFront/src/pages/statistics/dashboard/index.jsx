import Card from '@/components/ui/Card';
import { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import BestProduct from './best-products';
import DashboardCartRank from './cart-top10';
import DashboardCategoryRankMonth from './category-monthly-top5';
import DashboardCategoryRankWeek from './category-weekly-top5';
import DashboardInfo from './info';
import DashboardProductRank from './product-top10';
import DashboardReturnQuantityRank from './return-quantity-top5';
import DashboardReturnRateRank from './return-rate-top5';

const StatisticsPage = () => {
  const [bestData, setBestData] = useState([]);
  const [productData, setProductData] = useState([]);
  const [cartData, setCartData] = useState([]);
  const [returnQuantityData, setReturnQuantity] = useState([]);
  const [returnRateData, setReturnRateData] = useState([]);
  const [categoryWeeklyData, setCategoryWeeklyData] = useState([]);
  const [categoryMonthlyData, setCategoryMonthlyData] = useState([]);

  useEffect(() => {
    fetch('http://localhost:8081/admin/statistics/dashboard', { method: 'GET' })
      .then((res) => res.json())
      .then((res) => {
        console.log('res:', res);
        setBestData(res.bestSellerList);
        setProductData(res.productRankingTop10);
        setCartData(res.cartRankingTop10);
        setReturnQuantity(res.returnRankingTop5Quantity);
        setReturnRateData(res.returnRankingTop5Rate);
        setCategoryMonthlyData(res.categoryRankingLastMonthTop5);
        setCategoryWeeklyData(res.categoryRankingWeeklyTop5);
      })
      .catch((error) => {
        console.error('Error :', error);
      });
  }, []);

  return (
    <div className='container'>
      <DashboardInfo />
      <div className=''>
        <Card title='많이 팔린 상품'>
          <BestProduct bestData={bestData} />
        </Card>
      </div>
      <div className='flex justify-center items-center flex-col'>
        <ul className='flex flex-wrap flex-row justify-between items-start'>
          <li className='w-[550px] mt-5'>
            <DashboardProductRank productData={productData} />
          </li>
          <li className='w-[550px] mt-5'>
            <DashboardCartRank cartData={cartData} />
          </li>
          <li className='w-[550px] mt-5'>
            <DashboardReturnQuantityRank returnQuantityData={returnQuantityData} />
          </li>
          <li className='w-[550px] mt-5'>
            <DashboardReturnRateRank returnRateData={returnRateData} />
          </li>
          <li className='w-[550px] mt-5'>
            <DashboardCategoryRankWeek categoryWeeklyData={categoryWeeklyData} />
          </li>
          <li className='w-[550px] mt-5'>
            <DashboardCategoryRankMonth categoryMonthlyData={categoryMonthlyData} />
          </li>
        </ul>
      </div>
      <Outlet />
    </div>
  );
};

export default StatisticsPage;
