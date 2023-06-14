<script setup>
import {useRoute} from "vue-router";
import DecChart from "@/components/charts/DecChart.vue";
import {onMounted, ref, watch} from "vue";

let route = useRoute()
let itemRefs = ref([])
let autoFetch = ref(false)
let timer = ref(null)

watch(autoFetch, (newVal, oldVal) => {
  if (newVal === true) {
    timer.value = setInterval(() => {
      refreshCall()
    }, 10000)
  } else {
    clearInterval(timer.value)
  }
})


const setRef = (el) => {
  if (el) {
    itemRefs.value.push(el)
  }
}


let refreshCall = () => {
  itemRefs.value.forEach(item => {
    item.refreshData()
  })
}
let query = JSON.parse(route.query.config)
let charts = ref(query.charts)
for (let i = 0; i < charts.value.length; i++) {
  charts.value[i].style = query.layout[i]
}
let layout = query.layout

onMounted(() => {
  let nodeList = document.querySelectorAll('.chart-item')
  for (let i = 0; i < charts.value.length; i++) {
    let styleString = query.layout[i].style
    let entry = styleString.split(';')
    for (let j = 0; j < entry.length; j++) {
      let kv = entry[j].split(':')
      if(kv.length <=1)continue;
      nodeList[i].style[kv[0].trimStart().trimEnd()] = kv[1]
    }
    nodeList[i].setAttribute('data-x', query.layout[i]['data-x'])
    nodeList[i].setAttribute('data-y', query.layout[i]['data-y'])
  }
  itemRefs.value.forEach(item=>{
    item.resize()
  })
})


</script>

<template>
  <div class="w-full h-full">
    <div class="bg-zinc-100 h-12 w-full">
      <div class="flex justify-around w-full">
        <div>
          <span class="font-600  space-x-2">
            <el-tag>刷新数据 ：</el-tag>
          <el-icon @click="refreshCall" class="cursor-pointer text-xl mt-1">
            <Refresh/>
          </el-icon>
          </span>
        </div>
        <div>
          <span class="font-600  space-x-2">
            <el-tag>自动刷新 ：</el-tag>
          </span>
          <el-switch v-model="autoFetch"/>
        </div>
      </div>
    </div>
    <div class="w-full h-full grid grid-cols-4 gap-8">
      <div v-for="(item ,idx) in charts" class="bg-red-50 chart-item">
        <dec-chart mode="normal" :chart="'ch_'+(idx+8928).toString()"
                    :dataset="item.dataset" :mapping="item.mapping"
                   :ref="setRef"
                   style="width: 200px;height: 200px"
                   :ctype="item.config.type">
        </dec-chart>
      </div>
    </div>
  </div>

</template>

<style scoped>

</style>