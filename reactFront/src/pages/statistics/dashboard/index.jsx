import SelectMonth from '@/components/partials/SelectMonth';
import Products from '@/components/partials/widget/products';
import Card from '@/components/ui/Card';
import { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import DashboardCartRank from './cart-top10';
import DashboardCategoryRank from './category-top5';
import DashboardProductRank from './product-top10';
import DashboardReturnQuantityRank from './return-quantity-top5';
import DashboardReturnRateRank from './return-rate-top5';
import DashboardInfo from './info';

const StatisticsPage = () => {
  const [productData, setProductData] = useState([]);
  const [cartData, setCartData] = useState([]);
  const [returnQuantityData, setReturnQuantity] = useState([]);
  const [returnRateData, setReturnRateData] = useState([]);
  const [categoryData, setCategoryData] = useState([]);

  useEffect(() => {
    fetch('http://localhost:8081/admin/statistics/dashboard', { method: 'GET' })
      .then((res) => res.json())
      .then((res) => {
        console.log('res:', res);
        setProductData(res.productRankingTop10);
        setCartData(res.cartRankingTop10);
        setReturnQuantity(res.returnRankingTop5Quantity);
        setReturnRateData(res.returnRankingTop5Rate);
        setCategoryData(res.categoryRankingLastMonthTop5);
      })
      .catch((error) => {
        console.error('Error :', error);
      });
  }, []);

  return (
    <div className='space-y-5'>
      <DashboardInfo />
      <div className='flex justify-center items-center flex-col'>
        <ul className='flex flex-wrap flex-row justify-center items-center'>
          <li className='flex flex-row justify-center items-center w-1/2 m[10px]'>
            <DashboardProductRank productData={productData} />
          </li>
          <li className='flex flex-row justify-center items-center w-1/2 m[10px]'>
            <DashboardCartRank cartData={cartData} />
          </li>
          <li className='flex flex-row justify-center items-center w-1/2 m[10px]'>
            <DashboardReturnQuantityRank returnQuantityData={returnQuantityData} />
          </li>
          <li className='flex flex-row justify-center items-center w-1/2 m[10px]'>
            <DashboardReturnRateRank returnRateData={returnRateData} />
          </li>
          <li className='flex flex-row justify-center items-center w-1/2 m[10px]'>
            <DashboardCategoryRank categoryData={categoryData} />
          </li>
        </ul>
      </div>
      <Card title='Best selling products' headerslot={<SelectMonth />}>
        <Products />
      </Card>
      <Outlet />
    </div>
  );
};

export default StatisticsPage;
