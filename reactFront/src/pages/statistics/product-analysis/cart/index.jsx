import React, { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import CartResult from './cart-result';
import UserStorageChart from '../chart/userStorage-chart';
import CartAnalysis from './cart-analysis';

const CartInfo = () => {
  const [data, setData] = useState([]);
  const [cartQuantity, setCartQuantity] = useState([]);

  return (
    <div className='space-y-5'>
      <CartAnalysis setData={setData} data={data} setCartQuantity={setCartQuantity} />
      <div className='rounded-lg bg-white p-1'>
        <h6 className='font-bold pl-6 pt-5'>통계 그래프</h6>
        <UserStorageChart cartQuantity={cartQuantity} label={'장바구니상품 TOP 10'} />
      </div>
      <CartResult data={data} />
      <Outlet />
    </div>
  );
};

export default CartInfo;
