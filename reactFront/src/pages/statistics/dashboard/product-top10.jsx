import React, { useEffect, useMemo, useState } from 'react';
import Card from '@/components/ui/Card';
import ImageBlock2 from '@/components/partials/widget/block/image-block-2';
import GroupChart2 from '@/components/partials/widget/chart/group-chart-2';
import RevenueBarChart from '@/components/partials/widget/chart/revenue-bar-chart';
import ProfitChart from '../../../components/partials/widget/chart/profit-chart';
import OrderChart from '../../../components/partials/widget/chart/order-chart';
import EarningChart from '../../../components/partials/widget/chart/earning-chart';
import SelectMonth from '@/components/partials/SelectMonth';
import Customer from '../../../components/partials/widget/customer';
import RecentOrderTable from '../../../components/partials/Table/recentOrder-table';
import BasicArea from '../../chart/appex-chart/BasicArea';
import VisitorRadar from '../../../components/partials/widget/chart/visitor-radar';
import MostSales2 from '../../../components/partials/widget/most-sales2';
import Products from '../../../components/partials/widget/products';
import HomeBredCurbs from '../../dashboard/HomeBredCurbs';
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
    Header: '상품명',
    accessor: 'productName',
    Cell: (row) => {
      return <span className=''>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '개수',
    accessor: 'salesQuantity',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
];

const DashboardProductRank = ({ title = '오늘 상품 판매량 순위 TOP 10', productData }) => {
  const columns = useMemo(() => COLUMNS, []);

  const tableInstance = useTable(
    {
      columns,
      data: productData,
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
      <div className=''>
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
                              className='table-th '
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
                                    index !== 1
                                      ? 'table-td cursor-pointer text-center w-[80px]'
                                      : 'table-td cursor-pointer text-left pr-0'
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
      </div>
    </div>
  );
};

export default DashboardProductRank;
