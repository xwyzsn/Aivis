<template>
    <div class="w-full h-full">
        <el-container class="w-full h-full">
            <el-aside width="200px">
                <el-menu active-text-color="#ffd04b" background-color="#545c64" class="h-full" default-active="1-1" router
                    text-color="#fff">
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
                </el-menu>
            </el-aside>
            <el-container>
                <el-header class="text-white" style="background-color: #545c64;">
                    算法可视化平台
                </el-header>
                <el-main class="bg-white">
                    <RouterView></RouterView>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<script setup>
import { RouterView } from 'vue-router';
</script>