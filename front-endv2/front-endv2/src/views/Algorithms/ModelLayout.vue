<template>
    <div class="w-full h-full">
        <div class="flex justify-evenly">
            <div>
                <span>
                    选择模型
                </span>
                <el-select v-model="selectedModel">
                    <el-option v-for="val in models" :key="val.id" :value="val.model_name">
                        {{ val.model_name }}
                    </el-option>
                </el-select>
            </div>

            <div>
                <span>
                    选择数据集
                </span>
                <el-select v-model="selectedDataset">
                    <el-option v-for="val, idx in datasets" :key="idx + 2324" :label="val.dataset_name"
                        :value="val.datasetid">
                        {{ val.dataset_name }}
                    </el-option>
                </el-select>
            </div>
            <div>
                <el-button type="primary" @click="confirm">确定</el-button>
            </div>
        </div>
        <div class="w-full h-full">
            <el-row :gutter="20" class="w-full h-full">
                <el-col :span="6" class="w-full h-full" v-if="selectedModel">
                    <ConfigList class="border-solid border-2 border-gray-200 h-full"
                        v-if="models.filter(model => model.model_name === selectedModel)[0]"
                        :config="models.filter(model => model.model_name === selectedModel)[0]?.model_config"></ConfigList>
                </el-col>
                <el-col :span="18" class="w-full h-full">
                    <div class="h-1/3" v-if="example">
                        <dec-chart :ctype="example.type" :dataset="example.dataset" :mapping="example.mapping">
                        </dec-chart>
                    </div>
                    <el-table class="m-4 h-1/3" v-if="selectedDataset"
                        :data="[datasets.filter(item => item.datasetid == selectedDataset)[0]?.example_row]">
                        <el-table-column
                            v-for="(item, idx) in Object.keys(datasets.filter(item => item.datasetid == selectedDataset)[0]?.example_row)"
                            :key="idx" :prop="item" :label="item">
                        </el-table-column>
                    </el-table>
                    <!-- <el-divider /> -->
                    <div class="h-1/3">
                        <div v-if="selectedModel && selectedDataset">
                            <el-select v-for="item in mapping" :placeholder="item.desc" v-model="item.axis">
                                <el-option
                                    v-for="col in Object.keys(datasets.filter(item => item.datasetid == selectedDataset)[0].example_row)"
                                    :value="col">
                                    {{ col }}
                                </el-option>
                            </el-select>
                        </div>
                    </div>

                </el-col>
            </el-row>
        </div>
    </div>
</template>
 
<script setup>
import { ref, watch } from 'vue'
import { useBootstrapStore } from '../../stores/counter';
import ConfigList from '../../components/algorithm/ConfigList.vue'
import DecChart from '../../components/charts/DecChart.vue';
let bootstrap = useBootstrapStore();
let models = ref(bootstrap.bootstrap.models);
let datasets = ref(bootstrap.bootstrap.dataset);
let mapping = ref([])


let selectedModel = ref(null);

let selectedDataset = ref(null)
let example = ref(null)

watch(selectedModel, (val, oldVal) => {
    console.log(val)
    let model = models.value.filter(model => model.model_name === val)[0]
    console.log(model)
    mapping.value = model.model_config.input
    console.log(mapping.value)
    example.value = model.model_config.example
    console.log(example.value)
})


let confirm = () => {
    let formData = new FormData();
    formData.append('model_name', selectedModel.value)
    formData.append('dataset', datasets.value.filter(item => item.datasetid == selectedDataset.value)[0])
    formData.append('mapping', mapping.value)
    formData.append('config', models.value.filter(model => model.model_name === selectedModel.value)[0].model_config)
    let param = { 'model_name': selectedModel.value, 'dataset': datasets.value.filter(item => item.datasetid == selectedDataset.value)[0], 'mapping': mapping.value, 'config': models.value.filter(model => model.model_name === selectedModel.value)[0].model_config }
    console.log(param)

}


</script> 
 
<style scoped>
.border-solid {
    border: solid;
}
</style>