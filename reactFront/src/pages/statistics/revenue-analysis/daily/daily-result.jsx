import React, { memo, useEffect, useMemo, useState } from 'react';
import Card from '@/components/ui/Card';
import Icon from '@/components/ui/Icon';
import Badge from '@/components/ui/Badge';
import Button from '@/components/ui/Button';
import Tooltip from '@/components/ui/Tooltip';
import { useTable, useRowSelect, useSortBy, usePagination } from 'react-table';

const COLUMNS = [
  {
    Header: '일자',
    accessor: 'date',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '주문수',
    accessor: 'orderCount',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '품목수',
    accessor: 'itemCount',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '상품구매금액',
    accessor: 'totalPurchaseAmount',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '배송비',
    accessor: 'shippingFee',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '쿠폰',
    accessor: 'coupon',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '적립금',
    accessor: 'reward',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '포인트',
    accessor: 'point',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '결제합계',
    accessor: 'totalPaymentAmount',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '환불합계',
    accessor: 'totalRefundAmount',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '순매출',
    accessor: 'netSales',
    Cell: (row) => {
      return <span>{(row?.cell?.value).toLocaleString('ko-KR')}</span>;
    },
  },
];

const DailyResult = ({ title = '일별 매출내역', data }) => {
  const columns = useMemo(() => COLUMNS, []);

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

  const { pageIndex, pageSize } = state;
  const length = data.length;

  const totalPages = useMemo(() => {
    return Math.ceil(length / pageSize);
  }, [length, pageSize]);

  // 페이징 블록 추가
  const pages = useMemo(() => {
    const start = Math.floor(pageIndex / 10) * 10;
    const end = start + 10 > totalPages ? totalPages : start + 10;
    return Array.from({ length: end - start }, (_, i) => start + i);
  }, [pageIndex, totalPages]);

  return (
    <>
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
                        <th {...column.getHeaderProps(column.getSortByToggleProps())} scope='col' className='table-th'>
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
                                index == 0
                                  ? 'table-td cursor-pointer text-center'
                                  : 'table-td cursor-pointer text-right pl-0 pr-14'
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
        <div className='md:flex md:space-y-0 space-y-5 justify-between mt-6 items-center'>
          <div className=' flex items-center space-x-3 rtl:space-x-reverse'>
            <select
              className='form-control py-2 w-max'
              value={pageSize}
              onChange={(e) => setPageSize(Number(e.target.value))}
            >
              {[10, 25, 50].map((pageSize) => (
                <option key={pageSize} value={pageSize}>
                  Show {pageSize}
                </option>
              ))}
            </select>
            <span className='text-sm font-medium text-slate-600 dark:text-slate-300'>
              Page{' '}
              <span>
                {pageIndex + 1} of {pageOptions.length}
              </span>
            </span>
          </div>
          <ul className='flex items-center  space-x-3  rtl:space-x-reverse'>
            <li className='text-xl leading-4 text-slate-900 dark:text-white rtl:rotate-180'>
              <button
                className={` ${!canPreviousPage ? 'opacity-50 cursor-not-allowed' : ''}`}
                onClick={() => gotoPage(0)}
                disabled={!canPreviousPage}
              >
                <Icon icon='heroicons:chevron-double-left-solid' />
              </button>
            </li>
            <li className='text-sm leading-4 text-slate-900 dark:text-white rtl:rotate-180'>
              <button
                className={` ${!canPreviousPage ? 'opacity-50 cursor-not-allowed' : ''}`}
                onClick={() => previousPage()}
                disabled={!canPreviousPage}
              >
                Prev
              </button>
            </li>
            {pages.map((page, pageIdx) => (
              <li key={pageIdx}>
                <button
                  href='#'
                  aria-current='page'
                  className={` ${
                    page === pageIndex
                      ? 'bg-slate-900 dark:bg-slate-600  dark:text-slate-200 text-white font-medium '
                      : 'bg-slate-100 dark:bg-slate-700 dark:text-slate-400 text-slate-900  font-normal  '
                  }    text-sm rounded leading-[16px] flex h-6 w-6 items-center justify-center transition-all duration-150`}
                  onClick={() => gotoPage(page)}
                >
                  {page + 1}
                </button>
              </li>
            ))}
            <li className='text-sm leading-4 text-slate-900 dark:text-white rtl:rotate-180'>
              <button
                className={` ${!canNextPage ? 'opacity-50 cursor-not-allowed' : ''}`}
                onClick={() => nextPage()}
                disabled={!canNextPage}
              >
                Next
              </button>
            </li>
            <li className='text-xl leading-4 text-slate-900 dark:text-white rtl:rotate-180'>
              <button
                onClick={() => gotoPage(pageCount - 1)}
                disabled={!canNextPage}
                className={` ${!canNextPage ? 'opacity-50 cursor-not-allowed' : ''}`}
              >
                <Icon icon='heroicons:chevron-double-right-solid' />
              </button>
            </li>
          </ul>
        </div>
        {/*end*/}
      </Card>
    </>
  );
};

export default memo(DailyResult);
