import React, { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import UserStorageChart from '../chart/userStorage-chart';
import WishlistAnalysis from './wishlist-analysis';
import WishlistResult from './wishlist-result';

const WishlistInfo = () => {
  const [data, setData] = useState([]);
  const [wishlistQuantity, setWishlistQuantity] = useState([]);

  return (
    <div className='space-y-5'>
      <WishlistAnalysis setData={setData} data={data} setWishlistQuantity={setWishlistQuantity} />
      <div className='rounded-lg bg-white p-1'>
        <h6 className='font-bold pl-6 pt-5'>통계 그래프</h6>
        <UserStorageChart wishlistQuantity={wishlistQuantity} label={'관심상품 TOP 10'} />
      </div>
      <WishlistResult data={data} />
      <Outlet />
    </div>
  );
};

export default WishlistInfo;
