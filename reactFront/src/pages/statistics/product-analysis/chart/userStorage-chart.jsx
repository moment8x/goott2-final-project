import React from 'react';
import Chart from 'react-apexcharts';
import useDarkMode from '@/hooks/useDarkMode';

const UserStorageChart = ({ cartQuantity, wishlistQuantity, label }) => {
  const [isDark] = useDarkMode();
  const series = cartQuantity && cartQuantity.map((data) => data.quantity);
  const wishlistSeries = wishlistQuantity && wishlistQuantity.map((data) => data.quantity);

  const options = {
    labels: cartQuantity
      ? cartQuantity.map((data) => data.productName)
      : wishlistQuantity
      ? wishlistQuantity.map((data) => data.productName)
      : null,

    dataLabels: {
      enabled: true,
    },
    chart: {
      background: '#fff',
      stacked: false,
      toolbar: {
        show: false,
      },
      locales: [
        {
          name: 'ko',
          options: {
            months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            days: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
            shortDays: ['일', '월', '화', '수', '목', '금', '토'],
            toolbar: {
              exportToSVG: 'SVG 다운로드',
              exportToPNG: 'PNG 다운로드',
              exportToCSV: 'CSV 다운로드',
              menu: '메뉴',
              selection: '선택',
              selectionZoom: '선택영역 확대',
              zoomIn: '확대',
              zoomOut: '축소',
              pan: '패닝',
              reset: '원래대로',
            },
          },
        },
      ],
      defaultLocale: 'ko',
    },
    colors: ['#50C793', '#F1595C', '#FBBF24', '#fb5d24', '#247afb'],
    legend: {
      show: false,
      position: 'bottom',
      fontSize: '16px',
      fontFamily: 'Inter',
      fontWeight: 400,
      labels: {
        colors: isDark ? '#CBD5E1' : '#475569',
      },
    },
    plotOptions: {
      pie: {
        donut: {
          size: '65%',
          labels: {
            show: true,
            name: {
              show: true,
              fontSize: '26px',
              fontWeight: 'bold',
              fontFamily: 'Inter',
              color: isDark ? '#CBD5E1' : '#475569',
            },
            value: {
              show: true,
              fontFamily: 'Inter',
              color: isDark ? '#CBD5E1' : '#475569',
              formatter(val) {
                // eslint-disable-next-line radix
                return `${parseInt(val)}%`;
              },
            },
            total: {
              show: true,
              fontSize: '1.1rem',
              color: isDark ? '#CBD5E1' : '#475569',
              label: label,
              formatter() {
                return '';
              },
            },
          },
        },
      },
    },

    responsive: [
      {
        breakpoint: 480,
        options: {
          legend: {
            position: 'bottom',
          },
        },
      },
    ],
  };

  return (
    <div>
      <Chart options={options} series={series || wishlistSeries} type='donut' height='450' />
    </div>
  );
};

export default UserStorageChart;
