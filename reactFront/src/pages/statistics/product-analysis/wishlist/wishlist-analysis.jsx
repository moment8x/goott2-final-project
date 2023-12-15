import React, { useEffect, useMemo, useState } from 'react';
import Card from '@/components/ui/Card';
import Button from '@/components/ui/Button';
import Flatpickr from 'react-flatpickr';

const WishlistAnalysis = ({ setWishlistQuantity, setData, data }) => {
  const [picker, setPicker] = useState();
  const [picker2, setPicker2] = useState();

  useEffect(() => {
    fetch('http://localhost:8081/admin/statistics/wishlist?dateStart&dateEnd', { method: 'GET' })
      .then((res) => res.json())
      .then((res) => {
        console.log('res:', res);
        setData(res.wishlistInfoList);
        setWishlistQuantity(res.WishlistTop10List);
      })
      .catch((error) => {
        console.error('Error :', error);
      });
  }, []);

  // 검색 버튼
  const handleSubmit = (e) => {
    e.preventDefault();
    fetch('http://localhost:8081/admin/statistics/wishlist?dateStart&dateEnd', { method: 'GET' })
      .then((res) => res.json())
      .then((res) => {
        console.log('res:', res);
        setData(res.wishlistInfoList);
        setWishlistQuantity(res.WishlistTop10List);
      })
      .catch((error) => {
        console.error('Error :', error);
      });
  };

  return (
    <div>
      <Card title='관심상품 순위 내역' noborder className='font-bold'>
        <div className='overflow-x-auto '>
          <div className='inline-block min-w-full align-middle'>
            <div className='overflow-hidden '>
              <table className='min-w-full border border-slate-100 table-fixed dark:border-slate-700 border-collapse'>
                <tbody className='bg-white '>
                  <tr>
                    <td className='table-td border border-slate-100 dark:bg-slate-800 dark:border-slate-700'>
                      <p className='text-base'>기간</p>
                    </td>
                    <td className='table-td border border-slate-100 dark:bg-slate-800 dark:border-slate-700'>
                      <Button text='오늘' className='btn-outline-dark flex items-center w-12 h-10 mr-1' />
                      <Button text='어제' className='btn-outline-dark flex items-center w-12 h-10 mr-1' />
                      <Button text='3일' className='btn-outline-dark flex items-center w-12 h-10 mr-1' />
                      <Button text='7일' className='btn-outline-dark flex items-center w-12 h-10 mr-1' />
                      <Button text='1개월' className='btn-outline-dark flex items-center w-12 h-10 mr-1' />
                      <Button text='3개월' className='btn-outline-dark flex items-center w-12 h-10 mr-1' />
                      <Button text='6개월' className='btn-outline-dark flex items-center w-12 h-10 mr-1' />
                      <Flatpickr
                        className='form-control py-2 w-[120px] align-middle inline-block ml-3'
                        value={picker}
                        onChange={(date) => setPicker(date)}
                        id='default-picker3'
                      />
                      <p className='ml-[10px] mr-[10px] align-middle inline-block'> ~ </p>
                      <Flatpickr
                        className='form-control py-2 w-[120px] align-middle inline-block '
                        value={picker2}
                        onChange={(date) => setPicker2(date)}
                        id='default-picker4'
                      />
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </Card>
      <div className='box box-warning flex justify-center gap-3 m-3'>
        <button className='btn btn-dark flex items-center' onClick={handleSubmit}>
          검&nbsp;&nbsp;&nbsp;&nbsp;색
        </button>
      </div>
    </div>
  );
};

export default WishlistAnalysis;
