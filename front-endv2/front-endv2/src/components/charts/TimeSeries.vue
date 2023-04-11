<template>
  <div class="pro_stock_item">
    <el-row :gutter="20">
      <el-col :span="11">
        <div class = "com-container">
        <div class="com-chart" id="proChart" ref="proChart" :style="{width: width+'px',height:height+'px'}"></div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>


<script>
export default {
  name:"TimeSeires",
  data () {
    return {
      X : [],
      X_predict : [],
      max: [],
      min: [],
      date: [],

      normal_data: [],
      outlier_data: []
    }
  },
  created () {
    this.initChart()
  },
  props: {
      chartType : {
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
        type: Number
      }
  },

  methods: {
    getdataTS() {
      this.formData.data.forEach(element => {
        this.X.push(element.X);
        this.X_predict.push(element.X_predict);
        this.max.push(element.X + this.margin);
        this.min.push(element.X - this.margin);
        this.date.push(element.date);
      });
      this.$nextTick(()=>{
        this.initTimeSeries()
      })
    },
    initTimeSeries () { // 初始化时序数据预测图
      this.chartInstance = this.$echarts.init(document.getElementById("proChart"),'infographic')
      const initOption = {
        title: {
          textAlign: 'center',
          top: 0,
          left: '12%',
          text: this.algorithm,
          subtext: this.datasource,
          textStyle: {
            fontWeight: 'normal',
            fontSize: 25,
            color: 'black',
            fontFamily:'Arial',
          },
          subtextStyle: {
            fontSize: 18
          }

        },
        legend: {
          data: ['真实值','预测值'],
          top: '5%'
        },
        series : [
          
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
            emphasis:{
              disabled: true
            },
            data: this.max,
          },
          {
            name: '真实值',
            type: 'line',
            symbol:'circle',
            symbolSize : 5,
            data: this.X,
            color: '#336699'
          },
          {
            name: '预测值',
            type: 'line',
            symbol:'circle',
            symbolSize : 5,
            lineStyle: {
              color: "#FF9900"
            },
            itemStyle:{
              color: "#FF9900"
            },
            data: this.X_predict.map((d,index)=>{
              if(d> this.max[index] || d<this.min[index]){
                return{
                  value: d,
                  itemStyle:{
                    color: "#e33e3b"
                  },
                  symbolSize : 7
                }
              }
              return{
                value: d,
                itemStyle:{
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
            data: this.min,
          },
        ],
        tooltip : {
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
        xAxis:{
          data: this.date
        },
        yAxis:{
          type:'value'
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
      this.chartInstance.showLoading({
        text: 'loading',
        color: '#c23531',
        textColor: '#000',
        maskColor: 'rgba(255, 255, 255, 0.2)',
        zlevel: 0,
      })
      setTimeout(() => {
        this.chartInstance.hideLoading()
        this.chartInstance.setOption(initOption)
      }, 1000)
      
    },
    // getdataOutlier() {

    // },
    // initOutlier() { // 初始化异常检测图
    //   this.chartInstance = this.$echarts.init(document.getElementById("proChart"),'infographic')
    //   const initOption = {

    //   }
    //   this.option_sumvalue.setOption(initOption)
    // },
    // updateOutlier() { // 更新异常检测图
    //   const option = { // 数据
    //     series : [
    //       {
    //         type: 'line',
    //         data: this.normal_data
    //       },
    //       {
    //         type: 'line',
    //         data: this.outlier_data
    //       }
    //     ],
    //   }
    //   this.chartInstance.showLoading({
    //     text: 'loading',
    //     color: '#c23531',
    //     textColor: '#000',
    //     maskColor: 'rgba(255, 255, 255, 0.2)',
    //     zlevel: 0,
    //   })
    //   setTimeout(() => {
    //     this.chartInstance.hideLoading();
    //     this.chartInstance.setOption(option)
    //   }, 1000)
    // },

    initChart(){
      if(this.chartType == "ts") { // 时间序列预测图
        this.getdataTS()
      }
      else if(this.chartType == "scatter") { // 异常检测散点图
        this.getdataOutlier()
      }
    }


  }
  

}
</script>

<style lang="scss" scoped>

</style>