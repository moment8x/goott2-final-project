import React, { useMemo, useState } from 'react';
import Card from '@/components/ui/Card';
import ImageBlock2 from '@/components/partials/widget/block/image-block-2';
import GroupChart2 from '@/components/partials/widget/chart/group-chart-2';
import RevenueBarChart from '@/components/partials/widget/chart/revenue-bar-chart';
import ProfitChart from '../../components/partials/widget/chart/profit-chart';
import OrderChart from '../../components/partials/widget/chart/order-chart';
import EarningChart from '../../components/partials/widget/chart/earning-chart';
import SelectMonth from '@/components/partials/SelectMonth';
import Customer from '../../components/partials/widget/customer';
import RecentOrderTable from '../../components/partials/Table/recentOrder-table';
import BasicArea from '../chart/appex-chart/BasicArea';
import VisitorRadar from '../../components/partials/widget/chart/visitor-radar';
import MostSales2 from '../../components/partials/widget/most-sales2';
import Products from '../../components/partials/widget/products';
import HomeBredCurbs from '../dashboard/HomeBredCurbs';
import { useTable, useRowSelect, useSortBy, usePagination } from 'react-table';

const COLUMNS = [
  {
    Header: '순위',
    accessor: 'rank',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '상품코드',
    accessor: 'productId',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '',
    accessor: 'productImage',
    Cell: (row) => {
      return <img src={row?.cell?.value} width='40' />;
    },
  },
  {
    Header: '상품명',
    accessor: 'productName',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '판매가',
    accessor: 'sellingPrice',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '재고',
    accessor: 'currentQuantity',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '결제수량',
    accessor: 'paymentQuantity',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '환불수량',
    accessor: 'refundQuantity',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '판매수량',
    accessor: 'salesQuantity',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '판매합계',
    accessor: 'totalSales',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
];

const StatisticsPage = () => {
  const [data, setData] = useState([]);
  const [filterMap, setFilterMap] = useState('usa');
  const columns = useMemo(() => COLUMNS, []);

  useEffect(() => {
    fetch('http://localhost:8081/admin/statistics/dashboard', { method: 'GET' })
      .then((res) => res.json())
      .then((res) => {
        console.log('res:', res);
        setData(res.productRankingList);
      })
      .catch((error) => {
        console.error('Error :', error);
      });
  }, []);

  const tableInstance = useTable(
    {
      columns,
      data,
    },

    useSortBy,
    usePagination,
    useRowSelect
  );
  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    footerGroups,
    page,
    nextPage,
    previousPage,
    canNextPage,
    canPreviousPage,
    pageOptions,
    state,
    gotoPage,
    pageCount,
    setPageSize,
    prepareRow,
  } = tableInstance;

  return (
    <div>
      <HomeBredCurbs title='통계 대시보드' />
      <div className='grid grid-cols-12 gap-5 mb-5'>
        <div className='2xl:col-span-3 lg:col-span-4 col-span-12'>
          <ImageBlock2 />
        </div>
        <div className='2xl:col-span-9 lg:col-span-8 col-span-12'>
          <div className='grid md:grid-cols-3 grid-cols-1 gap-4'>
            <GroupChart2 />
          </div>
        </div>
      </div>
      <div className='grid grid-cols-12 gap-5'>
        <div className='2xl:col-span-8 lg:col-span-7 col-span-12'>
          <Card>
            <div className='md:flex items-center mb-6'></div>
            <h4 className='card-title font-black mb-3'>{title}</h4>
            <div className='overflow-x-auto -mx-6'>
              <div className='inline-block min-w-full align-middle'>
                <div className='overflow-hidden '>
                  <table
                    className='min-w-full divide-y divide-slate-100 table-fixed dark:divide-slate-700'
                    {...getTableProps}
                  >
                    <thead className='bg-slate-200 dark:bg-slate-700'>
                      {headerGroups.map((headerGroup) => (
                        <tr {...headerGroup.getHeaderGroupProps()}>
                          {headerGroup.headers.map((column) => (
                            <th
                              {...column.getHeaderProps(column.getSortByToggleProps())}
                              scope='col'
                              className='table-th'
                            >
                              {column.render('Header')}
                              <span>{column.isSorted ? (column.isSortedDesc ? ' 🔽' : ' 🔼') : ''}</span>
                            </th>
                          ))}
                        </tr>
                      ))}
                    </thead>
                    <tbody
                      className='bg-white divide-y divide-slate-100 dark:bg-slate-800 dark:divide-slate-700'
                      {...getTableBodyProps}
                    >
                      {page.map((row) => {
                        prepareRow(row);
                        return (
                          <tr {...row.getRowProps()}>
                            {row.cells.map((cell, index) => {
                              return (
                                <td
                                  {...cell.getCellProps()}
                                  className={`${
                                    index < 3
                                      ? 'table-td cursor-pointer text-center'
                                      : index == 3
                                      ? 'table-td cursor-pointer text-left pr-0'
                                      : 'table-td cursor-pointer text-right pr-10'
                                  }`}
                                >
                                  {cell.render('Cell')}
                                </td>
                              );
                            })}
                          </tr>
                        );
                      })}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </Card>
        </div>
        <div className='2xl:col-span-4 lg:col-span-5 col-span-12'></div>
        <div className='xl:col-span-6 col-span-12'></div>
        <div className='xl:col-span-6 col-span-12'></div>
        <div className='xl:col-span-8 lg:col-span-7 col-span-12'></div>
        <div className='xl:col-span-4 lg:col-span-5 col-span-12'></div>
        <div className='xl:col-span-6 col-span-12'></div>
        <div className='xl:col-span-6 col-span-12'>
          <Card title='Best selling products' headerslot={<SelectMonth />}>
            <Products />
          </Card>
        </div>
      </div>
    </div>
  );
};

export default StatisticsPage;
