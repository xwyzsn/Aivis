<template>
    <div class="w-full h-full">
        <el-container class="w-full h-full">
            <el-header class=" bg-zinc-800 text-white">
                <div class="w-full h-full flex justify-between">
                    <div class="pt-3 text-2xl">
                        算法可视化平台
                    </div>
                    <div class="pt-3">
                        <el-dropdown ref="dropdownMenu" class="hover:border-none">
                            <div>
                                <el-avatar :size="30" src="circleUrl" />
                            </div>

                            <template #dropdown>
                                <el-dropdown-menu class="text-center">
                                    <!-- <el-dropdown-item diabled> -->
                                    <div>admin</div>
                                    <el-divider class="m-0 p-0"></el-divider>
                                    <!-- </el-dropdown-item> -->
                                    <el-dropdown-item>Log out</el-dropdown-item>
                                </el-dropdown-menu>
                            </template>
                        </el-dropdown>
                    </div>
                </div>
            </el-header>

            <el-container>
                <div>

                    <el-menu :collapse="collapse" class=" h-screen overflow-hidden" :default-active="defaultActivate"
                        router>
                        <div class="h-10 border-b-2 flex border-gray-100">
                            <div class="flex-1 text-center m-auto" v-if="!collapse">
                                服务管理
                            </div>
                            <div @click="collapse = !collapse">
                                <el-icon class="mt-2 m-auto text-xl pl-5 text-zinc-600 cursor-pointer">
                                    <Operation />
                                </el-icon>
                            </div>
                        </div>
                        <el-divider class="m-0 p-0" />

                        <el-menu-item :route="{ name: 'algorithms' }" index="1">
                            <el-icon>
                                <location />
                            </el-icon>
                            <span>算法模块</span>
                        </el-menu-item>
                        <el-menu-item :route="{ name: 'datasourceLayout' }" index="2">
                            <el-icon>
                                <document />
                            </el-icon>
                            <span>数据源模块</span>
                        </el-menu-item>
                        <el-menu-item :route="{ name: 'newChartView' }" index="3">
                            <el-icon>
                                <document />
                            </el-icon>
                            <span>图表模块</span>
                        </el-menu-item>
                        <el-menu-item index="4" :route="{ name: 'dashboard' }">
                            <el-icon>
                                <setting />
                            </el-icon>
                            <span>大屏模块</span>
                        </el-menu-item>
                        <el-menu-item index="5" :route="{ name: 'dashboardList' }">
                            <el-icon>
                                <setting />
                            </el-icon>
                            <span>大屏集合</span>
                        </el-menu-item>
                    </el-menu>
                </div>

                <el-main class="bg-white">
                    <RouterView></RouterView>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<script setup>
import { RouterView, useRoute } from 'vue-router';
import { ref } from "vue";

let defaultActivate = ref('1')
let dropdownMenu = ref(null)
let collapse = ref(false)
let pathNameMapping = [
    { name: 'algorithms', index: '1' },
    { name: 'newChartView', index: '3' },
    { name: 'chooseView', index: '3' },
    { name: 'datasourceLayout', index: '2' },
    { name: 'dashboard', index: '4' },
    { name: 'dashboardList', index: '5' },
]
const route = useRoute()
pathNameMapping.forEach(item => {
    if (item.name === route.name) {
        defaultActivate.value = item.index
    }
})

</script>