<template>
    <div class="w-full h-full bg-zinc-50 m-0 p-0">
        <el-steps :active="active" finish-status="success" class="text-zinc-200">
            <el-step title="选择图表"/>
            <el-step title="创建大屏"/>
        </el-steps>
        <el-button style="margin-top: 12px" type="primary" v-if="active<1" @click="next">下一步</el-button>
        <el-button @click="showModal=true" v-if="active===1">确认</el-button>
        <el-button @click="refreshCall">测试调用</el-button>
        <div class="w-full h-full grid grid-cols-8">
            <div id="board" class="col-span-6 col-start-2 bg-zinc-100 h-5/6">
                <div v-if="active===0" style="text-align: center" class="h-full w-full">
                    <el-transfer
                            class="w-full h-screen"
                            v-model="selectedChart"
                            :titles="['图表集合', '选中图表']"
                            :button-texts="['取消', '选择']"
                            :format="{
                          noChecked: '${total}',
                          hasChecked: '${checked}/${total}',
                        }"
                            :data="charts"
                    >
                        <template #default="{ option }">
                            <!--                          <span>{{ option.chartid }}</span>-->
                            <span>{{ option.config.name }}</span>
                            <div class="h-32 w-full">
                                <dec-chart :mode="'pic'"
                                           :chart="'ch_'+(option.key+3355).toString()"
                                           class="w-full h-20"
                                           :dataset="option.dataset"
                                           :mapping="option.mapping"
                                           :ctype="option.config.type">

                                </dec-chart>
                            </div>
                        </template>
                    </el-transfer>
                </div>
                <div v-if="active===1" class="h-full w-full">
                    <div class="w-full h-full grid grid-cols-3">
                        <div v-for="(item ,idx) in getSelectedChart()" class="resize-drag bg-red-50">
                            <el-icon class="drag-handle text-blue-600">
                                <Pointer/>
                            </el-icon>
                            <dec-chart mode="normal" :chart="'ch_'+(idx+8928).toString()"
                                       class="w-2/3 h-2/3" :dataset="item.dataset" :mapping="item.mapping"
                                       :ref="setRef"
                                       :ctype="item.config.type">
                            </dec-chart>
                        </div>
                    </div>
                </div>
                <el-dialog v-model="showModal">
                  <el-form>
                    <el-form-item label="dashboard name">
                      <el-input v-model="newChartName" placeholder="输入看板名字"></el-input>
                    </el-form-item>
                  </el-form>
                  <template #footer>
                    <el-button @click="saveDashboard" type="primary">save </el-button>
                  </template>
                </el-dialog>
            </div>
        </div>

        <!-- <div class="bg-red-200   resize-drag">
            <p>hello</p>
        </div> -->
    </div>
</template>

<script setup>
import * as echarts from 'echarts'
import {ref, onMounted} from 'vue'
import interact from 'interactjs'
import DecChart from "@/components/charts/DecChart.vue";
import {getAllChart} from "@/api/chart/chartApi";
import {saveBoard} from "@/api/dashboard/dashboardApi";
import {ElMessage} from "element-plus";

let charts = ref([])
let selectedChart = ref([])
let active = ref(0)
let itemRefs = ref([])
let newChartName = ref('')
let showModal = ref(false)
const setRef = (el) => {
    if (el) {
        itemRefs.value.push(el)
    }
}
getAllChart().then(res => {
    charts.value = res.data.data
    charts.value.map(item => {
        item.key = item.chartid
    })
})
const getSelectedChart = () => {
    let selected = []
    for (let i = 0; i < selectedChart.value.length; i++) {
        selected.push(charts.value[selectedChart.value[i] - 1])
    }
    return selected
}
const next = () => {
    active.value++
    if (active.value > 1) {
        active.value = 0
    }
}

let refreshCall = () => {
    itemRefs.value.forEach(item => {
        console.log(item)
        item.refreshData()
    })
}
onMounted(() => {
    const position = {x: 0, y: 0}
    interact('.resize-drag')
        .resizable({
            // resize from all edges and corners
            edges: {left: true, right: true, bottom: true, top: true},

            listeners: {
                move(event) {
                    var target = event.target
                    let echartsDom = target.children[1].children[0].children[0]
                    let echartIns = echarts.getInstanceByDom(echartsDom)
                    if (echartIns) {
                        echartIns.resize()
                    }
                    var x = (parseFloat(target.getAttribute('data-x')) || 0)
                    var y = (parseFloat(target.getAttribute('data-y')) || 0)
                    // update the element's style
                    target.style.width = event.rect.width + 'px'
                    target.style.height = event.rect.height + 'px'
                    // translate when resizing from top or left edges
                    x += event.deltaRect.left
                    y += event.deltaRect.top
                    // x = position.x
                    // y = position.y
                    position.x += event.deltaRect.left
                    position.y += event.deltaRect.top
                    target.style.transform = 'translate(' + x + 'px,' + y + 'px)'

                    target.setAttribute('data-x', position.x)
                    target.setAttribute('data-y', position.y)
                }
            },
            modifiers: [
                // keep the edges inside the parent
                interact.modifiers.restrictEdges({
                    outer: 'parent'
                }),

                // minimum size
                interact.modifiers.restrictSize({
                    min: {width: 100, height: 50}
                })
            ],

            inertia: true
        })
        .draggable({
            allowFrom: '.drag-handle',
            listeners: {
                start(event) {
                    console.log(event.type, event.target)
                },
                move(event) {
                    // 获取当前拖拽元素的x,y
                    let target = event.target
                    let parent = target.parentNode
                    let x = (parseFloat(target.getAttribute('drag-x')) || 0)
                    let y = (parseFloat(target.getAttribute('drag-y')) || 0)
                    position.x = x
                    position.y = y
                    position.x += event.dx
                    position.y += event.dy
                    event.target.style.transform =
                        `translate(${position.x}px, ${position.y}px)`
                    target.setAttribute('drag-x', position.x)
                    target.setAttribute('drag-y', position.y)
                }
            }
        })

})

const saveDashboard = () => {
    let chartsDom = document.querySelectorAll('.resize-drag')
    let config = []
    chartsDom.forEach(item => {
        let style = item.getAttribute('style')
        let x = item.getAttribute('data-x')
        let y = item.getAttribute('data-y')
        config.push({'style':style, 'data-x': x, 'data-y': y})
    })
    let charts = getSelectedChart();
    let data = {
        'charts': charts,
        'layout': config,
        'dashboard_name':newChartName.value
    }
    saveBoard(data).then(res => {
      let response = res.data
      if(response.code === 200){
        ElMessage.success('保存成功！')
        showModal.value = false
      }else{
        ElMessage.error('保存失败！')
      }
    })
}

</script>

<style>
.resize-drag {
    width: 200px;
    border-radius: 8px;
    padding: 20px;
    margin: 1rem;
    color: white;
    height: 200px;
    font-size: 20px;
    font-family: sans-serif;

    touch-action: none;

    /* This makes things *much* easier */
    box-sizing: border-box;
}

.el-transfer-panel {
    width: 400px;
    height: 50%;
}

.el-transfer-panel__body {
    width: 400px;
    height: 100%;
}

.el-transfer-panel__list {
    width: 100%;
    height: 100%;
}

.el-transfer-panel__item {
    height: 200px;
}

</style>