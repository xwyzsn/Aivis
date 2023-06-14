<template>
  <div class="w-full h-full">

    <div class="w-full h-full" :id="props.chart">
    </div>

  </div>
</template>


<script setup>
import * as echarts from 'echarts';
import {ref, onMounted, nextTick} from 'vue'

let X = ref([])
let X_predict = ref([])
let max = ref([])
let min = ref([])
let date = ref([])
let normal_data = ref([])
let outlier_data = ref([])
const props = defineProps({
  chartType: {
    type: String,
    default: ""
  },
  algorithm: {
    type: String,
    default: ""
  },
  datasource: {
    type: String,
    default: ""
  },
  width: {
    type: Number,
    default: 800
  },
  height: {
    type: Number,
    default: 600
  },
  formData: {
    type: Object
  },
  margin: {
    type: Number,
    default: 4
  },
  chart: {
    type: String,
    default: "proChart"
  },
  mode: {
    type: String
  }
})
let getdataTS = () => {
  props.formData.forEach(element => {
    X.value.push(element.X);
    X_predict.value.push(element.X_predict);
    max.value.push(element.X + props.margin);
    min.value.push(element.X - props.margin);
    date.value.push(element.date);
  });
};
let initTimeSeries = () => { // 初始化时序数据预测图

  let chartInstance = echarts.init(document.getElementById(props.chart), 'infographic')
  const initOption = {
    title: {
      textAlign: 'center',
      top: 0,
      left: '12%',
      text: props.algorithm,
      subtext: props.datasource,
      textStyle: {
        fontWeight: 'normal',
        fontSize: 25,
        color: 'black',
        fontFamily: 'Arial',
      },
      subtextStyle: {
        fontSize: 18
      }

    },
    legend: {
      data: ['真实值', '预测值'],
      top: '5%'
    },
    series: [

      {
        name: '阈值上限',
        type: 'line',
        lineStyle: {
          opacity: 0
        },
        areaStyle: {
          color: 'rgba(255,204,153,0.5)'
        },
        symbol: 'none',
        emphasis: {
          disabled: true
        },
        data: max.value,
      },
      {
        name: '真实值',
        type: 'line',
        symbol: 'circle',
        symbolSize: 5,
        data: X.value,
        color: '#336699'
      },
      {
        name: '预测值',
        type: 'line',
        symbol: 'circle',
        symbolSize: 5,
        lineStyle: {
          color: "#FF9900"
        },
        itemStyle: {
          color: "#FF9900"
        },
        data: X_predict.value.map((d, index) => {
          if (d > max.value[index] || d < min.value[index]) {
            return {
              value: d,
              itemStyle: {
                color: "#e33e3b"
              },
              symbolSize: 7
            }
          }
          return {
            value: d,
            itemStyle: {
              color: "#FF9900"
            }
          }
        })
      },
      {
        name: '阈值下限',
        type: 'line',
        lineStyle: {
          opacity: 0
        },
        areaStyle: {
          color: '#fff'
        },
        symbol: 'none',
        data: min.value,
      },
    ],
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        label: {
          backgroundColor: 'rgba(0,122,255,0.6)'
        }
      }
    },
    toolbox: {
      left: '80%',
      top: '4%',
      feature: {
        dataZoom: {
          yAxisIndex: 'none'
        },
        restore: {},
        saveAsImage: {}
      }
    },

    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      top: '15%',
      containLabel: true,
    },
    xAxis: {
      data: date.value
    },
    yAxis: {
      type: 'value'
    },
    dataZoom: [
      {
        id: 'dataZoomX',
        type: 'slider',
        xAxisIndex: [0],
        filterMode: 'filter'
      }
    ],
    animationDuration: 2000
  }
  chartInstance.showLoading({
    text: 'loading',
    color: '#c23531',
    textColor: '#000',
    maskColor: 'rgba(255, 255, 255, 0.2)',
    zlevel: 0,
  })
  setTimeout(() => {
    chartInstance.hideLoading()
    chartInstance.setOption(initOption)
    chartInstance.on('finished', function () {
      if (props.mode === 'pic') {
        let data = chartInstance.getDataURL({
          pixelRatio: 2,
          backgroundColor: '#fff'
        })
        let imgItem = document.createElement('img')
        imgItem.src = data
        // console.log(data)
        imgItem.style.width = '100%'
        imgItem.style.height = '100%'
        let container = document.getElementById(props.chart)?.parentNode
        if (container) {
          container.appendChild(imgItem)
          let ins = document.getElementById(props.chart)
          ins.remove()
          chartInstance.dispose();
        }
      }
    })
  }, 1000)

}
const resizeWindow = () => {
  let chartInstance = echarts.getInstanceByDom(document.getElementById(props.chart))
  chartInstance.resize()
}
let refreshData = () => {
  const initOption = {
    title: {
      textAlign: 'center',
      top: 0,
      left: '12%',
      text: props.algorithm,
      subtext: props.datasource,
      textStyle: {
        fontWeight: 'normal',
        fontSize: 25,
        color: 'black',
        fontFamily: 'Arial',
      },
      subtextStyle: {
        fontSize: 18
      }

    },
    legend: {
      data: ['真实值', '预测值'],
      top: '5%'
    },
    series: [

      {
        name: '阈值上限',
        type: 'line',
        lineStyle: {
          opacity: 0
        },
        areaStyle: {
          color: 'rgba(255,204,153,0.5)'
        },
        symbol: 'none',
        emphasis: {
          disabled: true
        },
        data: max.value,
      },
      {
        name: '真实值',
        type: 'line',
        symbol: 'circle',
        symbolSize: 5,
        data: X.value,
        color: '#336699'
      },
      {
        name: '预测值',
        type: 'line',
        symbol: 'circle',
        symbolSize: 5,
        lineStyle: {
          color: "#FF9900"
        },
        itemStyle: {
          color: "#FF9900"
        },
        data: X_predict.value.map((d, index) => {
          if (d > max.value[index] || d < min.value[index]) {
            return {
              value: d,
              itemStyle: {
                color: "#e33e3b"
              },
              symbolSize: 7
            }
          }
          return {
            value: d,
            itemStyle: {
              color: "#FF9900"
            }
          }
        })
      },
      {
        name: '阈值下限',
        type: 'line',
        lineStyle: {
          opacity: 0
        },
        areaStyle: {
          color: '#fff'
        },
        symbol: 'none',
        data: min.value,
      },
    ],
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        label: {
          backgroundColor: 'rgba(0,122,255,0.6)'
        }
      }
    },
    toolbox: {
      left: '80%',
      top: '4%',
      feature: {
        dataZoom: {
          yAxisIndex: 'none'
        },
        restore: {},
        saveAsImage: {}
      }
    },

    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      top: '15%',
      containLabel: true,
    },
    xAxis: {
      data: date.value
    },
    yAxis: {
      type: 'value'
    },
    dataZoom: [
      {
        id: 'dataZoomX',
        type: 'slider',
        xAxisIndex: [0],
        filterMode: 'filter'
      }
    ],
    animationDuration: 2000
  }
  let chartInstance = echarts.getInstanceByDom(document.getElementById(props.chart))
  chartInstance.setOption(initOption)
}
defineExpose({
  refreshData,
  resizeWindow
})
onMounted(() => {
  getdataTS()

  initTimeSeries()
})


</script>

<style lang="scss" scoped></style>