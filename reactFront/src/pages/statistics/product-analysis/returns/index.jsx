import React, { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import ReturnResult from './return-result';
import ReturnChart from '../chart/return-chart';
import ReturnRanking from './return-ranking';

const ReturnRankingInfo = () => {
  const [data, setData] = useState([]);
  const [refundQuantityData, setRefundQuantityData] = useState([]);
  const [returnRateData, setReturnRateData] = useState([]);

  return (
    <div className='space-y-5'>
      <ReturnRanking
        setData={setData}
        data={data}
        setRefundQuantityData={setRefundQuantityData}
        setReturnRateData={setReturnRateData}
      />

      <div className='bg-white rounded-lg'>
        <h6 className='font-bold pl-6 pt-5'>통계 그래프</h6>
        <div className='flex justify-evenly  p-5'>
          <ReturnChart refundQuantityData={refundQuantityData} label={'취소/반품 TOP 10(환불수량)'} />
          <ReturnChart returnRateData={returnRateData} label={'취소/반품 TOP 10(반품비율)'} />
        </div>
      </div>

      <ReturnResult data={data} />
      <Outlet />
    </div>
  );
};

export default ReturnRankingInfo;
