import Card from '@/components/ui/Card';
import React from 'react';

const IncomeFluctuation = ({ data }) => {
  console.log('Fluctuation data: ', data);
  return (
    <div>
      {/* <Card title='증감 추이' noborder className='font-bold'>
        <div className='overflow-x-auto '>
          <div className='inline-block min-w-full align-middle'>
            <div className='overflow-hidden '>
              <table className='min-w-full border border-slate-100 table-fixed dark:border-slate-700 border-collapse'>
                <thead className=''>
                  <tr>
                    <th className='table-th'>기간</th>
                    <th className='table-th' colSpan='2'>
                      결제합계
                    </th>
                    <th className='table-th' colSpan='2'>
                      환불합계
                    </th>
                    <th className='table-th' colSpan='2'>
                      순매출
                    </th>
                  </tr>
                </thead>
                <tbody className='bg-white '>
                  <tr>
                    <td className='table-basic-td'>{data[0].date}</td>
                    <td className='table-basic-td'>{data[0].totalPaymentAmount}</td>
                    <td className='table-basic-td' rowSpan='2'>
                      {((data[0].totalPaymentAmount - data[1].totalPaymentAmount) / data[1].totalPaymentAmount) * 100 +
                        '%'}
                    </td>
                    <td className='table-basic-td'>{data[0].totalRefundAmount}</td>
                    <td className='table-basic-td' rowSpan='2'>
                      {((data[0].totalRefundAmount - data[1].totalRefundAmount) / data[1].totalRefundAmount) * 100 +
                        '%'}
                    </td>
                    <td className='table-basic-td'>{data[0].netSales}</td>
                    <td className='table-basic-td' rowSpan='2'>
                      {((data[0].netSales - data[1].netSales) / data[1].netSales) * 100 + '%'}
                    </td>
                  </tr>
                  <tr>
                    <td className='table-basic-td'>{data[1].date}</td>
                    <td className='table-basic-td'>{data[1].totalPaymentAmount}</td>
                    <td className='table-basic-td'>{data[1].totalRefundAmount}</td>
                    <td className='table-basic-td'>{data[1].netSales}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </Card> */}
    </div>
  );
};

export default IncomeFluctuation;
