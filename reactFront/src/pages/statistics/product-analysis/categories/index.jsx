import React, { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import RankingChart from '../chart/ranking-chart';
import CategoryRanking from './category-ranking';
import CategoryResult from './category-result';

const CategoryRankingInfo = () => {
  const [data, setData] = useState([]);
  const [salesQuantityData, setSalesQuantityData] = useState([]);
  const [totalSalesData, setTotalSalesData] = useState([]);

  return (
    <div className='space-y-5'>
      <CategoryRanking
        setData={setData}
        data={data}
        setSalesQuantityData={setSalesQuantityData}
        setTotalSalesData={setTotalSalesData}
      />

      <div className='bg-white rounded-lg'>
        <h6 className='font-bold pl-6 pt-5'>통계 그래프</h6>
        <div className='flex justify-evenly  p-5'>
          <RankingChart salesQuantityData={salesQuantityData} label={'TOP 10 분류 (판매수량)'} />
          <RankingChart totalSalesData={totalSalesData} label={'TOP 10 분류 (판매합계)'} />
        </div>
      </div>

      <CategoryResult data={data} />
      <Outlet />
    </div>
  );
};

export default CategoryRankingInfo;
