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
        <UserStorageChart wishlistQuantity={wishlistQuantity} label={'관심상품 TOP 10'} />
      </div>
      <WishlistResult data={data} />
      <Outlet />
    </div>
  );
};

export default WishlistInfo;
