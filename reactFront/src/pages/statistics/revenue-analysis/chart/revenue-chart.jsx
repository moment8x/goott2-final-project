import React from 'react';
import Chart from 'react-apexcharts';
import useDarkMode from '@/hooks/useDarkMode';

const RevenueChart = ({ data }) => {
  const [isDark] = useDarkMode();
  const series = [
    {
      name: '순매출',
      type: 'column',
      data: data.map((data) => data.netSales),
    },
  ];
  const options = {
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
    stroke: {
      width: [0, 2, 5],
      curve: 'smooth',
    },
    plotOptions: {
      bar: {
        columnWidth: '50%',
      },
    },

    fill: {
      opacity: [0.85, 0.25, 1],
      gradient: {
        inverseColors: false,
        shade: 'light',
        type: 'vertical',
        opacityFrom: 0.85,
        opacityTo: 0.55,
        stops: [0, 100, 100, 100],
      },
    },
    labels: data
      .slice(0)
      .reverse()
      .map((data) => data.date),
    markers: {
      size: 0,
    },
    xaxis: {
      type: 'category',
      max: 15,
      labels: {
        style: {
          colors: isDark ? '#CBD5E1' : '#475569',
          fontFamily: 'Inter',
        },
        format: 'MM/dd',
      },
      axisBorder: {
        show: false,
      },
      axisTicks: {
        show: false,
      },
    },
    yaxis: {
      min: 0,
      labels: {
        style: {
          colors: isDark ? '#CBD5E1' : '#475569',
          fontFamily: 'Inter',
        },
        formatter: (value) => {
          return value + ' 원';
        },
      },
    },
    tooltip: {
      shared: true,
      intersect: false,
      x: {
        format: 'MM월 dd일',
      },

      y: {
        formatter: function (y) {
          if (typeof y !== 'undefined') {
            return y.toFixed(0) + ' 원';
          }
          return y;
        },
      },
    },
    legend: {
      labels: {
        useSeriesColors: true,
      },
    },
    grid: {
      show: true,
      borderColor: isDark ? '#334155' : '#e2e8f0',
      position: 'back',
    },
    colors: ['#4669FA', '#50C793', '#0CE7FA'],
  };
  return (
    <div>
      <Chart options={options} series={series} type='line' height={350} />
    </div>
  );
};

export default RevenueChart;
