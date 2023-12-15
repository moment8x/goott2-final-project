import React from 'react';
import Chart from 'react-apexcharts';
import useDarkMode from '@/hooks/useDarkMode';

const AggregationChart = ({ data }) => {
  const [isDark] = useDarkMode();
  const series = [
    {
      name: '순매출',
      data: [data.map((data) => data.netSales)[0]],
    },
    {
      name: '순매입',
      data: [data.map((data) => data.netPurchases)[0]],
    },
    {
      name: '판매이익',
      data: [data.map((data) => data.grossProfit)[0]],
    },
  ];
  const options = {
    chart: {
      type: 'bar',
      background: '#fff',
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
    title: {
      text: '통계 그래프',
      align: 'left',
      margin: 10,
      offsetX: 12,
      offsetY: 10,
      floating: false,
      style: {
        fontSize: '20px',
        fontWeight: 'bold',
        fontFamily: undefined,
        color: '#192024',
      },
    },
    xaxis: {
      categories: [''],
    },
    yaxis: {
      labels: {
        style: {
          colors: isDark ? '#CBD5E1' : '#475569',
          fontFamily: 'Inter',
        },
        formatter: (value) => {
          return value + '원';
        },
      },
    },
    tooltip: {
      y: {
        formatter: function (y) {
          if (typeof y !== 'undefined') {
            return y.toFixed(0) + '원';
          }
          return y;
        },
      },
    },
    grid: {
      show: true,
      borderColor: isDark ? '#334155' : '#e2e8f0',
      position: 'back',
    },
    colors: ['#4669FA', '#50C793', '#faa70c'],
  };

  return (
    <div>
      <Chart options={options} series={series} type='bar' height={350} />
    </div>
  );
};

export default AggregationChart;
