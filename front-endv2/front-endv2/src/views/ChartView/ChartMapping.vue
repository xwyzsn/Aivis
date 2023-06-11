<template>
    <div class="w-full h-full flex">
        <div class="w-1/3 h-full bg-slate-300 flex flex-col space-y-4">
            <div v-for="item, idx in chartConfig">
                <div class="m-2 text-lg">{{ item.label }}</div>
                <el-select v-if="item.type === 'select'" :placeholder="item.desc" v-model="item.axis">
                    <el-option v-for="item in dataCols" :label="item" :value="item">
                    </el-option>
                </el-select>
                <el-input v-else :placeholder="item.desc" v-model="item.axis"></el-input>
            </div>
            <div class="p-4 space-y-3">
                <div class="w-full">
                <el-button class="w-full" type="primary" @click="confirm">确认</el-button>
                </div>
                <div class="w-full">
                <el-button class="w-full" type="default" @click="handleSaveChart">保存</el-button>
                </div>
            </div>
        </div>
        <div class="w-2/3 h-full">
            <dec-chart v-if="showChart" :ctype="chart" :dataset="dataset" :mapping="mapping" />
        </div>

    </div>
</template>
 
<script setup>
import { ref } from 'vue'
import { useRoute } from 'vue-router';
import { useBootstrapStore } from '../../stores/counter';
import DecChart from '../../components/charts/DecChart.vue';
import {saveChart} from "@/api/chart/chartApi";
const bootstrapStore = useBootstrapStore();
let route = useRoute();
const { query } = route;
console.log(query.dataset)
let dataset = ref(JSON.parse(query.dataset))
// console.log("=====dataset,", JSON.parse(dataset.value))
let dataCols = ref(Object.keys(dataset.value.example_row))
let chart = ref(query.chart)
let chartTemplate = ref(bootstrapStore.bootstrap.chart_template)
console.log(chartTemplate.value, chart.value)
let chartConfig = ref(chartTemplate.value.filter(item => item.chart_name === chart.value)[0]?.config.template)
console.log(chartConfig.value)
let mapping = ref({})
let showChart = ref(false)
let confirm = () => {
    let tmp = {}
    for (let i = 0; i < dataCols.value.length; i++) {
        tmp[dataCols.value[i]] = chartConfig.value[i].value
        console.log(chartConfig.value[i])
    }
    mapping.value = tmp
    showChart.value = true
}
let handleSaveChart = ()=>{
    console.log(mapping.value)
    let cfg = {"type":chart.value}
    chartConfig.value.forEach(item=>{
        let type = item.type
        if (type !== 'select') {
            cfg[item.label] = item.axis
        }
    })
    let payload = {
        config: cfg,
        dataset: dataset.value,
        mapping: mapping.value
    }
    saveChart(payload).then(res=>{
        console.log(res.data)
    })
}
</script> 
 
<style scoped></style>