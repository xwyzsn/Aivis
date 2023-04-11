<template>
<div :id="props.cid" class="h-full w-full">
</div>
</template>

<script setup>
import * as echarts from 'echarts'
import { onMounted, watch } from "vue";

const props = defineProps({
    title: {
    type: String,
    default: ''
    },
    cid: {
    type: String,
    default: ''
    },
    data: {
    type: Object,
    default: () => {
        return {
        x: [],
        y: []
        }
    }
    },
})


onMounted(()=>
{
    var myChart = echarts.init(document.getElementById(props.cid));

    watch(()=>props.data, (newVal, oldVal)=>
    {
    myChart.setOption({
        xAxis: {
            data: newVal.x
        },
        yAxis: {},
        series: [{
            name: 'loss',
            type: 'line',
            data: newVal.y
        }]
        })
    })
    console.log(props.data);
    myChart.setOption(
    {
        title: {
        text: props.title
        },
        xAxis: {
        type: "category",
        data: props.data['x']
        },
        yAxis: {
        type: "value"
        },
        series: [{
        data: props.data['y'],
        type: "line"
        }]
    }
    );
})


</script>

<style scoped>

</style>
