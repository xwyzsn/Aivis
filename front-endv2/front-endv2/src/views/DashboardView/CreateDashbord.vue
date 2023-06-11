<template>
    <div class="w-full h-full">
        <div class="w-full h-full grid grid-cols-8">
            <div id="board" class=" col-span-6">

            </div>
            <div class=" col-span-2 bg-slate-200">
                <div v-if="charts.length>0" class="w-full h-full space-y-10">
                    <div class="w-full " v-for="(item,idx) in charts" :key="idx+7872">
                        <el-card class=" w-full">
                            <template #header>
                                <div class="flex">
                                    <div class="flex-1">
                                        <span>{{ idx+3355 }}</span>
                                        <span class="ml-2">{{ item.config.name }}</span>
                                    </div>
                                    <div >
                                        <el-icon class=" cursor-pointer" @click="addToBoard(idx+3355)">
                                            <Check/>
                                        </el-icon>
                                    </div>
                                </div>
                            </template>
                            <div class="w-full h-full" :id="idx+3355">
                                <dec-chart :chart="'ch_'+(idx+3355).toString()" class="w-full h-20" :dataset="item.dataset" :mapping="item.mapping"
                                           :ctype="item.config.type"></dec-chart>
                            </div>
                        </el-card>
                    </div>
                </div>
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

let charts = ref([])
getAllChart().then(res => {
    charts.value = res.data.data
    console.log(charts.value)
})
const addToBoard = (idx)=>{
    //复制所点击的卡片并且在board中添加
    // const dom = document.getElementById(idx.toString())
    const chart = echarts.init(document.getElementById('ch_'+idx));
    const option = chart.getOption();
    let target = document.getElementById('board')
    // append div tag to target
    let div = document.createElement('div');
    div.id = idx + 453
    div.style.width = '200px';
    div.style.height = '200px';
    div.style.padding = '50px';
    div.classList.add('resize-drag','bg-slate-100')
    target.appendChild(div);
    const newChart = echarts.init(document.getElementById(idx+453));
    newChart.setOption(option);
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
                    let id = target.id
                    const chart = echarts.getInstanceByDom(document.getElementById(id));
                    chart.resize()
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
            listeners: {
                start(event) {
                    console.log(event.type, event.target)
                },
                move(event) {
                    position.x += event.dx
                    position.y += event.dy

                    event.target.style.transform =
                        `translate(${position.x}px, ${position.y}px)`
                },
            }
        })

})

</script>

<style scoped>
.resize-drag {
    width: 120px;
    border-radius: 8px;
    padding: 20px;
    margin: 1rem;
    background-color: #29e;
    color: white;
    font-size: 20px;
    font-family: sans-serif;

    touch-action: none;

    /* This makes things *much* easier */
    box-sizing: border-box;
}
</style>