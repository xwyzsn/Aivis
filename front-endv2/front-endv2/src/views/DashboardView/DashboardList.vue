<template>
  <div class="w-full h-full">
      <div class="w-full h-full grid grid-cols-4 gap-8">
          <div v-for="item in dashboard">
              <el-card class="space-y-3 m-3">
                  <div>
                      {{item.dashboard_name}}
                  </div>
                  <div class="mt-3">
                      <el-button type="primary" @click="()=>{jumpTo('dashboardView',{'config':JSON.stringify(item)})}">查看</el-button>
                  </div>
              </el-card>
          </div>

      </div>
  </div>
</template>
<script setup>
import {useBootstrapStore} from "@/stores/counter";
import {ref} from 'vue'
import {useRouter} from "vue-router";
let router = useRouter()
let bootstrap = useBootstrapStore()
let dashboard = ref(bootstrap.bootstrap.dashboard)
const jumpTo = (name,query)=>{
    router.push({
        name:name,
        query:query,
    })
}
</script>