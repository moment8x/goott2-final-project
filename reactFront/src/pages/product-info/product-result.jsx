import React, { memo, useEffect, useMemo, useState } from "react";
import Card from "@/components/ui/Card";
import Icon from "@/components/ui/Icon";
import Badge from "@/components/ui/Badge";
import Button from "@/components/ui/Button";
import Tooltip from "@/components/ui/Tooltip";
import { useTable, useRowSelect, useSortBy, usePagination } from "react-table";
import { Link } from "react-router-dom";
import ProductInfoModal from "./product-modal";
import Modal from "@/components/ui/Modal";

const COLUMNS = [
  {
    Header: "상품ID",
    accessor: "productId",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: "상품이름",
    accessor: "productName",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: "소비자가",
    accessor: "consumerPrice",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: "공급가",
    accessor: "supplyPrice",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: "판매가",
    accessor: "sellingPrice",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: "상품이미지",
    accessor: "productImage",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: "출시일",
    accessor: "publicationDate",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: "isbn",
    accessor: "isbn",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },
  {
    Header: "카테고리",
    accessor: "categoryKey",
    Cell: (row) => {
      return <span>{row?.cell?.value}</span>;
    },
  },

  {
    Header: "",
    accessor: "action",
    Cell: (row) => {
      return (
        row?.cell?.value !== "" && (
          <div className="flex space-x-3 rtl:space-x-reverse">
            <Tooltip
              content="상세보기"
              placement="top"
              arrow
              animation="shift-away"
            >
              <button className="action-btn" type="button">
                <Icon icon="heroicons:eye" />
              </button>
            </Tooltip>
            <Tooltip
              content="수정"
              placement="top"
              arrow
              animation="shift-away"
            >
              <button className="action-btn" type="button">
                <Icon icon="heroicons:pencil-square" />
              </button>
            </Tooltip>
            <Tooltip
              content="삭제"
              placement="top"
              arrow
              animation="shift-away"
              theme="danger"
            >
              <button className="action-btn" type="button">
                <Icon icon="heroicons:trash" />
              </button>
            </Tooltip>
          </div>
        )
      );
    },
  },
];

const IndeterminateCheckbox = React.forwardRef(
  ({ indeterminate, ...rest }, ref) => {
    const defaultRef = React.useRef();
    const resolvedRef = ref || defaultRef;

    useEffect(() => {
      resolvedRef.current.indeterminate = indeterminate;
    }, [resolvedRef, indeterminate]);

    return (
      <>
        <input
          type="checkbox"
          ref={resolvedRef}
          {...rest}
          className="table-checkbox"
        />
      </>
    );
  }
);

const SearchedProduct = ({ title = "상품 목록", data }) => {
  const columns = useMemo(() => COLUMNS, []);
  // // const data = useMemo(() => searchedInfo, []);
  const [totalMember, setTotalMember] = useState(0);

  const [showModal, setShowModal] = useState(false);

  const openModal = () => {
    setShowModal(!showModal);
  };

  const tableInstance = useTable(
    {
      columns,
      data,
    },

    useSortBy,
    usePagination,
    useRowSelect,

    (hooks) => {
      hooks.visibleColumns.push((columns) => [
        {
          id: "selection",
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
  } = tableInstance;

  const { pageIndex, pageSize } = state;
  const length = data.length;

  const totalPages = useMemo(() => {
    return Math.ceil(length / pageSize);
  }, [length, pageSize]);

  const pages = useMemo(() => {
    const start = Math.floor(pageIndex / 10) * 10;
    const end = start + 10 > totalPages ? totalPages : start + 10;
    return Array.from({ length: end - start }, (_, i) => start + i);
  }, [pageIndex, totalPages]);

  useEffect(() => {
    fetch("http://localhost:8081/admin/products/product-info", {
      method: "GET",
    })
      .then((res) => res.json())
      .then((res) => {
        console.log("res:", res);
        setTotalMember(res.total);
      });
  }, []);

  return (
    <>
      {showModal && (
        <MemberInfoModal
          title="Extra large modal"
          label="Extra large modal"
          labelClass="btn-outline-dark"
          uncontrol
          className="max-w-fit"
          showModal={showModal}
          setShowModal={setShowModal}
        >
          <h4 class="font-medium text-lg mb-3 text-slate-900">
            Lorem ipsum dolor sit.
          </h4>
          <div class="text-base text-slate-600 dark:text-slate-300">
            Oat cake ice cream candy chocolate cake chocolate cake cotton candy
            dragée apple pie. Brownie carrot cake candy canes bonbon fruitcake
            topping halvah. Cake sweet roll cake cheesecake cookie chocolate
            cake liquorice.
          </div>
        </MemberInfoModal>
      )}
      <Card>
        <div className="md:flex items-center mb-6">
          <h4 className="card-title font-black">{title}</h4>
          <Button className="btn-secondary ml-5 p-[7px] pointer-events-none">
            <div className="space-x-1 rtl:space-x-reverse">
              <span>총 상품 수</span>
              <Badge label={totalMember} className="bg-white text-slate-900 " />
              <span>개</span>
            </div>
          </Button>
        </div>
        <div className="overflow-x-auto -mx-6">
          <div className="inline-block min-w-full align-middle">
            <div className="overflow-hidden ">
              <table
                className="min-w-full divide-y divide-slate-100 table-fixed dark:divide-slate-700"
                {...getTableProps}
              >
                <thead className="bg-slate-200 dark:bg-slate-700">
                  {headerGroups.map((headerGroup) => (
                    <tr {...headerGroup.getHeaderGroupProps()}>
                      {headerGroup.headers.map((column) => (
                        <th
                          {...column.getHeaderProps(
                            column.getSortByToggleProps()
                          )}
                          scope="col"
                          className=" table-th "
                        >
                          {column.render("Header")}
                          <span>
                            {column.isSorted
                              ? column.isSortedDesc
                                ? " 🔽"
                                : " 🔼"
                              : ""}
                          </span>
                        </th>
                      ))}
                    </tr>
                  ))}
                </thead>
                <tbody
                  className="bg-white divide-y divide-slate-100 dark:bg-slate-800 dark:divide-slate-700"
                  {...getTableBodyProps}
                >
                  {page.map((row) => {
                    prepareRow(row);
                    return (
                      <tr {...row.getRowProps()}>
                        {row.cells.map((cell) => {
                          return (
                            <td {...cell.getCellProps()} className="table-td">
                              <Link to="" onClick={openModal}>
                                {cell.render("Cell")}
                              </Link>
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
        <div className="md:flex md:space-y-0 space-y-5 justify-between mt-6 items-center">
          <div className=" flex items-center space-x-3 rtl:space-x-reverse">
            <select
              className="form-control py-2 w-max"
              value={pageSize}
              onChange={(e) => setPageSize(Number(e.target.value))}
            >
              {[10, 25, 50].map((pageSize) => (
                <option key={pageSize} value={pageSize}>
                  Show {pageSize}
                </option>
              ))}
            </select>
            <span className="text-sm font-medium text-slate-600 dark:text-slate-300">
              Page{" "}
              <span>
                {pageIndex + 1} of {pageOptions.length}
              </span>
            </span>
          </div>
          <ul className="flex items-center  space-x-3  rtl:space-x-reverse">
            <li className="text-xl leading-4 text-slate-900 dark:text-white rtl:rotate-180">
              <button
                className={` ${
                  !canPreviousPage ? "opacity-50 cursor-not-allowed" : ""
                }`}
                onClick={() => gotoPage(0)}
                disabled={!canPreviousPage}
              >
                <Icon icon="heroicons:chevron-double-left-solid" />
              </button>
            </li>
            <li className="text-sm leading-4 text-slate-900 dark:text-white rtl:rotate-180">
              <button
                className={` ${
                  !canPreviousPage ? "opacity-50 cursor-not-allowed" : ""
                }`}
                onClick={() => previousPage()}
                disabled={!canPreviousPage}
              >
                Prev
              </button>
            </li>
            {pages.map((page, pageIdx) => (
              <li key={pageIdx}>
                <button
                  href="#"
                  aria-current="page"
                  className={` ${
                    page === pageIndex
                      ? "bg-slate-900 dark:bg-slate-600  dark:text-slate-200 text-white font-medium "
                      : "bg-slate-100 dark:bg-slate-700 dark:text-slate-400 text-slate-900  font-normal  "
                  }    text-sm rounded leading-[16px] flex h-6 w-6 items-center justify-center transition-all duration-150`}
                  onClick={() => gotoPage(page)}
                >
                  {page + 1}
                </button>
              </li>
            ))}
            <li className="text-sm leading-4 text-slate-900 dark:text-white rtl:rotate-180">
              <button
                className={` ${
                  !canNextPage ? "opacity-50 cursor-not-allowed" : ""
                }`}
                onClick={() => nextPage()}
                disabled={!canNextPage}
              >
                Next
              </button>
            </li>
            <li className="text-xl leading-4 text-slate-900 dark:text-white rtl:rotate-180">
              <button
                onClick={() => gotoPage(pageCount - 1)}
                disabled={!canNextPage}
                className={` ${
                  !canNextPage ? "opacity-50 cursor-not-allowed" : ""
                }`}
              >
                <Icon icon="heroicons:chevron-double-right-solid" />
              </button>
            </li>
          </ul>
        </div>
        {/*end*/}
      </Card>
    </>
  );
};

export default memo(SearchedProduct);
