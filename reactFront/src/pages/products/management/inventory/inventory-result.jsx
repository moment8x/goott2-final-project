import Badge from '@/components/ui/Badge';
import Button from '@/components/ui/Button';
import Card from '@/components/ui/Card';
import Icon from '@/components/ui/Icon';
import Modal from '@/components/ui/Modal';
import Textinput from '@/components/ui/Textinput';
import MemberInfoModal from '@/pages/members/search/member-modal';
import React, { memo, useEffect, useMemo, useState } from 'react';
import { usePagination, useRowSelect, useSortBy, useTable } from 'react-table';

const COLUMNS = [
  {
    Header: 'No',
    accessor: 'no',
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
    Header: '상품ID',
    accessor: 'productId',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '총 재고량',
    accessor: 'currentQuantity',
    Cell: (row) => {
      return <span>{row?.cell?.value?.toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '카테고리 코드',
    accessor: 'categoryKey',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '카테고리 이름',
    accessor: 'categoryName',
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: '재고수량',
    accessor: 'quantity',
    Cell: (row) => {
      return (
        <span className='flex justify-center'>
          {
            <Textinput
              id='smallsize'
              type='text'
              className='w-[80px] h-[32px] text-sm text-right '
              defaultValue={row?.cell?.value?.toLocaleString('ko-KR')}
            />
          }
        </span>
      );
    },
  },
  {
    Header: '판매가',
    accessor: 'consumerPrice',
    Cell: (row) => {
      return <span>{row?.cell?.value?.toLocaleString('ko-KR')}</span>;
    },
  },
  {
    Header: '총 누적 판매량',
    accessor: 'salesVolume',
    Cell: (row) => {
      return <span>{row?.cell?.value?.toLocaleString('ko-KR')}</span>;
    },
  },
];

const IndeterminateCheckbox = React.forwardRef(({ indeterminate, ...rest }, ref) => {
  const defaultRef = React.useRef();
  const resolvedRef = ref || defaultRef;

  useEffect(() => {
    resolvedRef.current.indeterminate = indeterminate;
  }, [resolvedRef, indeterminate]);

  return (
    <>
      <input
        type='checkbox'
        ref={resolvedRef}
        {...rest}
        className='table-checkbox'
        onClick={(e) => console.log('target: ', e)}
      />
    </>
  );
});

const SearchedProductStock = ({ title = '상품 목록', data, searchedProduct }) => {
  const columns = useMemo(() => COLUMNS, []);
  const [totalProduct, setTotalProduct] = useState(0);
  const [updateStockList, setUpdateStockList] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [modalContent, setModalContent] = useState('');

  const openModal = () => {
    setShowModal(!showModal);
  };

  // 총 상품 수 조회
  useEffect(() => {
    fetch('http://localhost:8081/admin/products/dashBoardMain', { method: 'GET' })
      .then((res) => res.json())
      .then((res) => {
        // console.log('res:', res);
        setTotalProduct(res.totalCount);
      });
  }, []);

  const handleSaveStock = () => {
    fetch(`http://localhost:8081/admin/products/updateStock`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: JSON.stringify(updateStockList),
    })
      .then((res) => res.text())
      .then((res) => {
        console.log('handleSaveStock res2:', res);
        setModalContent('재고 업데이트 성공');
        openModal();
      })
      .catch((error) => {
        console.error('Error :', error);
        setModalContent('재고 업데이트 실패');
        openModal();
      });
  };

  const handleQuantityChange = (row, newQuantity) => {
    const productId = row.original.productId;
    setUpdateStockList((prev) => {
      const existingIndex = prev.findIndex((item) => item.productId === productId);
      if (existingIndex !== -1) {
        const updatedItem = { ...prev[existingIndex], newQuantity: newQuantity };
        return [...prev.slice(0, existingIndex), updatedItem, ...prev.slice(existingIndex + 1)];
      } else {
        return [...prev, { productId, newQuantity: newQuantity }];
      }
    });
    console.log('updateStockList : ', updateStockList);
  };

  const tableInstance = useTable(
    {
      columns,
      data,
      initialState: { quantityMap: {} },
      getRowId: (row) => row.productId,
      // 추가된 부분: row에 대한 수량 정보를 업데이트하는 로직
      updateMyData: (rowIndex, columnId, value) => {
        const updatedQuantityMap = { ...quantityMap };
        updatedQuantityMap[rowIndex] = value;
        setQuantityMap(updatedQuantityMap);
      },
    },

    useSortBy,
    usePagination,
    useRowSelect,

    (hooks) => {
      hooks.visibleColumns.push((columns) => [
        {
          id: 'selection',
          Header: ({ getToggleAllRowsSelectedProps }) => (
            <div>
              <IndeterminateCheckbox {...getToggleAllRowsSelectedProps()} />
            </div>
          ),
          Cell: ({ row }) => (
            <div>
              <IndeterminateCheckbox {...row.getToggleRowSelectedProps()} />
            </div>
          ),
        },
        ...columns,
      ]);
    }
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
    state: { selectedRowIds },
  } = tableInstance;

  // const selectedRows = Object.keys(selectedRowIds).map((rowId) => tableInstance.rows.find((row) => row.id === rowId));

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
      {showModal && (
        <MemberInfoModal
          title=''
          label=''
          labelClass='btn-outline-dark'
          uncontrol
          disableBackdrop
          className='max-w-xs'
          showModal={showModal}
          setShowModal={setShowModal}
        >
          {/* <h4 className='font-medium text-lg mb-3 text-slate-900'>Lorem ipsum dolor sit.</h4> */}

          <div className='text-base text-slate-600 dark:text-slate-300 text-center'>{modalContent}</div>
        </MemberInfoModal>
      )}
      <Card>
        <div className='md:flex items-center mb-6'>
          <h4 className='card-title font-black w-[6%]'>{title}</h4>
          <div className='w-[100%] flex justify-between'>
            <div>
              <Button className='btn-secondary ml-5 p-[7px] pointer-events-none'>
                <div className='space-x-1 rtl:space-x-reverse'>
                  <span>총 상품 수</span>
                  <Badge label={totalProduct} className='bg-white text-slate-900 ' />
                  <span>개</span>
                </div>
              </Button>
              <Button className='btn-outline-dark ml-5 p-[7px] pointer-events-none'>
                <div className='space-x-1 rtl:space-x-reverse'>
                  <span>검색결과</span>
                  <Badge label={searchedProduct} className='bg-white text-slate-900 ' />
                  <span>개</span>
                </div>
              </Button>
            </div>
            <div className='box box-warning'>
              {searchedProduct > 0 && (
                <button
                  className='btn btn-dark w-[70px] p-[8px]'
                  onClick={
                    updateStockList.length > 0
                      ? handleSaveStock
                      : () => {
                          setModalContent('상품을 체크한 뒤 버튼을 눌러주세요.');
                          openModal();
                        }
                  }
                >
                  저 장
                </button>
              )}
            </div>
          </div>
        </div>
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
                          className=' table-th '
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
                  {page.map((row, rowIndex) => {
                    prepareRow(row);
                    return (
                      <tr {...row.getRowProps()}>
                        {row.cells.map((cell, index) => {
                          return (
                            <td
                              {...cell.getCellProps()}
                              className={'table-td cursor-pointer text-center '}
                              onClick={index !== 0 && index !== 8 ? () => openModal(row) : null}
                            >
                              {/* row 클릭 시 모달 오픈 */}

                              {index === 8 ? ( // 재고수량 열에만 Textinput 컴포넌트 적용
                                <span className='flex justify-center'>
                                  <Textinput
                                    id={`quantity-${rowIndex}`}
                                    type='text'
                                    className='w-[80px] h-[32px] text-sm text-right'
                                    defaultValue={row?.original.quantity?.toLocaleString('ko-KR')}
                                    onChange={(e) => handleQuantityChange(row, e.target.value)}
                                  />
                                </span>
                              ) : (
                                // 나머지 열에는 기존 내용 표시
                                cell.render('Cell')
                              )}

                              {/* <Link to='' onClick={openModal}>
                                {cell.render('Cell')}
                              </Link> */}
                              {/* <Link to='modal' state={{ background: location }}>
                                {cell.render('Cell')}
                                <Outlet />
                              </Link> */}
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
            {pages.map((page, pageIndex) => (
              <li key={pageIndex}>
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

export default memo(SearchedProductStock);
