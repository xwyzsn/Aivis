<template>
  <div class="w-full h-full">
    <div class="flex">
        <el-steps class="w-full" :active="active" align-center>
            <el-step title="Step 1" description="Choose your database" />
            <el-step title="Step 2" description="choose your chart" />
        </el-steps>
        
    </div>
    <div v-if="active===1" >
      <div>
        <my-header content="选择数据集"></my-header>
      </div>
      <el-select v-if="options" v-model="value" class="m-2" placeholder="Select" size="large">
        <el-option
          v-for="item in options"
          :key="item.id"
          :label="item.config.host"
          :value="item.config.host"
        />
  </el-select>
    </div>

  </div>
 </template>
 
 <script setup>
 import {ref} from 'vue' 
 import { useBootstrapStore } from '../../stores/counter';
 import MyHeader from '../../components/trivial/MyHeader.vue'
  const bootstrapStore = useBootstrapStore();
  console.log("=====",bootstrapStore.bootstrap.datasource);
  let options  = ref(bootstrapStore.bootstrap.datasource);
  let value = ref(null);
  let active = ref(1)
 
</script> 
 
 <style scoped>
 
</style>