<template>
  <div class="w-full h-full">
    <div class="flex">
      <el-steps class="w-full" :active="active" align-center>
        <el-step title="Step 1" description="Choose your database" />
        <el-step title="Step 2" description="choose your chart" />
      </el-steps>

    </div>
    <div v-if="active === 1">
      <div>
        <my-header content="选择数据集"></my-header>
      </div>
      <div class="flex gap-x-4">
        <div>
          <el-select v-if="options" v-model="value" class="m-2" placeholder="Select" size="large">
            <el-option v-for="item in options" :key="item.id" :label="item.dataset_name" :value="item.datasetid" />
          </el-select>
        </div>
        <div>
          <el-button class="m-3" type="primary" @click="goNext">Next</el-button>
        </div>
      </div>
      <div v-if="options.filter(item => item.datasetid == value)[0]?.example_row">
        <el-table :data="[options.filter(item => item.datasetid == value)[0]?.example_row]">
          <el-table-column
            v-for="(item, idx) in Object.keys(options.filter(item => item.datasetid == value)[0]?.example_row)" :key="idx"
            :prop="item" :label="item">
          </el-table-column>
        </el-table>
      </div>
    </div>
    <div v-if="active === 2">
      <my-header content="选择图表"></my-header>
      <div class="flex gap-4">
        <div>
          <el-button @click="active = 1">go back</el-button>
        </div>
        <div>
          <el-button type="primary" @click="confirm">确认</el-button>
        </div>
      </div>
      <div class="m-4">
        <el-select v-model="chartValue" class="m-4">
          <el-option v-for="item in chartOption" :key="item" :label="item" :value="item" />
        </el-select>
      </div>
    </div>
  </div>
</template>
 
<script setup>
import { ref } from 'vue'
import { useBootstrapStore } from '../../stores/counter';
import MyHeader from '../../components/trivial/MyHeader.vue'
import { ElMessage } from 'element-plus';
import { useRouter } from 'vue-router'
const router = useRouter()
const bootstrapStore = useBootstrapStore();
console.log("=====", bootstrapStore.bootstrap.dataset);
let options = ref(bootstrapStore.bootstrap.dataset);
//TODO: // replace chart with real data
let chartOption = ref(['TSL'])
let chartValue = ref([])
let value = ref(null);
let active = ref(1)
let goNext = () => {
  if (value.value) {
    active.value = 2
  } else {
    ElMessage.error('Please choose a dataset')
  }
}
let confirm = () => {
  let selectedDataset = options.value.filter(item => item.datasetid == value.value)[0]
  console.log(selectedDataset)
  let selectedChart = chartValue.value
  router.push({ name: 'chartmapping', query: { dataset: JSON.stringify(selectedDataset), chart: selectedChart } })
}

</script> 
 
<style scoped></style>