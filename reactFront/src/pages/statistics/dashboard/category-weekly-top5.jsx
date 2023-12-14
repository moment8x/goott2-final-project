import SelectMonth from '@/components/partials/SelectMonth';
import Card from '@/components/ui/Card';
import { useMemo } from 'react';
import { usePagination, useRowSelect, useSortBy, useTable } from 'react-table';
import Products from '../../../components/partials/widget/products';

const COLUMNS = [
  {
    Header: '순위',
    accessor: 'rank',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '분류',
    accessor: 'detailCategory',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
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

const DashboardCategoryRankWeek = ({ title = '주간 분류별 판매순위 TOP 5', categoryWeeklyData }) => {
  const columns = useMemo(() => COLUMNS, []);

  const tableInstance = useTable(
    {
      columns,
      data: categoryWeeklyData,
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

export default DashboardCategoryRankWeek;
