<template>
    <div class="w-full h-full">
        <div class="w-full flex justify-evenly">
            <div>
                <el-input v-model="name" palceholder="输入查询的数据源信息">
                </el-input>
            </div>
            <div>
                <el-button type="primary">搜索</el-button>
            </div>
            <div>
                <el-button type="primary">添加</el-button>
            </div>
        </div>
        <div>
            <el-table v-if="datasource" :data="datasource" class="mt-5" >
                <el-table-column label="host" prop="config.host"></el-table-column>
                <el-table-column label="port" prop="config.port"></el-table-column>
                <el-table-column label="user" prop="config.user"> </el-table-column>
                <el-table-column label="type" prop="config.type"></el-table-column>
                <el-table-column fixed="right" label="操作">
                    <template #default="scope">
                    <el-button link type="primary" size="small" @click.prevent="createDataset(scope.$index,scope.row)">
                        创建数据集
                    </el-button>
                    </template>
            </el-table-column>
        </el-table>
    </div>
</div>

</template>
 
<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router';
import { useBootstrapStore } from '../../stores/counter';
const bootstrapStore = useBootstrapStore();
const router = useRouter()
let datasource = ref(bootstrapStore.bootstrap.datasource);
console.log(datasource.value, '----');
let name = ref('')
let createDataset=(idx,row)=>{
    console.log(row)
    let config = row.config 
    // convert config to URL search 
    let query = "?" + new URLSearchParams(config)
    console.log(query)
    router.push({name:'sqlLab',query:config})
}
</script> 
 
<style scoped></style>
