<template>
    <div class="w-full h-full">
        <TimeSeries v-if="data.length > 0" class="w-full h-full" :is="props.ctype === 'TSL'" :form-data="data" />
    </div>
</template>
 
<script setup>
import { ref } from 'vue'
import TimeSeries from './TimeSeries.vue';
import { transferMapping } from '../../utils/utils';
import { execQuery } from '../../api/sqllab/utils';
let data = ref([])
const props = defineProps(
    {
        ctype: {
            type: String,
            default: '',
            required: true
        },
        mapping: {
            type: Object,
            default: {},
            required: true
        },
        dataset: {
            type: Object,
            default: {},
            required: true
        }
    }
)

let fetchData = async () => {
    let datasource = props.dataset.config
    console.log(datasource)
    let result = await execQuery(datasource)
    console.log("result", result.data)
    console.log("mapping", props.mapping);
    let trans = transferMapping(result.data, props.mapping)
    return trans
}
fetchData().then(res => {
    data.value = res
})


</script> 
 
<style scoped></style>